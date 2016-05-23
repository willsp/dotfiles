#!/bin/sh

dotnames=( ant.properties jshintrc slate.js tmux.conf zshenv zshrc )

for name in ${dotnames[@]}
do
    if [ -e ~/.${name} ]
    then
        mv ~/.${name} ~/.${name}.pw
    fi

    ln ${name} ~/.${name}
done

if [ -e ~/config ]
then
    mv ~/config ~/config.pw
fi

ln -s $PWD/config ~/config

