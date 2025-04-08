#!/bin/bash
Total_MEM=$(free -m | grep -i mem | awk -F " " '{print $2}')
TOTAL_AVL=$(free -m | grep -i mem | awk -F " " '{print $7}')
USED_MEMORY=$(expr $Total_MEM - $TOTAL_AVL)
echo "The total memory in the machine is $Total_MEM MB and CURRENT UTILIAZATION is $USED_MEMORY MB"
X=$(echo "scale=2; $TOTAL_AVL / $Total_MEM" | bc | tr -d '.')
echo "The free memory percentage is ${X}%."
CURRENT_UTIL_PER=$(expr 100 - $X)
if [ $X -lt 10 ]; then
    echo "The memory utilization more than is 90%."
else
    echo "The current memory utilization is ${X}% and within the limits."
fi