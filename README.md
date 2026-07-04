# shell-scripts
Useful Shell Scripts

## Utilities
### checksum.sh
Compares the checksum of a file and outputs whether the checksums match. Calls cksum.sh.

Usage: `./checksum.sh checksum filepath`

### cksum.sh
Compares the checksum of a file and sets the exit code to 0 if match, and anything else (usually 2), if not.

Checksum algorithm is sha256 by default. Any other algorithm can be specified by preceding the checksum value with the algorithm, e.g. sha1:xxxx

Usage: `./cksum.sh checksum filepath`

## AirThings Radon
Processing exported data from [AirThings](https://www.airthings.com) Radon monitors.
