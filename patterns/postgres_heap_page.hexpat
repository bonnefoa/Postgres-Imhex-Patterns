#pragma author "Anthonin Bonnefoy"
#pragma description "PostgreSQL Heap Page Format"
#pragma little endian

import std.core;
import std.mem;
import std.string;

using TransactionId = u32;
using XLogRecPtr = u64 [[format("format_xlogrecptr")]];
using OffsetNumber = u16;

fn format_xlogrecptr(auto rec_ptr) {
    return std::format("{:X}/{:X}", rec_ptr >> 32, rec_ptr & 0xffffffff);
};

struct PageHeaderData {
  XLogRecPtr pd_lsn;
  u16 pd_checksum;
  u16 pd_flags;
  u16 pd_lower;
  u16 pd_upper;
  u16 pd_special;
  u16 pd_pagesize_version;
  TransactionId pd_prune_xid;
};

struct BlockIdData {
  u16 bi_hi;
  u16 bi_lo;
} [[format("format_blk_id")]];

fn format_blk_id(auto blk) {
    auto blk_id = blk.bi_hi << 16 + blk.bi_lo;
    return std::format("{}", blk_id);
};

struct ItemPointerData {
  BlockIdData blkid;
  OffsetNumber posid;
} [[format("format_item_pointer_data")]];

fn format_item_pointer_data(auto ptr) {
    return std::format("({},{})", ptr.blkid, ptr.posid);
};

enum LP_FLAGS : u8 {
    UNUSED = 0,
    NORMAL = 1,
    REDIRECT = 2,
    DEAD = 3,
};

bitfield t_infomask {
  hasnull         :1;
  hasvarwidth     :1;
  hasexternal     :1;
  hasoid          :1;
  xmax_keyshr_lock:1;
  combo_cid       :1;
  xmax_excl_lock  :1;
  xmax_lock_only  :1;
  xmin_committed  :1;
  xmin_invalid    :1;
  xmax_committed  :1;
  xmax_invalid    :1;
  xmax_is_multi   :1;
  updated         :1;
  moved_off       :1;
  moved_in        :1;
} [[fixed_size(2)]];

bitfield t_infomask2 {
  natts           : 11;
  keys_updated    : 1;
  hot_updated     : 1;
  only_tuple      : 1;
} [[fixed_size(2)]];

struct HeapTupleHeaderData {
  TransactionId t_xmin;
  TransactionId t_xmax;
  u32 t_cid;
  ItemPointerData t_ctid;
  t_infomask2 t_infomask2;
  t_infomask t_infomask;
  u8 t_hoff;
  if (t_infomask.hasnull > 0) {
    u8 t_bits[1 + t_infomask2.natts / 8];
  }
};

fn relative_to_page_start(u32 pointer) {
    auto page_start = addressof(parent.parent.parent);
    auto offset_from_page_start = page_start + (pointer & 0x7fff);
    // pointer_base will add pointer to the result,
    // substract it to have the correct address
    return offset_from_page_start - pointer;
};

bitfield LinePointerHeader {
  off   : 15;
  flags : 2;
  len   : 15;
} [[inline, format("format_lp_header")]];

fn lp_flags_to_str(auto lp_flags) {
  match (lp_flags) {
    (LP_FLAGS::UNUSED): return "UNUSED";
    (LP_FLAGS::NORMAL): return "NORMAL";
    (LP_FLAGS::REDIRECT): return "REDIRECT";
    (LP_FLAGS::DEAD): return "DEAD";
    (_): return "UNKNOWN";
  }
};

fn format_lp_header(auto lp) {
    return std::format("off: {}, {}, len: {}", lp.off, lp_flags_to_str(lp.flags), lp.len);
};

struct HeapTupleData {
  HeapTupleHeaderData header;
  std::mem::AlignTo<8>;
  u8 data[parent.hdr.len - ($ - addressof(header))];
}[[format("format_heap_tuple_data")]];

fn format_heap_tuple_data(auto tpl) {
    return std::format("{}", tpl.header.t_ctid);
};

struct LinePointer {
  LinePointerHeader hdr;

  if (hdr.len > 0) {
    $ = $ - 4;
    HeapTupleData *heap_data : u32 [[pointer_base("relative_to_page_start"), inline]];
  }
} [[format("format_lp")]];

fn format_lp(auto lp) {
  return std::format("{}", lp.hdr);
};

struct Page {
  PageHeaderData header;

  // Read line pointers until we reach the start of free space
  LinePointer line_pointers[while (($ - addressof(header)) < header.pd_lower)];
} [[fixed_size(8192)]];

Page pages[while (!std::mem::eof())] @$;
