#!bin/bash

if [ -d "/home/frappe/frappe-bench/apps/frappe" ]; then
    echo "Bench already exists, skipping init"
    cd frappe-bench
    bench start
else
    echo "Creating new bench..."
fi

bench init --skip-redis-config-generation frappe-bench

cd frappe-bench

# Use containers instead of localhost
bench set-mariadb-host mariadb
bench set-redis-cache-host redis:6379
bench set-redis-queue-host redis:6379
bench set-redis-socketio-host redis:6379

# Remove redis, watch from Procfile
sed -i '/redis/d' ./Procfile
sed -i '/watch/d' ./Procfile

bench get-app crm --branch develop

bench new-site crm.growthia.tech \
    --force \
    --mariadb-root-password singh#4343 \
    --admin-password admin \
    --no-mariadb-socket

bench --site crm.growthia.tech install-app crm
bench --site crm.growthia.tech set-config developer_mode 1
bench --site crm.growthia.tech clear-cache
bench --site crm.growthia.tech set-config mute_emails 1
bench use crm.growthia.tech

bench start
