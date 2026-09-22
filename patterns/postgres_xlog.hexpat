#pragma author "Anthonin Bonnefoy"
#pragma description "PostgreSQL WAL (Write-Ahead Log) Format"
#pragma little endian
#pragma magic [0D D1] @ 0x00
#pragma magic [1? D1] @ 0x00
#pragma magic [2? D1] @ 0x00
#pragma magic [FF D1] @ 0x00
#pragma pattern_limit 0x80000000

#define XLR_MAX_BLOCK_ID 32
#define XLR_BLOCK_ID_DATA_SHORT   255
#define XLR_BLOCK_ID_DATA_LONG    254
#define XLR_BLOCK_ID_ORIGIN       253
#define XLR_BLOCK_ID_TOPLEVEL_XID 252
#define XLR_INFO_MASK    0x0F

#define XLOG_CHECKPOINT_SHUTDOWN        0x00
#define XLOG_CHECKPOINT_ONLINE          0x10
#define XLOG_NOOP                       0x20
#define XLOG_NEXTOID                    0x30
#define XLOG_SWITCH                     0x40
#define XLOG_BACKUP_END                 0x50
#define XLOG_PARAMETER_CHANGE           0x60
#define XLOG_RESTORE_POINT              0x70
#define XLOG_FPW_CHANGE                 0x80
#define XLOG_END_OF_RECOVERY            0x90
#define XLOG_FPI_FOR_HINT               0xA0
#define XLOG_FPI                        0xB0
#define XLOG_OVERWRITE_CONTRECORD       0xD0
#define XLOG_CHECKPOINT_REDO            0xE0
#define XLOG_LOGICAL_DECODING_STATUS_CHANGE 0xF0

#define BKPBLOCK_HAS_IMAGE  0x10  /* block data is an XLogRecordBlockImage */
#define BKPBLOCK_HAS_DATA 0x20
#define BKPBLOCK_WILL_INIT  0x40  /* redo will re-init the page */
#define BKPBLOCK_SAME_REL 0x80  /* RelFileNode omitted, same as previous */


#define XLOG_XACT_COMMIT            0x00
#define XLOG_XACT_PREPARE           0x10
#define XLOG_XACT_ABORT             0x20
#define XLOG_XACT_COMMIT_PREPARED   0x30
#define XLOG_XACT_ABORT_PREPARED    0x40
#define XLOG_XACT_ASSIGNMENT        0x50
#define XLOG_XACT_INVALIDATIONS     0x60

#define XLOG_SMGR_CREATE    0x10
#define XLOG_SMGR_TRUNCATE  0x20
#define SMGR_TRUNCATE_HEAP  0x0001
#define SMGR_TRUNCATE_VM    0x0002
#define SMGR_TRUNCATE_FSM   0x0004
#define SMGR_TRUNCATE_ALL   (SMGR_TRUNCATE_HEAP|SMGR_TRUNCATE_VM|SMGR_TRUNCATE_FSM)

#define XLOG_HEAP_INSERT     0x00
#define XLOG_HEAP_DELETE     0x10
#define XLOG_HEAP_UPDATE     0x20
#define XLOG_HEAP_TRUNCATE   0x30
#define XLOG_HEAP_HOT_UPDATE 0x40
#define XLOG_HEAP_CONFIRM    0x50
#define XLOG_HEAP_LOCK       0x60
#define XLOG_HEAP_INPLACE    0x70

#define XLOG_HEAP2_REWRITE              0x00
#define XLOG_HEAP2_PRUNE_ON_ACCESS      0x10
#define XLOG_HEAP2_PRUNE_VACUUM_SCAN    0x20
#define XLOG_HEAP2_PRUNE_VACUUM_CLEANUP 0x30
#define XLOG_HEAP2_VISIBLE              0x40
#define XLOG_HEAP2_MULTI_INSERT         0x50
#define XLOG_HEAP2_LOCK_UPDATED         0x60
#define XLOG_HEAP2_NEW_CID              0x70

#define XLOG_HEAP_INIT_PAGE             0x80

#define XLH_INSERT_ALL_VISIBLE_CLEARED  (1<<0)
#define XLH_INSERT_LAST_IN_MULTI        (1<<1)
#define XLH_INSERT_IS_SPECULATIVE       (1<<2)
#define XLH_INSERT_CONTAINS_NEW_TUPLE   (1<<3)
#define XLH_INSERT_ON_TOAST_RELATION    (1<<4)
#define XLH_INSERT_ALL_FROZEN_SET       (1<<5)

#define XLH_UPDATE_OLD_ALL_VISIBLE_CLEARED  (1<<0)
#define XLH_UPDATE_NEW_ALL_VISIBLE_CLEARED  (1<<1)
#define XLH_UPDATE_CONTAINS_OLD_TUPLE       (1<<2)
#define XLH_UPDATE_CONTAINS_OLD_KEY         (1<<3)
#define XLH_UPDATE_CONTAINS_NEW_TUPLE       (1<<4)
#define XLH_UPDATE_PREFIX_FROM_OLD          (1<<5)
#define XLH_UPDATE_SUFFIX_FROM_OLD          (1<<6)

#define XLH_DELETE_ALL_VISIBLE_CLEARED      (1<<0)
#define XLH_DELETE_CONTAINS_OLD_TUPLE       (1<<1)
#define XLH_DELETE_CONTAINS_OLD_KEY         (1<<2)
#define XLH_DELETE_IS_SUPER                 (1<<3)
#define XLH_DELETE_IS_PARTITION_MOVE        (1<<4)

#define XLH_TRUNCATE_CASCADE                (1<<0)
#define XLH_TRUNCATE_RESTART_SEQS           (1<<1)

#define XLH_LOCK_ALL_FROZEN_CLEARED         (1<<0)

#define XLHL_XMAX_IS_MULTI                  0x01
#define XLHL_XMAX_LOCK_ONLY                 0x02
#define XLHL_XMAX_EXCL_LOCK                 0x04
#define XLHL_XMAX_KEYSHR_LOCK               0x08
#define XLHL_KEYS_UPDATED                   0x10

#define XLH_FREEZE_XVAC                     0x02
#define XLH_INVALID_XVAC                    0x04

#define   XLHP_IS_CATALOG_REL         (1 << 1)
#define   XLHP_CLEANUP_LOCK           (1 << 2)
#define   XLHP_HAS_CONFLICT_HORIZON   (1 << 3)

#define XLOG_HEAP_OPMASK            0x70
#define XLOG_HEAP2_OPMASK           0x70
#define XLOG_XACT_OPMASK            0x70

#define XLOG_XACT_HAS_INFO          0x80

#define XACT_XINFO_HAS_DBINFO           (1 << 0)
#define XACT_XINFO_HAS_SUBXACTS         (1 << 1)
#define XACT_XINFO_HAS_RELFILELOCATORS  (1 << 2)
#define XACT_XINFO_HAS_INVALS           (1 << 3)
#define XACT_XINFO_HAS_TWOPHASE         (1 << 4)
#define XACT_XINFO_HAS_ORIGIN           (1 << 5)
#define XACT_XINFO_HAS_AE_LOCKS         (1 << 6)
#define XACT_XINFO_HAS_GID              (1 << 7)
#define XACT_XINFO_HAS_DROPPED_STATS    (1 << 8)

#define XLOG_STANDBY_LOCK       0x00
#define XLOG_RUNNING_XACTS      0x10
#define XLOG_INVALIDATIONS      0x20

#define XLOG_BTREE_INSERT_LEAF	0x00	/* add index tuple without split */
#define XLOG_BTREE_INSERT_UPPER 0x10	/* same, on a non-leaf page */
#define XLOG_BTREE_INSERT_META	0x20	/* same, plus update metapage */
#define XLOG_BTREE_SPLIT_L		0x30	/* add index tuple with split */
#define XLOG_BTREE_SPLIT_R		0x40	/* as above, new item on right */
#define XLOG_BTREE_INSERT_POST	0x50	/* add index tuple with posting split */
#define XLOG_BTREE_DEDUP		0x60	/* deduplicate tuples for a page */
#define XLOG_BTREE_DELETE		0x70	/* delete leaf index tuples for a page */
#define XLOG_BTREE_UNLINK_PAGE	0x80	/* delete a half-dead page */
#define XLOG_BTREE_UNLINK_PAGE_META 0x90	/* same, and update metapage */
#define XLOG_BTREE_NEWROOT		0xA0	/* new root page */
#define XLOG_BTREE_MARK_PAGE_HALFDEAD 0xB0	/* mark a leaf as half-dead */
#define XLOG_BTREE_VACUUM		0xC0	/* delete entries on a page during vacuum */
#define XLOG_BTREE_REUSE_PAGE	0xD0	/* old page is about to be reused from FSM */
#define XLOG_BTREE_META_CLEANUP	0xE0	/* update cleanup-related data in the metapage */

#define CLOG_ZEROPAGE           0x00
#define CLOG_TRUNCATE           0x10

#define XLOG_DBASE_CREATE_FILE_COPY  0x00
#define XLOG_DBASE_CREATE_WAL_LOG    0x10
#define XLOG_DBASE_DROP              0x20

#define XLOG_TBLSPC_CREATE      0x00
#define XLOG_TBLSPC_DROP        0x10

#define XLOG_MULTIXACT_ZERO_OFF_PAGE  0x00
#define XLOG_MULTIXACT_ZERO_MEM_PAGE  0x10
#define XLOG_MULTIXACT_CREATE_ID      0x20
#define XLOG_MULTIXACT_TRUNCATE_ID    0x30

#define XLOG_RELMAP_UPDATE      0x00

