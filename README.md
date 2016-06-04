# rsync_backup

crontab -e:
```
# m h  dom mon dow   command
  0 3   *   *   *    /usr/local/bin/rsync_backup.sh --verbose
```
