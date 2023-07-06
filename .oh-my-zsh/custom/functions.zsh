pcd () {
        if (($# == 0)); then
                dirs -lp
        else
                __TARGET_DIR=`dirs -pl |rg "$1\\$" 2>/dev/null |head -1`
                if [[ -z $__TARGET_DIR ]]; then
                        print "No entry found in dirstack: $1"
                else
                        cd $__TARGET_DIR
                fi
        fi
}