#define XLOG_HASH_INIT_META_PAGE      0x00
#define XLOG_HASH_INIT_BITMAP_PAGE    0x10
#define XLOG_HASH_INSERT              0x20
#define XLOG_HASH_ADD_OVFL_PAGE       0x30
#define XLOG_HASH_SPLIT_ALLOCATE_PAGE 0x40
#define XLOG_HASH_SPLIT_PAGE          0x50
#define XLOG_HASH_SPLIT_COMPLETE      0x60
#define XLOG_HASH_MOVE_PAGE_CONTENTS  0x70
#define XLOG_HASH_SQUEEZE_PAGE        0x80
#define XLOG_HASH_DELETE              0x90
#define XLOG_HASH_SPLIT_CLEANUP       0xA0
#define XLOG_HASH_UPDATE_META_PAGE    0xB0
#define XLOG_HASH_VACUUM_ONE_PAGE     0xC0
#define XLH_SPLIT_META_UPDATE_MASKS   (1<<0)
#define XLH_SPLIT_META_UPDATE_SPLITPOINT (1<<1)

#define XLOG_GIN_CREATE_PTREE   0x10
#define XLOG_GIN_INSERT        0x20
#define XLOG_GIN_SPLIT         0x30
#define XLOG_GIN_VACUUM_PAGE   0x40
#define XLOG_GIN_DELETE_PAGE   0x50
#define XLOG_GIN_UPDATE_META_PAGE 0x60
#define XLOG_GIN_INSERT_LISTPAGE  0x70
#define XLOG_GIN_DELETE_LISTPAGE  0x80
#define XLOG_GIN_VACUUM_DATA_LEAF_PAGE 0x90

#define XLOG_GIST_PAGE_UPDATE   0x00
#define XLOG_GIST_DELETE        0x10
#define XLOG_GIST_PAGE_REUSE    0x20
#define XLOG_GIST_PAGE_SPLIT    0x30
#define XLOG_GIST_PAGE_DELETE   0x60
#define XLOG_GIST_ASSIGN_LSN    0x70

#define XLOG_SEQ_LOG            0x00

#define XLOG_SPGIST_ADD_LEAF    0x10
#define XLOG_SPGIST_MOVE_LEAFS  0x20
#define XLOG_SPGIST_ADD_NODE    0x30
#define XLOG_SPGIST_SPLIT_TUPLE  0x40
#define XLOG_SPGIST_PICKSPLIT   0x50
#define XLOG_SPGIST_VACUUM_LEAF  0x60
#define XLOG_SPGIST_VACUUM_ROOT  0x70
#define XLOG_SPGIST_VACUUM_REDIRECT 0x80

#define XLOG_BRIN_CREATE_INDEX  0x00
#define XLOG_BRIN_INSERT        0x10
#define XLOG_BRIN_UPDATE        0x20
#define XLOG_BRIN_SAMEPAGE_UPDATE 0x30
#define XLOG_BRIN_REVMAP_EXTEND 0x40
#define XLOG_BRIN_DESUMMARIZE   0x50
#define XLOG_BRIN_OPMASK        0x70
#define XLOG_BRIN_INIT_PAGE     0x80

#define COMMIT_TS_ZEROPAGE      0x00
#define COMMIT_TS_TRUNCATE      0x10

#define XLOG_REPLORIGIN_SET     0x00
#define XLOG_REPLORIGIN_DROP    0x10

#define XLOG_LOGICAL_MESSAGE    0x00

#define SHAREDINVALCATALOG_ID   (-1)
#define SHAREDINVALRELCACHE_ID  (-2)
#define SHAREDINVALSMGR_ID      (-3)
#define SHAREDINVALRELMAP_ID    (-4)
#define SHAREDINVALSNAPSHOT_ID  (-5)
#define SHAREDINVALRELSYNC_ID   (-6)

#define USECS_PER_SEC 1000000
#define POSTGRES_EPOCH_JDATE  2451545
#define UNIX_EPOCH_JDATE    2440588
#define SECS_PER_DAY  86400

import hex.core;
import std.core;
import std.math;
import std.mem;
import std.string;
import type.magic;
import type.size;
import type.time;


fn format_xlogrecptr(auto rec_ptr) {
    return std::format("{:X}/{:08X}", rec_ptr >> 32, rec_ptr & 0xffffffff);
};

using TransactionId = u32;
using MultiXactId = TransactionId;
using Oid = u32;
using BlockNumber = u32;
using TimeLineID = u32;
using XLogRecPtr = u64 [[format("format_xlogrecptr")]];
using TimestampTz = u64 [[format("format_timestampTz")]];
using OffsetNumber = u16;
using pg_time_t = type::time64_t;
using CommandId = u32;
using FullTransactionId = u64;
using MultiXactOffset = u32;
using MultiXactOffset_PG19 = u64;
using RmgrId;

// Global variables
u32 global_page_size = 8192;
u32 main_data_length;
// Total data length of current record
u32 data_total;
u8 rmgr_info;
RmgrId rmgr_id;
u8 current_block;
u16 pg_version;
XLogRecPtr global_page_addr;

const u32 SizeOfXLogShortPHD = 24;

u32 buffer_end_addr;
u32 requested_data;

u32 limitRecords in;
u32 nrecords = 0;

struct BlockIdData {
  u16 bi_hi;
  u16 bi_lo;
};

struct ItemPointerData {
  BlockIdData ip_blkid;
  OffsetNumber ip_posid;
};

struct RelFileLocator {
    u32 spcOid;
    u32 dbOid;
    u32 relNumber;
} [[format("format_rel_file_locator")]];

fn format_rel_file_locator(auto rlocator) {
    return std::format("{}/{}/{}", rlocator.spcOid, rlocator.dbOid, rlocator.relNumber);
};

fn is_page() {
    u16 page_header = std::mem::read_unsigned($, 2);
    match (page_header) {
      (0xD10D): pg_version = 14;
      (0xD110): pg_version = 15;
      (0xD113): pg_version = 16;
      (0xD116): pg_version = 17;
      (0xD118): pg_version = 18;
      (0xD122): pg_version = 19;
      // 19 and 20 currently share the same magic number, use 0xD123 for now
      (0xD123): pg_version = 20;
      (_): return false;
    }
    return true;
};

fn format_timestampTz(u64 t) {
    type::time64_t result = t / USECS_PER_SEC +
              ((POSTGRES_EPOCH_JDATE - UNIX_EPOCH_JDATE) * SECS_PER_DAY);
    auto ms = t % USECS_PER_SEC / 1000;
    str date_part = std::time::format(std::time::to_utc(result), "%Y-%m-%dT%H:%M:%S");
    return std::format("{}.{:03}", date_part, ms);
};

bitfield ForkFlags {
    fork_number : 4;
    has_image   : 1;
    has_data    : 1;
    will_init   : 1;
    same_rel    : 1;
};

enum RmgrId: u8 {
    Xlog              = 0,
    Transaction       = 1,
    Storage           = 2,
    Clog              = 3,
    Database          = 4,
    Tablespace        = 5,
    MultiXact         = 6,
    RelMap            = 7,
    Standby           = 8,
    Heap2             = 9,
    Heap              = 10,
    Btree             = 11,
    Hash              = 12,
    Gin               = 13,
    Gist              = 14,
    Sequence          = 15,
    Spgist            = 16,
    Brin              = 17,
    CommitTs          = 18,
    ReplicationOrigin = 19,
    Generic           = 20,
    LogicalMsg        = 21,
};

fn format_rmgr_id(RmgrId rmgr_id) {
    match (rmgr_id) {
      (RmgrId::Xlog)              : return "Xlog";
      (RmgrId::Transaction)       : return "Transaction";
      (RmgrId::Storage)           : return "Storage";
      (RmgrId::Clog)              : return "Clog";
      (RmgrId::Database)          : return "Database";
      (RmgrId::Tablespace)        : return "Tablespace";
      (RmgrId::MultiXact)         : return "MultiXact";
      (RmgrId::RelMap)            : return "RelMap";
      (RmgrId::Standby)           : return "Standby";
      (RmgrId::Heap2)             : return "Heap2";
      (RmgrId::Heap)              : return "Heap";
      (RmgrId::Btree)             : return "Btree";
      (RmgrId::Hash)              : return "Hash";
      (RmgrId::Gin)               : return "Gin";
      (RmgrId::Gist)              : return "Gist";
      (RmgrId::Sequence)          : return "Sequence";
      (RmgrId::Spgist)            : return "Spgist";
      (RmgrId::Brin)              : return "Brin";
      (RmgrId::CommitTs)          : return "CommitTs";
      (RmgrId::ReplicationOrigin) : return "ReplicationOrigin";
      (RmgrId::Generic)           : return "Generic";
      (RmgrId::LogicalMsg)        : return "LogicalMsg";
      (_)                         : return "Unknown";
    }
};

