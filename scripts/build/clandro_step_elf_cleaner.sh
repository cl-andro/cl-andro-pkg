clandro_step_elf_cleaner() {
	clandro_step_elf_cleaner__from_paths . \( -path "./bin/*" -o -path "./lib/*" -o -path "./lib32/*" -o -path "./libexec/*" -o -path "./opt/*" \)
}

clandro_step_elf_cleaner__from_paths() {
	# Remove entries unsupported by Android's linker:
	find "$@" -type f -print0 | xargs -r -0 \
		"$CLANDRO_ELF_CLEANER" --api-level "$CLANDRO_PKG_API_LEVEL"
}
