#!/usr/sbin/dtrace -s

syscall::posix_spawn:entry
{
  printf("pid ptr: %p\n", arg0);
  printf("path: %s\n", copyinstr(arg1));
  self->pptr = arg0;
}

syscall::posix_spawn:return
{
  p = (pid_t*) copyin(self->pptr, sizeof(pid_t));
  printf("pid: %d\n", *p);
}