fn record_identify(RmgrId rmgr_id, u8 rmgr_info) {
    u8 info = rmgr_info & ~XLR_INFO_MASK;
    match (rmgr_id) {
      (RmgrId::Xlog): {
        match (info) {
          (XLOG_PARAMETER_CHANGE)     : return "XLOG_PARAMETER_CHANGE";
          (XLOG_RESTORE_POINT)        : return "XLOG_RESTORE_POINT";
          (XLOG_OVERWRITE_CONTRECORD) : return "XLOG_OVERWRITE_CONTRECORD";
          (XLOG_BACKUP_END)           : return "XLOG_BACKUP_END";
          (XLOG_END_OF_RECOVERY)      : return "XLOG_END_OF_RECOVERY";
          (XLOG_CHECKPOINT_SHUTDOWN)  : return "XLOG_CHECKPOINT_SHUTDOWN";
          (XLOG_CHECKPOINT_REDO)      : return "XLOG_CHECKPOINT_REDO";
          (XLOG_CHECKPOINT_ONLINE)    : return "XLOG_CHECKPOINT_ONLINE";
          (XLOG_NOOP)                 : return "XLOG_NOOP";
          (XLOG_SWITCH)               : return "XLOG_SWITCH";
          (XLOG_FPW_CHANGE)           : return "XLOG_FPW_CHANGE";
          (XLOG_LOGICAL_DECODING_STATUS_CHANGE) : return "XLOG_LOGICAL_DECODING_STATUS_CHANGE";
          (XLOG_NEXTOID)              : return "XLOG_NEXTOID";
          (XLOG_FPI_FOR_HINT)         : return "XLOG_FPI_FOR_HINT";
          (XLOG_FPI)                  : return "XLOG_FPI";
        }
      }
      (RmgrId::Transaction): {
        match (info & XLOG_XACT_OPMASK) {
          (XLOG_XACT_COMMIT)        : return "XACT_COMMIT";
          (XLOG_XACT_ABORT)         : return "XACT_ABORT";
          (XLOG_XACT_PREPARE)       : return "XACT_PREPARE";
          (XLOG_XACT_ASSIGNMENT)    : return "XACT_ASSIGNMENT";
          (XLOG_XACT_INVALIDATIONS) : return "XACT_INVALIDATIONS";
        }
      }
      (RmgrId::Storage): {
        match (info) {
          (XLOG_SMGR_CREATE): return "SMGR_CREATE";
          (XLOG_SMGR_TRUNCATE): return "SMGR_TRUNCATE";
        }
      }
      (RmgrId::Clog): {
        match (info) {
          (CLOG_ZEROPAGE): return "CLOG_ZEROPAGE";
          (CLOG_TRUNCATE): return "CLOG_TRUNCATE";
        }
      }
      (RmgrId::Database): {
        match (info) {
          (XLOG_DBASE_CREATE_FILE_COPY): return "DBASE_CREATE_FILE_COPY";
          (XLOG_DBASE_CREATE_WAL_LOG): return "DBASE_CREATE_WAL_LOG";
          (XLOG_DBASE_DROP): return "DBASE_DROP";
        }
      }
      (RmgrId::Tablespace): {
        match (info) {
          (XLOG_TBLSPC_CREATE): return "TBLSPC_CREATE";
          (XLOG_TBLSPC_DROP): return "TBLSPC_DROP";
        }
      }
      (RmgrId::MultiXact): {
        match (info) {
          (XLOG_MULTIXACT_ZERO_OFF_PAGE): return "MULTIXACT_ZERO_OFF_PAGE";
          (XLOG_MULTIXACT_ZERO_MEM_PAGE): return "MULTIXACT_ZERO_MEM_PAGE";
          (XLOG_MULTIXACT_CREATE_ID): return "MULTIXACT_CREATE_ID";
          (XLOG_MULTIXACT_TRUNCATE_ID): return "MULTIXACT_TRUNCATE_ID";
        }
      }
      (RmgrId::RelMap): {
        match (info) {
          (XLOG_RELMAP_UPDATE): return "RELMAP_UPDATE";
        }
      }
      (RmgrId::Standby): {
        match (info) {
          (XLOG_STANDBY_LOCK): return  "STANDBY_LOCK";
          (XLOG_RUNNING_XACTS): return "RUNNING_XACTS";
          (XLOG_INVALIDATIONS): return "INVALIDATIONS";
        }
      }
      (RmgrId::Heap): {
        match (info & XLOG_HEAP_OPMASK) {
          (XLOG_HEAP_INSERT)     : return "HEAP_INSERT";
          (XLOG_HEAP_DELETE)     : return "HEAP_DELETE";
          (XLOG_HEAP_UPDATE)     : return "HEAP_UPDATE";
          (XLOG_HEAP_TRUNCATE)   : return "HEAP_TRUNCATE";
          (XLOG_HEAP_HOT_UPDATE) : return "HEAP_HOT_UPDATE";
          (XLOG_HEAP_CONFIRM)    : return "HEAP_CONFIRM";
          (XLOG_HEAP_LOCK)       : return "HEAP_LOCK";
          (XLOG_HEAP_INPLACE)    : return "HEAP_INPLACE";
        }
      }
      (RmgrId::Heap2): {
        match (info & XLOG_HEAP2_OPMASK) {
        (XLOG_HEAP2_REWRITE)              : return "HEAP2_REWRITE";
        (XLOG_HEAP2_PRUNE_ON_ACCESS)      : return "HEAP2_PRUNE_ON_ACCESS";
        (XLOG_HEAP2_PRUNE_VACUUM_SCAN)    : return "HEAP2_PRUNE_VACUUM_SCAN";
        (XLOG_HEAP2_PRUNE_VACUUM_CLEANUP) : return "HEAP2_PRUNE_VACUUM_CLEANUP";
        (XLOG_HEAP2_VISIBLE)              : return "HEAP2_VISIBLE";
        (XLOG_HEAP2_MULTI_INSERT)         : return "HEAP2_MULTI_INSERT";
        (XLOG_HEAP2_LOCK_UPDATED)         : return "HEAP2_LOCK_UPDATED";
        (XLOG_HEAP2_NEW_CID)              : return "HEAP2_NEW_CID";
        }
      }
      (RmgrId::Btree): {
        match (info) {
		      (XLOG_BTREE_INSERT_LEAF): return "BTREE_INSERT_LEAF";
		      (XLOG_BTREE_INSERT_UPPER): return "BTREE_INSERT_UPPER";
		      (XLOG_BTREE_INSERT_META): return "BTREE_INSERT_META";
		      (XLOG_BTREE_INSERT_POST): return "BTREE_INSERT_POST";
		      (XLOG_BTREE_SPLIT_L | XLOG_BTREE_SPLIT_R): return "BTREE_SPLIT_L ";
		      (XLOG_BTREE_DEDUP): return "BTREE_DEDUP";
		      (XLOG_BTREE_VACUUM): return "BTREE_VACUUM";
		      (XLOG_BTREE_DELETE): return "BTREE_DELETE";
		      (XLOG_BTREE_MARK_PAGE_HALFDEAD): return "BTREE_MARK_PAGE_HALFDEAD";
		      (XLOG_BTREE_UNLINK_PAGE): return "BTREE_UNLINK_PAGE";
		      (XLOG_BTREE_UNLINK_PAGE_META): return "BTREE_UNLINK_PAGE_META";
		      (XLOG_BTREE_NEWROOT): return "BTREE_NEWROOT";
		      (XLOG_BTREE_REUSE_PAGE): return "BTREE_REUSE_PAGE";
		      (XLOG_BTREE_META_CLEANUP): return "BTREE_META_CLEANUP";
        }
      }
      (RmgrId::Hash): {
        match (info) {
          (XLOG_HASH_INIT_META_PAGE)      : return "HASH_INIT_META_PAGE";
          (XLOG_HASH_INIT_BITMAP_PAGE)    : return "HASH_INIT_BITMAP_PAGE";
          (XLOG_HASH_INSERT)              : return "HASH_INSERT";
          (XLOG_HASH_ADD_OVFL_PAGE)       : return "HASH_ADD_OVFL_PAGE";
          (XLOG_HASH_SPLIT_ALLOCATE_PAGE) : return "HASH_SPLIT_ALLOCATE_PAGE";
          (XLOG_HASH_SPLIT_PAGE)          : return "HASH_SPLIT_PAGE";
          (XLOG_HASH_SPLIT_COMPLETE)      : return "HASH_SPLIT_COMPLETE";
          (XLOG_HASH_MOVE_PAGE_CONTENTS)  : return "HASH_MOVE_PAGE_CONTENTS";
          (XLOG_HASH_SQUEEZE_PAGE)        : return "HASH_SQUEEZE_PAGE";
          (XLOG_HASH_DELETE)              : return "HASH_DELETE";
          (XLOG_HASH_SPLIT_CLEANUP)       : return "HASH_SPLIT_CLEANUP";
          (XLOG_HASH_UPDATE_META_PAGE)    : return "HASH_UPDATE_META_PAGE";
          (XLOG_HASH_VACUUM_ONE_PAGE)     : return "HASH_VACUUM_ONE_PAGE";
        }
      }
      (RmgrId::Gin): {
        match (info) {
          (XLOG_GIN_CREATE_PTREE)          : return "GIN_CREATE_PTREE";
          (XLOG_GIN_INSERT)                : return "GIN_INSERT";
          (XLOG_GIN_SPLIT)                 : return "GIN_SPLIT";
          (XLOG_GIN_VACUUM_PAGE)           : return "GIN_VACUUM_PAGE";
          (XLOG_GIN_DELETE_PAGE)           : return "GIN_DELETE_PAGE";
          (XLOG_GIN_UPDATE_META_PAGE)      : return "GIN_UPDATE_META_PAGE";
          (XLOG_GIN_INSERT_LISTPAGE)       : return "GIN_INSERT_LISTPAGE";
          (XLOG_GIN_DELETE_LISTPAGE)       : return "GIN_DELETE_LISTPAGE";
          (XLOG_GIN_VACUUM_DATA_LEAF_PAGE) : return "GIN_VACUUM_DATA_LEAF_PAGE";
        }
      }
      (RmgrId::Gist): {
        match (info) {
          (XLOG_GIST_PAGE_UPDATE) : return "GIST_PAGE_UPDATE";
          (XLOG_GIST_DELETE)      : return "GIST_DELETE";
          (XLOG_GIST_PAGE_REUSE)  : return "GIST_PAGE_REUSE";
          (XLOG_GIST_PAGE_SPLIT)  : return "GIST_PAGE_SPLIT";
          (XLOG_GIST_PAGE_DELETE) : return "GIST_PAGE_DELETE";
          (XLOG_GIST_ASSIGN_LSN)  : return "GIST_ASSIGN_LSN";
        }
      }
      (RmgrId::Sequence): {
        match (info) {
          (XLOG_SEQ_LOG): return "SEQUENCE_LOG";
        }
      }
      (RmgrId::Spgist): {
        match (info) {
          (XLOG_SPGIST_ADD_LEAF)        : return "SPGIST_ADD_LEAF";
          (XLOG_SPGIST_MOVE_LEAFS)      : return "SPGIST_MOVE_LEAFS";
          (XLOG_SPGIST_ADD_NODE)        : return "SPGIST_ADD_NODE";
          (XLOG_SPGIST_SPLIT_TUPLE)     : return "SPGIST_SPLIT_TUPLE";
          (XLOG_SPGIST_PICKSPLIT)       : return "SPGIST_PICKSPLIT";
          (XLOG_SPGIST_VACUUM_LEAF)     : return "SPGIST_VACUUM_LEAF";
          (XLOG_SPGIST_VACUUM_ROOT)     : return "SPGIST_VACUUM_ROOT";
          (XLOG_SPGIST_VACUUM_REDIRECT) : return "SPGIST_VACUUM_REDIRECT";
        }
      }
      (RmgrId::Brin): {
        match (info & XLOG_BRIN_OPMASK) {
          (XLOG_BRIN_CREATE_INDEX)    : return "BRIN_CREATE_INDEX";
          (XLOG_BRIN_INSERT)          : return "BRIN_INSERT";
          (XLOG_BRIN_UPDATE)          : return "BRIN_UPDATE";
          (XLOG_BRIN_SAMEPAGE_UPDATE) : return "BRIN_SAMEPAGE_UPDATE";
          (XLOG_BRIN_REVMAP_EXTEND)   : return "BRIN_REVMAP_EXTEND";
          (XLOG_BRIN_DESUMMARIZE)     : return "BRIN_DESUMMARIZE";
        }
      }
      (RmgrId::CommitTs): {
        match (info) {
          (COMMIT_TS_ZEROPAGE): return "COMMIT_TS_ZEROPAGE";
          (COMMIT_TS_TRUNCATE): return "COMMIT_TS_TRUNCATE";
        }
      }
      (RmgrId::ReplicationOrigin): {
        match (info) {
          (XLOG_REPLORIGIN_SET): return  "REPLORIGIN_SET";
          (XLOG_REPLORIGIN_DROP): return "REPLORIGIN_DROP";
        }
      }
      (RmgrId::Generic): return "Generic";
      (RmgrId::LogicalMsg): {
        match (info) {
          (XLOG_LOGICAL_MESSAGE): return "LOGICAL_MESSAGE";
        }
      }
    }
    std::error(std::format("Unknown rmgrid: {}, info 0x{:X}", u8(rmgr_id), info));
};

