MEMORY
{
    FLASH ( rx ) : ORIGIN = 0x08000000, LENGTH = 1M  /* Пам’ять флеш */
    RAM ( rxw ) : ORIGIN = 0x20000000, LENGTH = 128K /* Оперативна пам’ять */
}

__stack_start = ORIGIN(RAM) + LENGTH(RAM); /* Верхня межа стеку */
