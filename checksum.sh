#!/usr/bin/env zsh
# compares checksum of given file
# calls cksum - see for parameters
# outputs match/mismatch message

cksum.sh ${1} ${2}

if [[ ${?} == "0" ]]
then
    echo "Checksum matches"
else
    echo "Checksum does not match"
fi
