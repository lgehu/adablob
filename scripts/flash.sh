USAGE="Usage: flash.sh FILES... ADDRESS"
DATAFILE=datafile.tmp
args=($@)
len=${#args[@]}
if [[ $len < 2 ]] then
    echo "Missing argument FILE or ADDRESS"
    echo $USAGE
    exit 1
fi
FILES=${args[@]:0:$(expr $len - 1)}
ADDR=${args[$(expr $len - 1)]}
cat $FILES > obj/$DATAFILE
st-flash write obj/$DATAFILE $ADDR
