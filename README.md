# rsync_backup

crontab -e:
```bash
# m h  dom mon dow   command
  0 3   *   *   *    /usr/local/bin/rsync_backup.sh --verbose
```
