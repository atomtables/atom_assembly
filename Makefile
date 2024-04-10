boot.bin: *.asm */*.asm # if any asm file changes recompile
	/opt/homebrew/bin/nasm -f bin /Users/atomtables/Code_Projects/atom_asm/boot.asm -o /Users/atomtables/Code_Projects/atom_asm/boot.bin

run: boot.bin # main target
	/opt/homebrew/bin/qemu-system-x86_64 -drive file=/Users/atomtables/Code_Projects/atom_asm/boot.bin,format=raw -monitor stdio
