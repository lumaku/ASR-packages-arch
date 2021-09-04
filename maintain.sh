#!/bin/bash

# 2020, Ludwig Kürzinger, Technische Universität München

# exit on error
set -e

packages="python-ctc-segmentation-git"
# espnet packages
packages="${packages} python-espnet-git"
packages="${packages} python-g2p-git"
packages="${packages} python-kaldiio-git"
packages="${packages} python-wandb-git"
packages="${packages} python-pytorch-complex-git"
packages="${packages} python-pytorch-wpe-git"
packages="${packages} python-sentencepiece-git"
packages="${packages} python-espnet-model-zoo-git"
packages="${packages} python-espnet-tts-frontend-git"
# k2
packages="${packages} python-k2-git"
# s3prl
#packages="${packages} python-s3prl-git"
packages="${packages} python-normalise-git"
packages="${packages} python-dtw-python-git"
# speechbrain packages
packages="${packages} python-hyperpyyaml-git"
packages="${packages} python-huggingface-hub-git"
packages="${packages} python-speechbrain-git"


# löchen
# packages="${packages} python-richenum-git"
# packages="${packages} python-normalize-git"


# Remotes with HTTPS: https://aur.archlinux.org/${remote}.git
# Remotes with SSH:   ssh://aur@aur.archlinux.org/${remote}.git

BASEDIR=$(pwd)
BASEDIR=$(dirname "$0")

BUILDDIR="${BASEDIR}/build"

# use absolute paths
BASEDIR=$(realpath ${BASEDIR})
BUILDDIR=$(realpath ${BUILDDIR})



cmd_usage() {
    PROGRAM=$(basename "$0")
    cat >&2 <<-_EOF
    DESCRIPTION
        This is just a script I wrote for myself
        for automatic managing of ESPnet dependencies
        as AUR packages
    
    USAGE
        ${PROGRAM} <mode>
            mode      Select script functionality
        Modes
            init        Only run this the first time
            pull        check for changes in remotes
            rebuild     (re)build all packages
            commit      commit changes
            push        push changes
            full        pull + rebuild + commit + push
            clean       clean all
            print       print package list with badges
            show        show changes
	_EOF
    exit 1
}

init(){
    echo "Build folder: ${BUILDDIR}"
    if [ -d "${BUILDDIR}" ]; then
        echo "BUILDDIR already exists."
        echo ${BUILDDIR}
        echo "INIT should only be done once."
        exit 1
    fi
    mkdir -p ${BUILDDIR}
    cd ${BUILDDIR}
    # download from AUR
    for remote in ${packages}; do
        echo "Cloning from AUR: ${remote}"
        git clone ssh://aur@aur.archlinux.org/${remote}.git
        echo "Adding Github remote to ${remote}"
        cd ${remote}
        git remote add github git@github.com:lumaku/${remote}.git
        cd ${BASEDIR}
    done
}

nuclear(){
    echo "Action: rm -rf ${BUILDDIR}"
    read -p "you sure??? " -n 1 -r
    if [[ $REPLY =~ ^[YyJj]$ ]]
    then
        rm -rf ${BUILDDIR}
    fi
}


push(){
    echo "  ------  action: push"
    echo "Remotes: ${packages}"
    for remote in ${packages}; do
        echo "Pushing ${remote}"
        cd ${BUILDDIR}/${remote}
        git push origin master
        git push github master
        cd ${BASEDIR}
    done
}


rebuild(){
    echo "  ------  action: rebuild"
    echo "Remotes: ${packages}"
    for remote in ${packages}; do
        echo "Rebuilding ${remote}"
        cd ${BUILDDIR}/${remote}
        makepkg -sf
	    makepkg --printsrcinfo > .SRCINFO
        cd ${BASEDIR}
    done
}

commit(){
    echo "  ------  action: commit"
    echo "Remotes: ${packages}"
    DATESTR=$(date +"%Y-%m-%d")
    for remote in ${packages}; do
        cd ${BUILDDIR}/${remote}
        CHANGES=$(git diff .SRCINFO)
        if [ -n "${CHANGES}" ]; then
            echo "Commiting changes in ${remote}"
            git add -u
            git commit -m "Update ${DATESTR}"
        else
            echo "No changes in ${remote}"
        fi
        cd ${BASEDIR}
    done
}


show_changes(){
    for remote in ${packages}; do
        cd ${BUILDDIR}/${remote}
        echo " + ${remote}:"
        git status --porcelain -uno
        git diff -G"pkgver =" --word-diff --unified=0 --no-commit-id --color=always | grep --color=never pkgver || true
        cd ${BASEDIR}
    done
}


pull(){
    echo "  ------  action: pull"
    echo "Remotes: ${packages}"
    for remote in ${packages}; do
        echo "Rebuilding ${remote}"
        cd ${BUILDDIR}/${remote}
        git pull origin master
        cd ${BASEDIR}
    done
}


clean(){
    echo "Cleaning Remotes: ${packages}"
    cd ${BUILDDIR}
    for remote in ${packages}; do
        echo "Cleaning ${remote}"
        rm -r ${remote}/pkg || echo "pkg already clean?"
        rm -rf ${remote}/src || echo "src already clean?"
        rm -rf ${remote}$/{remote} || echo "subrepo already clean?"
        rm ${remote}/${remote}-*.tar.* || echo "tar already clean?"
    done
    cd ${BASEDIR}
}


print(){
    echo "Print README information about: ${packages}"
    sorted=$(echo "${packages}" | tr ' ' '\n' | sort)
    for remote in ${packages}; do
        badge="[![AUR](https://img.shields.io/aur/version/${remote}?style=plastic)](https://aur.archlinux.org/packages/${remote})"
        echo "* \`${remote}\` ${badge}"
    done
}


echo "Build Directory: ${BUILDDIR}"
## Application menu
if   [[ $1 == "full" ]]; then
    clean
    pull
    rebuild
    show_changes
    read -p "continue??? " -n 1 -r
    if [[ $REPLY =~ ^[nN]$ ]]
    then
        exit 0
    fi
    commit
    push
elif [[ $1 == "pull" ]]; then
    pull
elif [[ $1 == "push" ]]; then
    push
elif [[ $1 == "rebuild" ]]; then
    rebuild
elif [[ $1 == "commit" ]]; then
    commit
elif [[ $1 == "clean" ]]; then
    clean
elif [[ $1 == "show" ]]; then
    show_changes
elif [[ $1 == "print" ]]; then
    print
elif [[ $1 == "init" ]]; then
    init
else
    cmd_usage
fi

echo "$(basename "$0") done."