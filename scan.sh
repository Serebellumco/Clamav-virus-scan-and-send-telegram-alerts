#!/bin/bash
echo "" > /var/log/clamav.log
check_scan () {

        if [ `tail -n 12 /var/log/clamav.log  | grep Infected | grep -v 0 | wc -l` != 0 ]
    then
           curl 'https://api.telegram.org/bot(BOT ID)/sendMessage?chat_id=(Chat ID)&text=Infection found and cleaned'
        fi

}
find / -not -wholename '/sys/*' -and -not -wholename '/proc/*' -mmin -61 -type f -print0 | xargs -0 -r clamscan --exclude-dir=/proc/ --exclude-dir=/sys/ --quiet --infected --remove --log=/var/log/clamav.log
check_scan