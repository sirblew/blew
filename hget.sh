#!/bin/sh
exec curl --compressed --no-buffer --tcp-nodelay --include --silent --show-error --noproxy '*' --verbose --trace-time --output /dev/null $@
