#!/bin/bash
if [ -z "$REPO" ]; then
    echo REPO not defined
    exit -1
fi
if [ -z "$REF" ]; then
    echo REF not defined
    exit -1
fi
if [ -z "$DIR" ]; then
    echo DIR not defined
    exit -1
fi
if [ -z "$REPO_HOST" ]; then
    echo REPO_HOST not defined
    exit -1
fi
if [ -z "$REPO_PORT" ]; then
    echo REPO_PORT not defined
    exit -1
fi
if [ -z "$SYNC_TIME" ]; then
    echo SYNC_TIME not defined
    exit -1
fi

mkdir -p ~/.ssh/

ssh-keyscan -p $REPO_PORT $REPO_HOST >> ~/.ssh/known_hosts

if [ "$PRIVATE_KEY_CONTENT" ]; then
    echo "Creating private key content at /keys/$PRIVATE_KEY"
    mkdir -p /keys
    echo -e "$PRIVATE_KEY_CONTENT" > /keys/$PRIVATE_KEY
fi

if [ $PRIVATE_KEY ]; then
    # Put the private keys in /keys path

    cp -rL /keys/* ~/.ssh/
    chmod 600 ~/.ssh/*
    echo -e "Host $REPO_HOST\n  Port $REPO_PORT\n  IdentityFile ~/.ssh/$PRIVATE_KEY" > ~/.ssh/config
fi

if [ -d "$DIR" ]; then
    rm -rf $( find $DIR -mindepth 1 )
fi
git clone $REPO -b $REF $DIR
cd $DIR
while true; do
    git fetch origin $REF;
    git reset --hard origin/$REF;
    git clean -fd;
    date;
    sleep $SYNC_TIME;
done
