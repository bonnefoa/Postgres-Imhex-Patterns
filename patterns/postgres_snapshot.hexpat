#pragma author "Anthonin Bonnefoy"
#pragma description "PostgreSQL Serialized Snapshot"
#pragma little endian
#pragma magic [01 E0 A1 51] @ 0x00

import type.time;

using pg_time_t = type::time64_t;

using TimeLineID = u32;
using XLogRecPtr = u64 [[format("format_xlogrecptr")]];
using TransactionId = u32;
using FullTransactionId = u64;
using MultiXactId = TransactionId;
using MultiXactOffset = u32;
using MultiXactOffset_PG19 = u64;
using Oid = u32;

fn format_xlogrecptr(auto rec_ptr) {
    return std::format("{:X}/{:X}", rec_ptr >> 32, rec_ptr & 0xffffffff);
};

enum SnapBuildState: u32 {
  START = -1,
  BUILDING_SNAPSHOT = 0,
  FULL_SNAPSHOT = 1,
  CONSISTENT = 2,
};

enum SnapshotType: u8 {
  MVCC = 0,
  SELF = 1,
  ANY = 2,
  TOAST = 3,
  DIRTY = 4,
  HISTORIC_MVCC = 5,
  NON_VACUUMABLE = 6,
};

struct Committed
{
  u64 xcnt;
  u64 xcnt_space;
  bool includes_all_transactions;
  padding[7];
  u64 xip;
};

struct CatChange
{
  u64 xcnt;
  u64 xip;
};

struct SnapBuild
{
  SnapBuildState state;

  padding[4];
  u64 context;

  TransactionId xmin;
  TransactionId xmax;

  XLogRecPtr start_decoding_at;
  XLogRecPtr two_phase_at;
  TransactionId initial_xmin_horizon;
  bool building_full_snapshot;
  bool in_slot_creation;

  padding[2];

	u64	snapshot;
  XLogRecPtr last_serialized_snapshot;
  u64 reorder;
  u32 next_phase_at;

  padding[4];

  Committed committed;
  CatChange cat_change;
};

struct SnapBuildOnDisk {
  u32 magic;

  u32 checksum;
  u32 version;
  u32 length;

  SnapBuild	builder;
};

SnapBuildOnDisk snap_build_on_disk @ 0x0;
