#!/bin/bash

patch=$(cd $1; pwd -P)

if [ -z ${patch} ];then
    echo "Patch repo is needed! abort"
    exit 1
fi

if [ ! -d ${patch} ];then
    echo "Patch repo not found... abort!"
    exit 1
fi
if [ ! -f ${patch}/scope ]; then
    echo "Projects scope not found... abort!"
    exit 1
fi

ignores=""
if [ -f ${patch}/ignoring ]; then
    ignores=$(cat ${patch}/ignoring)
fi

if [ ! -f ${patch}/patch.diff ]; then
    echo "Patch not found in ${patch}... abort!"
    exit 1
fi

if [ ! -f ${patch}/commit.msg ]; then
    echo "Commit msg not found in ${patch}... abort!"
    exit 1
fi

if [ ! -f ${patch}/cmd.sh ]; then
    echo "Cmd not found in ${patch}... abort!"
    exit 1
else
    source ${patch}/cmd.sh
fi

if [ -d workdir ]; then
    rm -rf workdir
    mkdir workdir
fi

while read scope; do
    projects="$(niet "${scope}" governance/reference/projects.yaml -f ifs)"
    echo -e "will patch:\n${projects}" >> ${patch}/patch.log
    
    cwd=$(pwd)
    
    for el in $projects
    do
        if [[ $ignores =~ (^|[[:space:]])"$el"($|[[:space:]]) ]]; then
            echo "ignoring $el"
            continue
        fi
        echo "Patching: $el"
        cd workdir
        git clone git@github.com:${el}
        cd ./${el/openstack//}
        apply_the_patch
        if [ $? != 0 ]; then
            echo -e "$el\n" >> ${patch}/inerror.log
        fi
        cd ${cwd}
    done
done <${patch}/scope
