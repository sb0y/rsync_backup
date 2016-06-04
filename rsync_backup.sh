#!/bin/bash

VERBOSE=""

while [[ $# > 0 ]]
do
key="$1"

case $key in
    -v|--verbose) # my case
    VERBOSE="v"
    shift
    ;;
    -e|--extension)
    EXTENSION="$2"
    shift # past argument
    ;;
    -s|--searchpath)
    SEARCHPATH="$2"
    shift # past argument
    ;;
    -l|--lib)
    LIBPATH="$2"
    shift # past argument
    ;;
    --default)
    DEFAULT=YES
    ;;
    *)
            # unknown option
    ;;
esac
shift # past argument or value
done

OPTS="-ahlrXog${VERBOSE} --delete"
rsync="/usr/bin/rsync"
BACKUP_HOST="srv"
BKP_PATH="/media/data/srv_bkp"

declare -A backups
backups[etc]=etc
backups[sb0y]=home/sb0y
backups[petro]=home/petro
backups[rod]=home/rod
backups[root]=home/root
backups[gitlab]=home/git
backups[vmail]=var/vmail
backups[mysql]=var/lib/mysql
backups[www]=var/www
backups[routers_backups]=routers_backups

for i in "${!backups[@]}"
do
	tmp_path="${BKP_PATH}/${backups[$i]}"

	if [[ "$VERBOSE" ]]; then
		echo -e "\n\r=== BEGIN BACKUPING ${i} ( ${tmp_path} ) MODULE ===\n\r"
	fi	

	mkdir -p "${tmp_path}";
	${rsync} ${OPTS} rsync://${BACKUP_HOST}:/${i} ${tmp_path} || break;
	
	if [[ "$VERBOSE" ]]; then
		echo -e "\n\r=== END BACKUPING ${i} ( ${tmp_path} ) ===\n\r"
	fi
	#echo "key  : $i"
	#echo "value: ${backups[$i]}"
done
