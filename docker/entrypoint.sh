#!/bin/bash
set -e
 
 # generate host keys if not present
ssh-keygen -A

# do not detach (-D), log to stderr (-e), passthrough other arguments
# /usr/sbin/sshd -D -e "$@"

# SSH サーバーがポート 2222 で立ち上がる
# /etc/init.d/sshd start
 
# Remove a potentially pre-existing server.pid for Rails.
rm -f /myapp/tmp/pids/server.pid
 
# 起動時にマイグレーションを実行する
if [[ $RAILS_ENV = 'production' ]]; then
  bundle exec rails db:create
  bundle exec rails db:migrate
fi
 
# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"