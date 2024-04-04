/opt/homebrew/bin/nasm -f bin /Users/atomtables/Code_Projects/nasm_tutorial/boot.asm -o /Users/atomtables/Code_Projects/nasm_tutorial/boot.bin
/opt/homebrew/bin/qemu-system-x86_64 /Users/atomtables/Code_Projects/nasm_tutorial/boot.bin 
