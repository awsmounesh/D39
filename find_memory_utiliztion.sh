#!/bin/bash
SLACK_WEB='https://hooks.slack.com/services/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'
SERVER_NAME=$(curl -sL http://169.254.169.254/latest/meta-data/local-hostname)
Total_MEM=$(free -m | grep -i mem | awk -F " " '{print $2}')
TOTAL_AVL=$(free -m | grep -i mem | awk -F " " '{print $7}')
USED_MEMORY=$(expr $Total_MEM - $TOTAL_AVL)
echo "The total memory in the machine is $Total_MEM MB and CURRENT UTILIAZATION is $USED_MEMORY MB"
X=$(echo "scale=2; $TOTAL_AVL / $Total_MEM" | bc | tr -d '.')
echo "The free memory percentage is ${X}%."
CURRENT_UTIL_PER=$(expr 100 - $X)
if [ $X -lt 10 ]; then
# if (($X <= 40)); then
    echo "Current Memory is utlitized of Server ${SERVER_NAME} is ${CURRENT_UTIL_PER}% "
    curl -X POST ${SLACK_WEB} -sL -H 'Content-type: application/json' --data "{"text": \"Current Memory Utilizaton of server ${SERVER_NAME} is: ${CURRENT_UTIL_PER}\"}" >>/dev/null
else
    echo "Current memory utilization is ${CURRENT_UTIL_PER}% and Within the limits."
fi
