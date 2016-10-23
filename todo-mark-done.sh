cat $2 > $2.bak
awk 'NR!~/^('$1')$/' $2 > /tmp/todo.tmp
cat /tmp/todo.tmp > $2
rm /tmp/todo.tmp
#echo "" >> uci-week.widget/index.coffee
