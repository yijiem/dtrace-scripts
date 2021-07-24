struct ustr{uint16_t buffer[256];};

syscall::NtCreateFile:entry,
syscall::NtOpenFile:entry
/execname == "file.exe"/
{
  this->attr = (OBJECT_ATTRIBUTES*)
      copyin(arg2, sizeof(OBJECT_ATTRIBUTES));

  if (this->attr->ObjectName) {
    this->objectName = (UNICODE_STRING*)
        copyin((uintptr_t)this->attr->ObjectName,
        sizeof(UNICODE_STRING));
 
    this->fname = (uint16_t*)
        copyin((uintptr_t)this->objectName->Buffer,
               this->objectName->Length);

    printf("filename %*ws \n", this->objectName->Length / 2, 
           ((struct ustr*)this->fname)->buffer);
  }
  @[probefunc] = count();
}

syscall:::entry
/execname == "file.exe"/
{
  print(probefunc);
  @[probefunc] = count();
}
