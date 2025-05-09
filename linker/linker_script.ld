SECTIONS
{
  . = DATA_ADDR;

  .custom_data :
  {
    KEEP(*(.custom_data))
  }
}
