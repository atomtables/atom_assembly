/opt/homebrew/bin/nasm -f bin /Users/atomtables/atom_asm/nasm_tutorial/boot.asm -o /Users/atomtables/atom_asm/nasm_tutorial/boot.bin
/opt/homebrew/bin/qemu-system-x86_64 /Users/atomtables/atom_asm/nasm_tutorial/boot.bin 
