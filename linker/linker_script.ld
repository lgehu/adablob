
SECTIONS {
  . = DATA_ADDR;
  .custom_data :
  {
    KEEP(*(.custom_data))
  } > FLASH
}

MEMORY {
  FLASH (rx) : ORIGIN = DATA_ADDR, LENGTH = 0x1000
}
