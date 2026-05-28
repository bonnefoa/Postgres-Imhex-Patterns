#pragma author "Anthonin Bonnefoy"
#pragma description "PostgreSQL Control Format"
#pragma little endian

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
u32 pg_version = 19;

fn format_xlogrecptr(auto rec_ptr) {
    return std::format("{:X}/{:X}", rec_ptr >> 32, rec_ptr & 0xffffffff);
};

enum DBState: u8 {
  DB_STARTUP = 0,
  DB_SHUTDOWNED,
  DB_SHUTDOWNED_IN_RECOVERY,
  DB_SHUTDOWNING,
  DB_IN_CRASH_RECOVERY,
  DB_IN_ARCHIVE_RECOVERY,
  DB_IN_PRODUCTION,
};

struct CheckPoint
{
  XLogRecPtr  redo;
  TimeLineID  ThisTimeLineID;
  TimeLineID  PrevTimeLineID;
  bool    fullPageWrites;
  padding[3];
  u32     wal_level;
  bool   logicalDecodingEnabled;
  padding[7];
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

  pg_time_t time;
  TransactionId oldestCommitTsXid;
  TransactionId newestCommitTsXid;
  TransactionId oldestActiveXid;
  padding[4];
};

struct Control {
  u64 system_identifier;
  u32 pg_control_version;
  u32 catalog_version_no;
  DBState state;
  padding[7];
  pg_time_t time;
  XLogRecPtr checkPoint;
  CheckPoint checkPointCopy;
  XLogRecPtr unloggedLSN;
  XLogRecPtr minRecoveryPoint;
  TimeLineID minRecoveryPointTLI;
  padding[4];
  XLogRecPtr backupStartPoint;
  XLogRecPtr backupEndPoint;
  bool backupEndRequired;
  padding[3];
  u32 wal_level;
  bool wal_log_hints;
  padding[3];
  u32 MaxConnections;
  u32 max_worker_processes;
  u32 max_wal_senders;
  u32 max_prepared_xacts;
  u32 max_locks_per_xact;
  bool track_commit_timestamp;

  padding[3];
  u32 maxAlign;
  double floatFormat;

  u32 blcksz;
  u32 relseg_size;

  u32 slru_pages_per_segment;

  u32 xlog_blcksz;
  u32 xlog_seg_size;

  u32 nameDataLen;
  u32 indexMaxKeys;

  u32 toast_max_chunk_size;
  u32 loblksize;

  padding[3];
  bool float8ByVal;

  u32 data_checksum_version;

  bool default_char_signedness;
  char mock_authentication_nonce[32];
  padding[3];
  u32 crc;
} [[inline]];

Control control @ 0x0;
