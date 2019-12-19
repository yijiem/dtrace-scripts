#!/usr/sbin/dtrace -s

pid$target:$1::entry
{
  ts[probefunc] = timestamp;
}

pid$target:$1::return
/ts[probefunc]/
{
  @ft[probefunc] = sum(timestamp - ts[probefunc]);
  ts[probefunc] = 0;
}
