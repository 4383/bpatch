function apply_the_patch () {
    pwd
    if [ -f README.md ]; then
        if [ -f setup.py ]; then
            echo "------------------"
            echo "Need to be patched"
            echo "------------------"
            cat ${patch}/patch.diff
            patch setup.cfg -i ${patch}/patch.diff
            if [ $? != 0 ]; then
                exit 1
            fi
            git add setup.cfg
            git commit -m "$(cat ${patch}/commit.msg)"
            git review -t $(basename ${patch})
        fi
    else
        echo "Don't need to be patched"
    fi
}
