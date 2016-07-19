#!/bin/bash

#http://stackoverflow.com/questions/22009364/is-there-a-try-catch-command-in-bash

function TestingStart()
{
    echo ""
    echo ""
    echo "Testing : $0"
    echo ""
    export TNUM=1
    export TNUMFAIL=0
}

function TestingFinish()
{
    echo ""
    if [ "$TNUMFAIL" != "0" ]; then
        echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" 
        echo "  FAILED on $TNUMFAIL/"$((TNUM-1))" tests"
        echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" 
    else
        echo "====================================================================="
        echo "  SUCCESS on "$((TNUM-1))" tests"
        echo "====================================================================="
    fi
}

function try()
{
    [[ $- = *e* ]]; SAVED_OPT_E=$?
    set +e
}

function tryTest()
{
    echo ""
    echo "====================================================================="
    echo "TEST ($TNUM): '$1'"
    export TEST="$1"
    [[ $- = *e* ]]; SAVED_OPT_E=$?
    set +e
    echo "---------------------------------------------------------------------" 
    export TNUM=$((TNUM+1))
}

function throw()
{
    exit $1
}

function catch()
{
    export ex_code=$?
    (( $SAVED_OPT_E )) && set +e
    return $ex_code
}

function throwSuccess()
{
    ex_code=$?
    set +e
    echo "---------------------------------------------------------------------" 
    echo "  ... success : returned: '$ex_code'"
    echo "====================================================================="
    return $ex_code
}

function throwErrors()
{
    ex_code=$?
    set -e
    echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
    echo " returned: '$ex_code'"
    echo " ERROR: '$TEST'"
    echo "====================================================================="
    export TNUMFAIL=$((TNUMFAIL+1))
}

function ignoreErrors()
{
    set +e
}