bitfield ImageInfoFlags {
    has_hole    : 1;
    if (pg_version == 14) {
      compressed  : 1;
      apply       : 1;
      padding     : 5;
    } else {
      apply       : 1;
      compress_pglz : 1;
      compress_lz4 : 1;
      compress_zstd : 1;
      padding     : 3;
    }
};

struct XLogRecordBlockCompressHeader {
    u16 hole_length;
};

struct XLogRecordBlockImageHeader {
    u16 length;
    u16 hole_offset;
    ImageInfoFlags bimg_info;

    // BKPIMAGE_HAS_HOLE && BKPIMAGE_COMPRESSED
    if (pg_version == 14 && bimg_info.compressed) {
      XLogRecordBlockCompressHeader compress_header;
    } else if (pg_version > 14 && (bimg_info.has_hole == 1) &&
          ((bimg_info.compress_pglz == 1) ||
           (bimg_info.compress_lz4 == 1) ||
           (bimg_info.compress_zstd == 1))) {
          XLogRecordBlockCompressHeader compress_header;
    }
};

// XLog Record //

bitfield XLogRecordInfoFlags {
    special_rel_update : 1;
    check_consistency  : 1;
    reserved           : 2;
    rmgr_info          : 4;
};

struct MainDataHeader {
    u8 id;
};

// Main data //

struct xl_standby_lock {
  TransactionId xid;
  Oid dbOid;
  Oid relOid;
};

struct xl_standby_locks {
  u32 nlocks;
  xl_standby_lock locks[nlocks];
};

struct xl_running_xacts {
  u32 xcnt;
  u32 subxcnt;
  bool subxid_overflow;
  padding[3];
  TransactionId nextXid;
  TransactionId oldestRunningXid;
  TransactionId latestCompletedXid;
  TransactionId xids[xcnt + subxcnt];
};

struct SharedInvalCatcacheMsg {
  s8 id;
  padding[3];
  Oid dbId;
  u32 hashValue;
};

struct SharedInvalCatalogMsg {
  s8 id;
  padding[3];
  Oid dbId;
  Oid catId;
};

struct SharedInvalRelcacheMsg {
  s8 id;
  padding[3];
  Oid dbId;
  Oid relId;
};

struct SharedInvalSmgrMsg {
  s8 id;
  s8 backend_hi;
  u16 backend_lo;
  RelFileLocator rlocator;
};

struct SharedInvalRelmapMsg {
  s8 id;
  padding[3];
  Oid dbId;
};

struct SharedInvalSnapshotMsg {
  s8 id;
  padding[3];
  Oid dbId;
  Oid relId;
};

struct SharedInvalRelSyncMsg {
  s8 id;
  padding[3];
  Oid dbId;
  Oid relid;
};

struct SharedInvalidationMessage {
  s8 id = std::mem::read_signed($, 1);
  if (id >= 0) {
    SharedInvalCatcacheMsg catalog_cache;
  } else {
    match (id) {
      (SHAREDINVALCATALOG_ID): SharedInvalCatalogMsg catalog;
      (SHAREDINVALRELCACHE_ID): SharedInvalRelcacheMsg rel_cache;
      (SHAREDINVALSMGR_ID): SharedInvalSmgrMsg smgr;
      (SHAREDINVALRELMAP_ID): SharedInvalRelmapMsg relmap;
      (SHAREDINVALSNAPSHOT_ID): SharedInvalSnapshotMsg snapshot;
      (_): std::error(std::format("Unknown message {}", id));
    }
  }
} [[inline, fixed_size(16)]];

struct xl_invalidations {
  Oid dbId;
  Oid tsId;
  bool relcacheInitFileInval;
  padding[3];
  u32 nmsgs;
  SharedInvalidationMessage msgs[nmsgs];
};

struct CheckPoint
{
  XLogRecPtr  redo;
  TimeLineID  ThisTimeLineID;
  TimeLineID  PrevTimeLineID;
  bool    fullPageWrites;
  padding[3];
  s32     wal_level;
  if (pg_version >= 19) {
    bool   logicalDecodingEnabled;
    padding[7];
  }
  FullTransactionId nextXid;
  Oid     nextOid;
  MultiXactId nextMulti;
  if (pg_version >= 19) {
    MultiXactOffset_PG19 nextMultiOffset;
  } else {
    MultiXactOffset nextMultiOffset;
  }
  TransactionId oldestXid;
  Oid     oldestXidDB;
  MultiXactId oldestMulti;
  Oid     oldestMultiDB;

  if (pg_version < 19) {
    padding[4];
  }
  pg_time_t time;
  TransactionId oldestCommitTsXid;
  TransactionId newestCommitTsXid;
  TransactionId oldestActiveXid;

  if (pg_version >= 19) {
    u32 dataChecksumState;
  }
};

struct xl_parameter_change {
  u32 MaxConnections;
  u32 max_worker_processes;
  u32 max_wal_senders;
  u32 max_prepared_xacts;
  u32 max_locks_per_xact;
  u32 wal_level;
  bool wal_log_hints;
  bool track_commit_timestamp;
};

struct xl_restore_point {
  TimestampTz rp_time;
  char rp_name[64];
};

struct xl_overwrite_contrecord {
  XLogRecPtr overwritten_lsn;
  TimestampTz overwrite_time;
};

struct xl_end_of_recovery {
  TimestampTz end_time;
  TimeLineID ThisTimeLineID;
  TimeLineID PrevTimeLineID;
  u32 wal_level;
};

struct xl_xact_assignment {
  TransactionId xtop;
  u32 nsubxacts;
  TransactionId xsub[nsubxacts];
};

struct xl_xact_xinfo {
  u32 xinfo;
};

struct xl_xact_dbinfo {
  Oid dbId;
  Oid tsId;
};

struct xl_xact_subxacts {
  u32 nsubxacts;
  TransactionId subxacts[nsubxacts];
};

struct xl_xact_relfilelocators {
  u32 nrels;
  RelFileLocator xlocators[nrels];
};

struct xl_xact_stats_item {
  u32 kind;
  Oid dboid;
  u32 objid_lo;
  u32 objid_hi;
};

struct xl_xact_stats_items {
  u32 nitems;
  xl_xact_stats_item items[nitems];
};

struct xl_xact_invals {
  u32 nmsgs;
  SharedInvalidationMessage msgs[nmsgs];
};

struct xl_xact_twophase {
  TransactionId xid;
};

struct xl_xact_origin {
  XLogRecPtr origin_lsn;
  TimestampTz origin_timestamp;
};

struct xl_xact_commit {
  TimestampTz xact_time;

