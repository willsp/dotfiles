#!/bin/sh

dotnames=( ant.properties jshintrc slate.js tmux.conf nvimrc zshenv zshrc )

for name in ${dotnames[@]}
do
    if [ -e ~/.${name} ]
    then
        mv ~/.${name} ~/.${name}.pw
    fi

    ln ${name} ~/.${name}
done

