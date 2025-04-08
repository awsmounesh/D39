#check if the user is already exists and create a user if it does not exist.
#Generate a random password for the user and assign it.
#Make sure uaser has sudo persmission.
#Exprire the password for the user to reset it.

#!/bin/bash
SLACK_WEB='https://hooks.slack.com/services/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'
#USERNAME=$1
if [ $# -gt 0 ]; then
    for USERNAME in $@; do
        EXISTING_USER=$(cat /etc/passwd | grep $USERNAME | cut -d ":" -f1)
        if [ "${USERNAME}" = "${EXISTING_USER}" ]; then
            echo "User $USERNAME already exists.Try a Different username."
        else
            echo "Lets Create user ${USERNAME}."
            sudo useradd -m $USERNAME --shell /bin/bash -d /home/${USERNAME}
            sudo usermod -a -G root ${USERNAME}
            echo '${USERNAME} ALL=(ALL) NOPASSWD: ALL' >>/etc/sudoers
            SPEC=$(echo "!@#$%^&*()_+" | fold -w1 | shuf | head -1)
            PASSWORD="India@${RANDOM}${SPEC}"
            echo "${USERNAME}:${PASSWORD}" | sudo chpasswd
            passwd -e $USERNAME
            echo "The Temporary Credentails are ${USERNAME} and ${PASSWORD}"
            curl -X POST ${SLACK_WEB} -sL -H 'Content-type: application/json' --data "{"text": \"The Username is: ${USERNAME}\"}" >>/dev/null
            curl -X POST ${SLACK_WEB} -sL -H 'Content-type: application/json' --data "{"text": \"Temporary password is: ${PASSWORD}  Reset This Password Immedialtly.\"}" >>/dev/null
        fi
    done
else
    echo "You have given $# arguments. Please provide altest One Arg"
fi