  if ((rmgr_info & XLOG_XACT_HAS_INFO) != 0) {
    xl_xact_xinfo xinfo;
    if ((xinfo.xinfo & XACT_XINFO_HAS_DBINFO) != 0) {
      xl_xact_dbinfo dbinfo;
    }
    if ((xinfo.xinfo & XACT_XINFO_HAS_SUBXACTS) != 0) {
      xl_xact_subxacts subxacts;
    }
    if ((xinfo.xinfo & XACT_XINFO_HAS_RELFILELOCATORS) != 0) {
      xl_xact_relfilelocators relfilelocators;
    }
    if ((xinfo.xinfo & XACT_XINFO_HAS_DROPPED_STATS) != 0) {
      xl_xact_stats_items stats_items;
    }
    if ((xinfo.xinfo & XACT_XINFO_HAS_INVALS) != 0) {
      xl_xact_invals invals;
    }
    if ((xinfo.xinfo & XACT_XINFO_HAS_TWOPHASE) != 0) {
      xl_xact_twophase twophase;
    }
    if ((xinfo.xinfo & XACT_XINFO_HAS_ORIGIN) != 0) {
      xl_xact_origin origin;
    }
  }
};

struct xl_xact_abort {
  TimestampTz xact_time;
  if ((rmgr_info & XLOG_XACT_HAS_INFO) != 0) {
    xl_xact_xinfo xinfo;
    if ((xinfo.xinfo & XACT_XINFO_HAS_DBINFO) != 0) {
      xl_xact_dbinfo dbinfo;
    }
    if ((xinfo.xinfo & XACT_XINFO_HAS_SUBXACTS) != 0) {
      xl_xact_subxacts subxacts;
    }
    if ((xinfo.xinfo & XACT_XINFO_HAS_RELFILELOCATORS) != 0) {
      xl_xact_relfilelocators relfilelocators;
    }
    if ((xinfo.xinfo & XACT_XINFO_HAS_DROPPED_STATS) != 0) {
      xl_xact_stats_items stats_items;
    }
    if ((xinfo.xinfo & XACT_XINFO_HAS_TWOPHASE) != 0) {
      xl_xact_twophase twophase;
    }
    if ((xinfo.xinfo & XACT_XINFO_HAS_ORIGIN) != 0) {
      xl_xact_origin origin;
    }
  }
};

struct xl_xact_prepare {
  u32 magic;
  u32 total_len;
  TransactionId xid;
  Oid database;
  TimestampTz prepared_at;
  Oid owner;
  s32 nsubxacts;
  s32 ncommitrels;
  s32 nabortrels;
  s32 ncommitstats;
  s32 nabortstats;
  s32 ninvalmsgs;
  bool initfileinval;
  u16 gidlen;
  XLogRecPtr origin_lsn;
  TimestampTz origin_timestamp;
};

struct xl_heap_header {
  u16 t_infomask2;
  u16 t_infomask;
  u8 t_hoff;
};

struct xl_heap_insert {
  OffsetNumber offnum;
  u8 flags;
};

struct xl_heap_delete {
  TransactionId xmax;
  OffsetNumber offnum;
  u8 infobits_set;
  u8 flags;
};

struct HeapTupleHeader {
  u16 t_infomask2;
  u16 t_infomask;
  u8 t_hoff;
};

bitfield XLogHeapUpdateFlags {
    OLD_ALL_VISIBILTY_CLEARED  : 1;
    NEW_ALL_VISIBILITY_CLEARED : 1;
    CONTAINS_OLD_TUPLE         : 1;
    CONTAINS_OLD_KEY           : 1;
    CONTAINS_NEW_TUPLE         : 1;
    PREFIX_FROM_OLD            : 1;
    SUFFIX_FROM_OLD            : 1;
};

struct xl_heap_update {
  TransactionId old_xmax;
  OffsetNumber old_offnum;
  u8 old_infobits_set;
  XLogHeapUpdateFlags flags;
  TransactionId new_xmax;
  OffsetNumber new_offnum;
  if (flags.CONTAINS_OLD_TUPLE || flags.CONTAINS_OLD_KEY) {
    HeapTupleHeader heap_tuple_header;
    u8 heap_data[parent.parent.parent.fragment_headers[current_block].data_length - 19];
  }
};

struct xl_heap_truncate {
  Oid dbId;
  u32 nrelids;
  u8 flags;
  padding[3];
  Oid relids[nrelids];
};

struct xl_heap_lock {
  TransactionId xmax;
  OffsetNumber offnum;
  u8 infobits_set;
  u8 flags;
};

struct xl_heap_lock_updated {
  TransactionId xmax;
  OffsetNumber offnum;
  u8 infobits_set;
  u8 flags;
};

struct xl_heap_confirm {
  OffsetNumber offnum;
};

struct xl_heap_inplace {
  OffsetNumber offnum;
  if (pg_version >= 18) {
    padding[2];
    Oid dbId;
    Oid tsId;
    bool relcacheInitFileInval;
    padding[3];
    u32 nmsgs;
    SharedInvalidationMessage msgs[nmsgs];
  }
};

struct xl_heap_visible {
  TransactionId snapshotConflictHorizon;
  u8 flags;
};

struct xl_heap_new_cid {
  TransactionId top_xid;
  CommandId cmin;
  CommandId cmax;
  CommandId combocid;
  RelFileLocator target_locator;
  ItemPointerData target_tid;
};

struct xl_heap_rewrite_mapping {
  TransactionId mapped_xid;
  Oid mapped_db;
  Oid mapped_rel;
  padding[4];
  u64 offset;
  u32 num_mappings;
  padding[4];
  XLogRecPtr start_lsn;
};

struct xl_multi_insert_tuple {
  u16 datalen;
  u16 t_infomask2;
  u16 t_infomask;
  u8 t_hoff;
  u8 tuple_data[datalen];
};

struct xl_heap_multi_insert {
  u8 flags;
  padding[1];
  u16 ntuples;

  if (!parent.is_init) {
    OffsetNumber offsets[ntuples];
  }
};

struct xlhp_freeze_plan {
  TransactionId xmax;
  u16 t_infomask2;
  u16 t_infomask;
  u8 frzflags;
  u16 ntuples;
};

struct xlhp_freeze_plans {
  u16 nplans;
  xlhp_freeze_plan plans[nplans];
};

struct xlhp_prune_items {
  u16 ntargets;
  OffsetNumber data[ntargets];
};

struct xl_heap_prune {
  if (pg_version >= 19) {
    u16 flags;
  } else {
    u8 reason;
    u8 flags;
  }
  if (flags & XLHP_HAS_CONFLICT_HORIZON) {
    TransactionId conflict_horizon;
  }
};

struct xl_btree_metadata
{
	u32		version;
	BlockNumber root;
	u32		level;
	BlockNumber fastroot;
	u32		fastlevel;
	u32		last_cleanup_num_delpages;
	bool		allequalimage;
};

struct xl_btree_insert
{
	OffsetNumber offnum;
};

struct xl_btree_split
{
	u32		level;
	OffsetNumber firstrightoff;
	OffsetNumber newitemoff;
	u16		postingoff;
};

struct xl_btree_dedup
{
	u16		nintervals;
};

struct xl_btree_reuse_page
{
	RelFileLocator locator;
	BlockNumber block;
  if (pg_version >= 16) {
    FullTransactionId snapshotConflictHorizon;
    bool		isCatalogRel;
  } else if (pg_version < 16) {
    FullTransactionId latestRemovedFullXid;
  }
};

struct xl_btree_vacuum
{
	u16		ndeleted;
	u16		nupdated;
};

struct xl_btree_delete
{
	TransactionId snapshotConflictHorizon;
	u16		ndeleted;
	u16		nupdated;
  if (pg_version >= 18) {
    bool		isCatalogRel;
  }
};

struct xl_btree_update
{
	u16		ndeletedtids;

	/* POSTING LIST uint16 OFFSETS TO A DELETED TID FOLLOW */
};

struct xl_btree_mark_page_halfdead
{
	OffsetNumber poffset;
  padding[2];

	/* information needed to recreate the leaf page: */
	BlockNumber leafblk;
	BlockNumber leftblk;
	BlockNumber rightblk;
	BlockNumber topparent;
};

struct xl_btree_unlink_page
{
	BlockNumber leftsib;
	BlockNumber rightsib;
	u32		level;
  padding[4];

	FullTransactionId safexid;
	BlockNumber leafleftsib;
	BlockNumber leafrightsib;
	BlockNumber leaftopparent;
};

struct xl_btree_unlink_page_meta : xl_btree_unlink_page
{
	xl_btree_metadata xl_btree_metadata;
};

struct xl_btree_newroot
{
	BlockNumber rootblk;
	u32		level;
};

struct xl_smgr_create {
    RelFileLocator rlocator;
    // TODO: Create ForkNumber enum
    u32 forkNum;
};

struct xl_smgr_truncate {
    BlockNumber blkno;
    RelFileLocator rlocator;
    s32 flags;
};

struct xl_clog_zeropage {
  s64 pageno;
};

struct xl_clog_truncate {
    s64 pageno;
    TransactionId oldestXact;
    Oid oldestXactDb;
};

struct xl_dbase_create_file_copy_rec {
    Oid db_id;
    Oid tablespace_id;
    Oid src_db_id;
    Oid src_tablespace_id;
};

struct xl_dbase_create_wal_log_rec {
    Oid db_id;
    Oid tablespace_id;
};

struct xl_dbase_drop_rec {
    Oid db_id;
    s32 ntablespaces;
    Oid tablespace_ids[ntablespaces];
};

struct xl_tblspc_create_rec {
    Oid ts_id;
    char ts_path[while(std::mem::read_unsigned($, 1) != 0x00)];
};

struct xl_tblspc_drop_rec {
    Oid ts_id;
};

struct xl_multixact_zeropage {
  s64 pageno;
};

struct MultiXactMember {
    TransactionId xid;
    // TODO: Create MultiXactStatus enum
    u32 status;
};

struct xl_multixact_create {
    MultiXactId mid;
    padding[4];
    MultiXactOffset moff;
    s32 nmembers;
    MultiXactMember members[nmembers];
};

