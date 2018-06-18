#!/bin/sh
#

export LANG=zh_CN.UTF-8

source /usr/local/lib/python3.6

function make_migrations(){
    cd /opt/jumpserver/utils
    bash make_migrations.sh
}


function make_migrations_if_need(){
    sentinel=/opt/jumpserver/data/inited

    if [ -f ${sentinel} ];then
        echo "Database have been inited"
    else
        make_migrations && echo "Database init success" && touch $sentinel
    fi
}

function start() {
    make_migrations_if_need

    cd /opt/jumpserver
    python run_server.py
}


case $1 in
    init) make_migrations;;
    *) start;;
esac
