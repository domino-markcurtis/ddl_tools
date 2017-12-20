# Grab diags from server
# Note you'll need to wget the sjk jar first!

# Init any vars
DATE=$(date --iso-8601=seconds)

# Output files
OUT_SJK_CPU=$(hostname)-$DATE-sjk-cpu.out
OUT_SJK_ALLOC=$(hostname)-$DATE-sjk-alloc.out
OUT_JSTACK=$(hostname)-$DATE-jstack.out

# Get process id of frontend java
PID=$(sudo -u domino jps | grep "ProdServerStart" | awk '{print $1}')

# Get sjk output
sudo -u domino java -jar sjk-plus-0.8.1.jar ttop -p $PID -o CPU -n 20 >> $OUT_SJK_CPU &
sudo -u domino java -jar sjk-plus-0.8.1.jar ttop -p $PID -o ALLOC -n 20 >> $OUT_SJK_ALLOC &

# Get thread dumps
sudo -u domino jstack -l $PID >> $OUT_JSTACK