struct xl_multixact_truncate {
    Oid oldestMultiDB;
    MultiXactId oldestMulti;
    MultiXactOffset oldestOffset;
};

struct xl_relmap_update {
    Oid dbid;
    Oid tsid;
    s32 nbytes;
    u8 data[nbytes];
};

// Hash
struct xl_hash_insert {
  OffsetNumber offnum;
};

struct xl_hash_add_ovfl_page {
  u16 bmsize;
  bool bmpage_found;
};

struct xl_hash_split_allocate_page {
  u32 new_bucket;
	u16 old_bucket_flag;
	u16 new_bucket_flag;
	u8 flags;
};

struct xl_hash_split_complete {
  u16 old_bucket_flag;
	u16 new_bucket_flag;
};

struct xl_hash_move_page_contents {
  u16 ntups;
	bool is_prim_bucket_same_wrt;
};

struct xl_hash_squeeze_page {
  BlockNumber prevblkno;
	BlockNumber nextblkno;
	u16 ntups;
	bool is_prim_bucket_same_wrt;
	bool is_prev_bucket_same_wrt;
};

struct xl_hash_delete {
  bool clear_dead_marking;
	bool is_primary_bucket_page;
};

struct xl_hash_update_meta_page {
  double ntuples;
};

struct xl_hash_init_meta_page {
  double num_tuples;
	Oid procid;
	u16 ffactor;
};

struct xl_hash_init_bitmap_page {
  u16 bmsize;
};

struct xl_hash_vacuum_one_page {
    TransactionId snapshotConflictHorizon;
    u16 ntuples;
    bool isCatalogRel;
    padding[1];
    OffsetNumber offsets[ntuples];
};

struct ginxlogCreatePostingTree {
  u32 size;
};

struct ginxlogInsert {
  u16 flags;
};

struct ginxlogSplit {
  RelFileLocator locator;
	BlockNumber rrlink;
	BlockNumber leftChildBlkno;
	BlockNumber rightChildBlkno;
	u16 flags;
};

struct ginxlogDeletePage {
  OffsetNumber parentOffset;
	BlockNumber rightLink;
	TransactionId deleteXid;
};

struct GinMetaPageData {
	BlockNumber head;
	BlockNumber tail;
	u32         tailFreeSize;
	BlockNumber nPendingPages;
	s64         nPendingHeapTuples;
	BlockNumber nTotalPages;
	BlockNumber nEntryPages;
	BlockNumber nDataPages;
  padding[4];
	s64         nEntries;
	u32         ginVersion;
};

struct ginxlogUpdateMeta {
  RelFileLocator locator;
  padding[4];
  GinMetaPageData metadata;
	BlockNumber prevTail;
	BlockNumber newRightlink;
	s32 ntuples;
};

struct ginxlogInsertListPage {
  BlockNumber rightlink;
	s32 ntuples;
};

struct ginxlogDeleteListPages {
  GinMetaPageData metadata;
  s32 ndeleted;
};

struct ginxlogVacuumDataLeafPage {
  u16 nactions;
};

struct ginxlogRecompressDataLeaf {
  u16 nactions;
};


struct gistxlogPageUpdate {
  u16 ntodelete;
	u16 ntoinsert;
};

struct gistxlogDelete {
    TransactionId snapshotConflictHorizon;
    u16 ntodelete;
    bool isCatalogRel;
    padding[1];
    OffsetNumber offsets[1];
};

struct gistxlogPageSplit {
  BlockNumber origrlink;
  padding[4];
	u64 orignsn;
	bool origleaf;
	u16 npage;
	bool markfollowright;
};

struct gistxlogPageDelete {
  FullTransactionId deleteXid;
	OffsetNumber downlinkOffset;
};

struct gistxlogPageReuse {
  RelFileLocator locator;
	BlockNumber block;
	FullTransactionId snapshotConflictHorizon;
	bool isCatalogRel;
};


struct xl_seq_rec {
  RelFileLocator locator;
};

struct spgxlogState {
  TransactionId redirectXid;
	bool isBuild;
};

struct spgxlogAddLeaf {
  bool newPage;
	bool storesNulls;
	OffsetNumber offnumLeaf;
	OffsetNumber offnumHeadLeaf;
	OffsetNumber offnumParent;
	u16 nodeI;
};

struct spgxlogMoveLeafs {
  u16 nMoves;
	bool newPage;
	bool replaceDead;
	bool storesNulls;
	OffsetNumber offnumParent;
	u16 nodeI;
	spgxlogState stateSrc;
	OffsetNumber offsets[1];
};

struct spgxlogAddNode {
  OffsetNumber offnum;
	OffsetNumber offnumNew;
	bool newPage;
  s8 parentBlk;
  u16 nodeI;
  padding[2];
	spgxlogState stateSrc;
};

struct spgxlogVacuumLeaf {
  u16 nDead;
	u16 nPlaceholder;
	u16 nMove;
	u16 nChain;
	spgxlogState stateSrc;
	OffsetNumber offsets[nDead + nPlaceholder + nMove + nChain];
};

struct spgxlogVacuumRoot {
  u16 nDelete;
  padding[2];
	spgxlogState stateSrc;
	OffsetNumber offsets[nDelete];
};

struct spgxlogSplitTuple
{
	OffsetNumber offnumPrefix;

	OffsetNumber offnumPostfix;
	bool		newPage;
	bool		postfixBlkSame;
  // TODO: Prefix inner tuple, then new postfix inner tuple
};

struct spgxlogPickSplit
{
	bool		isRootSplit;

	u16		nDelete;
	u16		nInsert;
	bool		initSrc;
	bool		initDest;

	OffsetNumber offnumInner;
	bool		initInner;

	bool		storesNulls;

	bool		innerIsParent;
	OffsetNumber offnumParent;
	u16		nodeI;

	spgxlogState stateSrc;
	// TODO: Rest of the record
};

struct spgxlogVacuumRedirect {
  u16 nToPlaceholder;
	OffsetNumber firstPlaceholder;
  TransactionId snapshotConflictHorizon;
  bool isCatalogRel;
  padding[1];
	OffsetNumber offsets[nToPlaceholder];
};

struct xl_brin_createidx {
  BlockNumber pagesPerRange;
	u16 version;
};

struct xl_brin_insert {
  BlockNumber heapBlk;
	BlockNumber pagesPerRange;
	OffsetNumber offnum;
};

struct xl_brin_update {
  OffsetNumber oldOffnum;
	xl_brin_insert insert;
};

struct xl_brin_samepage_update {
  OffsetNumber offnum;
};

struct xl_brin_revmap_extend {
  BlockNumber targetBlk;
};

struct xl_brin_desummarize {
  BlockNumber pagesPerRange;
	BlockNumber heapBlk;
	OffsetNumber regOffset;
};


struct xl_commit_ts_zeropage {
  s64 pageno;
};

struct xl_commit_ts_truncate {
  s64 pageno;
	TransactionId oldestXid;
};

struct xl_replorigin_set {
  XLogRecPtr remote_lsn;
	u16 node_id;
	bool force;
};

struct xl_replorigin_drop {
  u16 node_id;
};

struct xl_logical_message {
    Oid dbId;
    bool transactional;
    padding[3];
    u64 prefix_size;
    u64 message_size;

    u8 prefix[prefix_size];
    u8 message[message_size];
};

