#!/bin/bash
alias b='pushd . > /dev/null && cd ~/scorpius_ws && colcon build --symlink-install && popd > /dev/null'

function clean() {
    rm -rf ~/scorpius_ws/build ~/scorpius_ws/install ~/scorpius_ws/log

    source ~/.bashrc

    pushd . > /dev/null
    cd ~/scorpius_ws
    colcon build --symlink-install
    popd > /dev/null

    source ~/.bashrc
    
    pushd . > /dev/null
    cd ~/scorpius_ws
    colcon build --symlink-install
    popd > /dev/null
}