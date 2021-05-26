#!/usr/sbin/dtrace -s

syscall::read:entry
/strstr(execname, "cat") == execname/
{
  self->ts = walltimestamp;
  trace(execname);
  trace(arg0);
  trace(arg2);
}

syscall::read:return
/strstr(execname, "cat") == execname/
{
  trace(walltimestamp - self->ts);
  self->ts = 0;
  trace(execname);
  trace(arg0);
  trace(errno);
}