struct MainFragment {
    u8 info = rmgr_info & ~XLR_INFO_MASK;
    auto start_address = $;
    match (rmgr_id) {
      (RmgrId::Xlog): {
        match (info) {
          (XLOG_PARAMETER_CHANGE): xl_parameter_change xl_parameter_change;
          (XLOG_RESTORE_POINT): xl_restore_point xl_restore_point;
          (XLOG_OVERWRITE_CONTRECORD): xl_overwrite_contrecord xl_overwrite_contrecord;
          (XLOG_END_OF_RECOVERY): xl_end_of_recovery xl_end_of_recovery;
          (XLOG_BACKUP_END): XLogRecPtr startpoint;
          (XLOG_CHECKPOINT_REDO): u32 wal_level;
          (XLOG_CHECKPOINT_ONLINE): CheckPoint checkpoint;
          (XLOG_NEXTOID): Oid nextOid;
          (XLOG_CHECKPOINT_SHUTDOWN): CheckPoint checkpoint;
        }
      }
      (RmgrId::Transaction): {
        match (info & XLOG_XACT_OPMASK) {
          (XLOG_XACT_COMMIT): xl_xact_commit xl_xact_commit;
          (XLOG_XACT_ABORT): xl_xact_abort xl_xact_abort;
          (XLOG_XACT_PREPARE): xl_xact_prepare xl_xact_prepare;
          (XLOG_XACT_ASSIGNMENT): xl_xact_assignment xl_xact_assignment;
          (XLOG_XACT_INVALIDATIONS): xl_xact_invals xl_xact_invals;
        }
      }
      (RmgrId::Storage): {
        match (info) {
          (XLOG_SMGR_CREATE): xl_smgr_create xl_smgr_create;
          (XLOG_SMGR_TRUNCATE): xl_smgr_truncate xl_smgr_truncate;
        }
      }
      (RmgrId::Clog): {
        match (info) {
          (CLOG_ZEROPAGE): xl_clog_zeropage xl_clog_zeropage;
          (CLOG_TRUNCATE): xl_clog_truncate xl_clog_truncate;
        }
      }
      (RmgrId::Database): {
        match (info) {
          (XLOG_DBASE_CREATE_FILE_COPY): xl_dbase_create_file_copy_rec xl_dbase_create_file_copy_rec;
          (XLOG_DBASE_CREATE_WAL_LOG): xl_dbase_create_wal_log_rec xl_dbase_create_wal_log_rec;
          (XLOG_DBASE_DROP): xl_dbase_drop_rec xl_dbase_drop_rec;
        }
      }
      (RmgrId::Tablespace): {
        match (info) {
          (XLOG_TBLSPC_CREATE): xl_tblspc_create_rec xl_tblspc_create_rec;
          (XLOG_TBLSPC_DROP): xl_tblspc_drop_rec xl_tblspc_drop_rec;
        }
      }
      (RmgrId::MultiXact): {
        match (info) {
          (XLOG_MULTIXACT_ZERO_OFF_PAGE | XLOG_MULTIXACT_ZERO_MEM_PAGE): xl_multixact_zeropage xl_multixact_zeropage;
          (XLOG_MULTIXACT_CREATE_ID): xl_multixact_create xl_multixact_create;
          (XLOG_MULTIXACT_TRUNCATE_ID): xl_multixact_truncate xl_multixact_truncate;
        }
      }
      (RmgrId::RelMap): {
        match (info) {
          (XLOG_RELMAP_UPDATE): xl_relmap_update xl_relmap_update;
        }
      }
      (RmgrId::Standby): {
        match (info) {
          (XLOG_STANDBY_LOCK): xl_standby_locks xl_standby_locks;
          (XLOG_RUNNING_XACTS): xl_running_xacts xl_running_xacts;
          (XLOG_INVALIDATIONS): xl_invalidations xl_invalidations;
        }
      }
      (RmgrId::Heap): {
        bool is_init = rmgr_info & XLOG_HEAP_INIT_PAGE;
        match (info & XLOG_HEAP_OPMASK) {
          (XLOG_HEAP_INSERT): xl_heap_insert xl_heap_insert;
          (XLOG_HEAP_DELETE): xl_heap_delete xl_heap_delete;
          (XLOG_HEAP_TRUNCATE): xl_heap_truncate xl_heap_truncate;
          (XLOG_HEAP_UPDATE): xl_heap_update xl_heap_update;
          (XLOG_HEAP_HOT_UPDATE): xl_heap_update xl_heap_hot_update;
          (XLOG_HEAP_CONFIRM): xl_heap_confirm xl_heap_confirm;
          (XLOG_HEAP_LOCK): xl_heap_lock xl_heap_lock;
          (XLOG_HEAP_INPLACE): xl_heap_inplace xl_heap_inplace;
        }
      }
      (RmgrId::Heap2): {
        bool is_init = rmgr_info & XLOG_HEAP_INIT_PAGE;
        match (info & XLOG_HEAP2_OPMASK) {
          (XLOG_HEAP2_REWRITE): xl_heap_rewrite_mapping xl_heap_rewrite_mapping;
          (XLOG_HEAP2_PRUNE_ON_ACCESS | XLOG_HEAP2_PRUNE_VACUUM_SCAN | XLOG_HEAP2_PRUNE_VACUUM_CLEANUP): xl_heap_prune xl_heap_prune;
          (XLOG_HEAP2_VISIBLE): xl_heap_visible xl_heap_visible;
          (XLOG_HEAP2_MULTI_INSERT): xl_heap_multi_insert xl_heap_multi_insert;
          (XLOG_HEAP2_LOCK_UPDATED): xl_heap_lock_updated xl_heap_lock_updated;
          (XLOG_HEAP2_NEW_CID): xl_heap_new_cid xl_heap_new_cid;
        }
      }
      (RmgrId::Btree): {
        match (info) {
		      (XLOG_BTREE_INSERT_LEAF | XLOG_BTREE_INSERT_UPPER | XLOG_BTREE_INSERT_META | XLOG_BTREE_INSERT_POST): xl_btree_insert xl_btree_insert;
		      (XLOG_BTREE_SPLIT_L | XLOG_BTREE_SPLIT_R): xl_btree_split xl_btree_split;
		      (XLOG_BTREE_DEDUP): xl_btree_dedup xl_btree_dedup;
		      (XLOG_BTREE_VACUUM): xl_btree_vacuum xl_btree_vacuum;
		      (XLOG_BTREE_DELETE): xl_btree_delete xl_btree_delete;
		      (XLOG_BTREE_MARK_PAGE_HALFDEAD): xl_btree_mark_page_halfdead xl_btree_mark_page_halfdead;
		      (XLOG_BTREE_UNLINK_PAGE): xl_btree_unlink_page xl_btree_unlink_page;
		      (XLOG_BTREE_UNLINK_PAGE_META): xl_btree_unlink_page_meta xl_btree_unlink_page_meta;
		      (XLOG_BTREE_NEWROOT): xl_btree_newroot xl_btree_newroot;
		      (XLOG_BTREE_REUSE_PAGE): xl_btree_reuse_page xl_btree_reuse_page;
		      // (XLOG_BTREE_META_CLEANUP): ;
        }
      }
      (RmgrId::Hash): {
        match (info) {
          (XLOG_HASH_INIT_META_PAGE): xl_hash_init_meta_page xl_hash_init_meta_page;
          (XLOG_HASH_INIT_BITMAP_PAGE): xl_hash_init_bitmap_page xl_hash_init_bitmap_page;
          (XLOG_HASH_INSERT): xl_hash_insert xl_hash_insert;
          (XLOG_HASH_ADD_OVFL_PAGE): xl_hash_add_ovfl_page xl_hash_add_ovfl_page;
          (XLOG_HASH_SPLIT_ALLOCATE_PAGE): xl_hash_split_allocate_page xl_hash_split_allocate_page;
          (XLOG_HASH_SPLIT_PAGE): padding[0];
          (XLOG_HASH_SPLIT_COMPLETE): xl_hash_split_complete xl_hash_split_complete;
          (XLOG_HASH_MOVE_PAGE_CONTENTS): xl_hash_move_page_contents xl_hash_move_page_contents;
          (XLOG_HASH_SQUEEZE_PAGE): xl_hash_squeeze_page xl_hash_squeeze_page;
          (XLOG_HASH_DELETE): xl_hash_delete xl_hash_delete;
          (XLOG_HASH_SPLIT_CLEANUP): padding[0];
          (XLOG_HASH_UPDATE_META_PAGE): xl_hash_update_meta_page xl_hash_update_meta_page;
          (XLOG_HASH_VACUUM_ONE_PAGE): xl_hash_vacuum_one_page xl_hash_vacuum_one_page;
        }
      }
      (RmgrId::Gin): {
        match (info) {
          (XLOG_GIN_CREATE_PTREE): ginxlogCreatePostingTree ginxlogCreatePostingTree;
          (XLOG_GIN_INSERT): ginxlogInsert ginxlogInsert;
          (XLOG_GIN_SPLIT): ginxlogSplit ginxlogSplit;
          (XLOG_GIN_VACUUM_PAGE): padding[0];
          (XLOG_GIN_DELETE_PAGE): ginxlogDeletePage ginxlogDeletePage;
          (XLOG_GIN_UPDATE_META_PAGE): ginxlogUpdateMeta ginxlogUpdateMeta;
          (XLOG_GIN_INSERT_LISTPAGE): ginxlogInsertListPage ginxlogInsertListPage;
          (XLOG_GIN_DELETE_LISTPAGE): ginxlogDeleteListPages ginxlogDeleteListPages;
          (XLOG_GIN_VACUUM_DATA_LEAF_PAGE): ginxlogVacuumDataLeafPage ginxlogVacuumDataLeafPage;
        }
      }
      (RmgrId::Gist): {
        match (info) {
          (XLOG_GIST_PAGE_UPDATE): gistxlogPageUpdate gistxlogPageUpdate;
          (XLOG_GIST_DELETE): gistxlogDelete gistxlogDelete;
          (XLOG_GIST_PAGE_REUSE): gistxlogPageReuse gistxlogPageReuse;
          (XLOG_GIST_PAGE_SPLIT): gistxlogPageSplit gistxlogPageSplit;
          (XLOG_GIST_PAGE_DELETE): gistxlogPageDelete gistxlogPageDelete;
          (XLOG_GIST_ASSIGN_LSN): padding[0];
        }
      }
      (RmgrId::Sequence): {
        match (info) {
          (XLOG_SEQ_LOG): xl_seq_rec xl_seq_rec;
        }
      }
      (RmgrId::Spgist): {
        match (info) {
          (XLOG_SPGIST_ADD_LEAF): spgxlogAddLeaf spgxlogAddLeaf;
          (XLOG_SPGIST_MOVE_LEAFS): spgxlogMoveLeafs spgxlogMoveLeafs;
          (XLOG_SPGIST_ADD_NODE): spgxlogAddNode spgxlogAddNode;
          (XLOG_SPGIST_SPLIT_TUPLE): spgxlogSplitTuple spgxlogSplitTuple;
          (XLOG_SPGIST_PICKSPLIT): spgxlogPickSplit spgxlogPickSplit;
          (XLOG_SPGIST_VACUUM_LEAF): spgxlogVacuumLeaf spgxlogVacuumLeaf;
          (XLOG_SPGIST_VACUUM_ROOT): spgxlogVacuumRoot spgxlogVacuumRoot;
          (XLOG_SPGIST_VACUUM_REDIRECT): spgxlogVacuumRedirect spgxlogVacuumRedirect;
        }
      }
      (RmgrId::Brin): {
        match (info & XLOG_BRIN_OPMASK) {
          (XLOG_BRIN_CREATE_INDEX): xl_brin_createidx xl_brin_createidx;
          (XLOG_BRIN_INSERT): xl_brin_insert xl_brin_insert;
          (XLOG_BRIN_UPDATE): xl_brin_update xl_brin_update;
          (XLOG_BRIN_SAMEPAGE_UPDATE): xl_brin_samepage_update xl_brin_samepage_update;
          (XLOG_BRIN_REVMAP_EXTEND): xl_brin_revmap_extend xl_brin_revmap_extend;
          (XLOG_BRIN_DESUMMARIZE): xl_brin_desummarize xl_brin_desummarize;
        }
      }
      (RmgrId::CommitTs): {
        match (info) {
          (COMMIT_TS_ZEROPAGE): xl_commit_ts_zeropage xl_commit_ts_zeropage;
          (COMMIT_TS_TRUNCATE): xl_commit_ts_truncate xl_commit_ts_truncate;
        }
      }
      (RmgrId::ReplicationOrigin): {
        match (info) {
          (XLOG_REPLORIGIN_SET): xl_replorigin_set xl_replorigin_set;
          (XLOG_REPLORIGIN_DROP): xl_replorigin_drop xl_replorigin_drop;
        }
      }
      (RmgrId::Generic): { }
      (RmgrId::LogicalMsg): {
        match (info) {
          (XLOG_LOGICAL_MESSAGE): xl_logical_message xl_logical_message;
        }
      }
      (_): std::error(std::format("rmgrid not handled {}", id));
    }
    padding[main_data_length - ($ - start_address)];
} [[inline]];

