#!/usr/bin/env zsh
# compares checksum of given file
# ${1} is checksum, optionally preceded by algorithm (e.g. sha256:xxxx)
# ${2} is path to the file
# sets exit code to result of specified checksum algorithm (usually 0 is OK, 2 is fail)

file_path=${2}

if [[ ${1} =~ ".*:.*" ]]
then
    algo=${1%%:*}
    checksum_val=${1##*:}
else
    #echo ">>2"
    algo="sha256"
    checksum_val=${1}
fi

${algo} -qc ${checksum_val} ${file_path} > /dev/null
