#!/bin/bash
alias b='pushd . > /dev/null && cd ~/clankus_ws && colcon build --symlink-install && popd > /dev/null'

function clean() {
    rm -rf ~/clankus_ws/build ~/clankus_ws/install ~/clankus_ws/log

    source ~/.bashrc

    pushd . > /dev/null
    cd ~/clankus_ws
    colcon build --symlink-install
    popd > /dev/null

    source ~/.bashrc
    
    pushd . > /dev/null
    cd ~/clankus_ws
    colcon build --symlink-install
    popd > /dev/null
}