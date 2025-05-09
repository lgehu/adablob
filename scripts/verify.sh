ELF=datablob
SECTION_NAME=custom_data

alr exec -- arm-eabi-objdump bin/$ELF -h | grep $SECTION_NAME
if [[ $? -eq 1 ]] then
    echo "Section "$SECTION_NAME" is not present in the binary. Try to recompile the project"
fi


