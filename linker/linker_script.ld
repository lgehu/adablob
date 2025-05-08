.custom_data:
{
    KEEP(*(.custom_data))
} >DATA_FLASH

MEMORY
{
  DATA_FLASH (rx)  : ORIGIN = 0x08060000, LENGTH = 64K
}
