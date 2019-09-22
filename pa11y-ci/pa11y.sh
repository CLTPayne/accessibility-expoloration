#!/bin/bash

 set -a

 killall_descendants() {
    pids=`pgrep -P $1`
    if [[ -z "$pids" ]]; then kill $1; fi;
    for pid in $pids; do
        killall_descendants $pid
    done
}

 . .env
NODE_ENV=test
PORT=8083

 # start fake api server
 # Exmaple
node ./test/api/fake-server.js &
fid=$!

 # set spark api and fotoware api to fake server
API_ROOT="http://localhost:${FAKE_SERVER_PORT:-3000}"

 npm run production:server &
pid=$!

 sleep 5 && node_modules/.bin/pa11y-ci

 if [ $? -eq 0 ]
then
    echo "Successfully passed pa11y tests"
		killall_descendants $fid
		killall_descendants $pid
    exit 0
else
    echo -e "\x1b[36mUh oh. You have accessibility issues in this project.\x1b[0m"
    echo -e "\x1b[36mFor reference, check the screenshots in the ./pa11y folder\x1b[0m"
    echo -e "\x1b[36mIf there are \033[31mfalse errors\x1b[36m, you can skip these via the ignore flag\x1b[0m"
		killall_descendants $fid
		killall_descendants $pid
		# Change this to a non zero number when ready to break the build on pa11y error
    exit 0
fi