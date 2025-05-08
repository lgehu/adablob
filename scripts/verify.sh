ELF=datablob

alr exec -- arm-eabi-objdump bin/$ELF -h | grep "custom_data"
if [[ $? -eq 1 ]] then
    echo "Data is not present in the binary. Try to recompile the project"
fi