struct BlockHeader {
    u8 fl = std::mem::read_unsigned($, 1);
    ForkFlags fork_flags;
    if (fork_flags.has_image != (fl & BKPBLOCK_HAS_IMAGE > 0)) {
      std::error(std::format("mismatch has_image, {}, {}", fork_flags.has_image, (fl & BKPBLOCK_HAS_IMAGE)));
    }

    u16 data_length;
    data_total += data_length;
    if (fork_flags.has_image > 0) {
    // if (fl & BKPBLOCK_HAS_IMAGE > 0) {
        XLogRecordBlockImageHeader image_header;
        data_total += image_header.length;
    }
    // if (fork_flags.same_rel == 0) {
    if (fl & BKPBLOCK_SAME_REL == 0) {
        RelFileLocator rel_file_locator;
    }
    BlockNumber block_number;
} [[inline]];

struct FragmentHeader {
    u8 id;
    if (id == XLR_BLOCK_ID_DATA_SHORT) {
      u8 data_length;
      main_data_length = data_length;
      data_total += data_length;
    } else if (id == XLR_BLOCK_ID_DATA_LONG) {
      u32 data_length;
      main_data_length = data_length;
      data_total += data_length;
    } else if (id == XLR_BLOCK_ID_ORIGIN) {
      u16 record_origin;
    } else if (id == XLR_BLOCK_ID_TOPLEVEL_XID) {
      TransactionId toplevel_xid;
    } else if (id < XLR_MAX_BLOCK_ID) {
      BlockHeader block_header;
      std::print(std::format("Parsed block header: {}, len: {}, 0x{:x}", id, block_header.data_length, $));
    } else {
      std::error(std::format("Unknown data FragmentHeader: {} at pos 0x{:x}", id, $));
    }
};

struct FragmentData {
  // TODO: More precise block content
  if (parent.fragment_headers[current_block].id < XLR_MAX_BLOCK_ID) {
    if (parent.fragment_headers[current_block].block_header.fork_flags.has_image) {
      u8 backup_image[parent.fragment_headers[current_block].block_header.image_header.length];
    }
    if (parent.fragment_headers[current_block].block_header.data_length > std::mem::size() - $) {
      return;
    }
    u8 block_content[parent.fragment_headers[current_block].block_header.data_length];
  } else if (parent.fragment_headers[current_block].id == XLR_BLOCK_ID_DATA_SHORT
            || parent.fragment_headers[current_block].id == XLR_BLOCK_ID_DATA_LONG) {
    MainFragment main_fragment;
  }
  current_block = current_block + 1;
};

fn byte_pos_to_seg_offset(auto byte_pos) {
  u32 seg_offset;

  if (byte_pos < global_page_size) {
    // We already have a fake long header, no need to add it
    seg_offset = byte_pos;
  } else {
    // Count the first page with long header
    seg_offset = global_page_size;
    byte_pos -= global_page_size;

    // How much bytes we can have in pages with short header
    u64 usable_bytes_in_page = global_page_size - SizeOfXLogShortPHD;

    u64 full_pages = byte_pos / usable_bytes_in_page;
    byte_pos = byte_pos % usable_bytes_in_page;

    seg_offset += full_pages * global_page_size + byte_pos + SizeOfXLogShortPHD;
  }
  seg_offset += global_page_addr;

  return seg_offset;
};

struct XLogRecordHeader {
    u32 xl_tot_len;
    if (xl_tot_len == 0) {
      break;
    }

    TransactionId xl_xid;
    XLogRecPtr xl_prev;

    XLogRecPtr lsn = byte_pos_to_seg_offset(parent.start_address) [[hidden]];

    XLogRecordInfoFlags xl_info;
    RmgrId xl_rmid;
    padding[2];
    u32 xl_crc;
} [[format("format_xlog_record_header")]];

fn format_xlog_record_header(auto hdr) {
    rmgr_info = hdr.xl_info.rmgr_info << 4;
    return std::format("{} {} {}",
      format_xlogrecptr(hdr.lsn), hdr.xl_rmid, record_identify(hdr.xl_rmid, rmgr_info)
    );
};


struct XLogRecord {
    auto start_address = $;
    XLogRecordHeader hdr;
    auto end_address = start_address + hdr.xl_tot_len;

    std::print(std::format("Parsed record header {} at 0x{:X}, prev {}, len: 0x{:X}",
      hdr, start_address, format_xlogrecptr(hdr.xl_prev), hdr.xl_tot_len));


    current_block = 0;
    data_total = 0;
    main_data_length = 0;
    rmgr_id = hdr.xl_rmid;
    rmgr_info = hdr.xl_info.rmgr_info << 4;

    FragmentHeader fragment_headers[while($ < end_address - data_total)];
    FragmentData fragment_datas[std::core::member_count(fragment_headers)];

    std::mem::AlignTo<8>;
    nrecords = nrecords + 1;
} [[format("format_xlog_record")]];

fn format_xlog_record(auto rec) {
    return format_xlog_record_header(rec.hdr);
};

// XLog Page //

bitfield XLogPageInfoFlags {
    first_is_contrecord : 1;
    long_header         : 1;
    bkp_removable       : 1;
    first_is_overwrite_contrecord : 1;
    reserved            : 12;
};

struct XLogPageHeader {
  u16 xlp_magic;
  if (xlp_magic == 0) {
    break;
  }
  XLogPageInfoFlags xlp_info;
  TimeLineID xlp_tli;
  XLogRecPtr xlp_pageaddr;
  u32 xlp_rem_len;
  padding[4];

  // Long page header
  if (xlp_info.long_header) {
    u64 xlp_sysid;
    u32 xlp_seg_size [[format("type::impl::size_formatter")]];;;
    u32 xlp_xlog_blcksz;
    global_page_size = xlp_xlog_blcksz;
  }
};

bool is_first_page = true;
std::mem::Section page_content;
struct XLogPage {
  XLogPageHeader page_header;

  auto available_record_data = std::math::min(global_page_size - sizeof(page_header), std::mem::size() - $);
  // First contrecord we're parsing, skip it
  if (is_first_page && page_header.xlp_info.first_is_contrecord) {
    if (page_header.xlp_rem_len > available_record_data) {
      // Continuation record uses the whole page, skip it
      std::print(std::format("Whole page contains a contrecord, rem len {}, skipping {} bytes",
        page_header.xlp_rem_len, available_record_data));
      u8 record_data[available_record_data];
      continue;
    }
    // Advance the cursor
    auto skipping = std::mem::align_to(8, page_header.xlp_rem_len);
    $ += skipping;
    std::print(std::format("Skipping remaining of the first contrecord, rem len {}, skipping {}, new pos: 0x{:X}",
       page_header.xlp_rem_len, skipping, $));
    u8 record_data[available_record_data - skipping] [[hidden]];
  } else {
    u8 record_data[available_record_data] [[hidden]];
  }

  if (is_first_page) {
    is_first_page = false;
    const str record_magic = "\xFF\xD1";
    const str version_str = str(pg_version);
    u8 page_addr[8] @ addressof(page_header.xlp_pageaddr) [[hidden]];

    std::mem::copy_value_to_section(record_magic, page_content, std::mem::get_section_size(page_content));
    std::mem::copy_value_to_section(version_str, page_content, std::mem::get_section_size(page_content));
    std::mem::copy_value_to_section(page_addr, page_content, std::mem::get_section_size(page_content));
    std::mem::set_section_size(page_content, 0x28);
  }

  // Copy the page content to the virtual file
  std::mem::copy_value_to_section(record_data, page_content, std::mem::get_section_size(page_content));
};


struct Data {
  is_first_page = true;
  if (is_page()) {
    // Create the section that will contain the content of all pages
    page_content = std::mem::create_section("page_content");

    // Parse the pages, this will fill the section with pages' payload
    XLogPage pages[while(is_page() && !std::mem::eof())];

    // And copy section's content to a virtual file
    u8 page_bytes[std::mem::get_section_size(page_content)] @ 0x00 in page_content;
    hex::core::add_virtual_file("page_content", page_bytes);
    std::warning("Open page_content virtual file and apply the pattern to parse the records.");
    break;
  }

  u16 fake_magic [[hidden]];
  u8 fake_version [[hidden]];
  XLogRecPtr fake_page_addr [[hidden]];

  pg_version = fake_version;
  global_page_addr = fake_page_addr;
  std::mem::AlignTo<0x28>;
  XLogRecord records[while(std::mem::read_unsigned($, 4) > 0 && (nrecords < limitRecords || limitRecords == 0))];
  return;
} [[inline]];

Data data @ 0x0;
