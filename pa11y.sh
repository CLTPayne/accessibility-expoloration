#!/bin/bash

# Start test server in the background
NODE_ENV=test PORT=4579 VAULT_PATH=secret/teams/internal-products/ip-people-finder/development node --require @financial-times/vaultenv server/index.js --silent &

# Wait for the node server to start up
echo "Waiting for Node to start..."
sleep 3

# Run Pa11y accesibility tests
echo "Starting Pa11y..."
echo "Remember, these tests find max 40% of potential accessibility issues in your site"

# HTML version
# node_modules/.bin/pa11y --threshold 1 --reporter html http://localhost:4579/  > ./pa11y/pa11y-results-home.html
# exitcode=$?
# echo "exit code = " $exitcode
# node_modules/.bin/pa11y --threshold 73 --reporter html http://localhost:4579/search?name=matt.chadburn > ./pa11y/pa11y-results-search.html
# exitcode=$(($exitcode + $?))
# echo "exit code = " $exitcode
# echo "All pages have been tested"

# Open html output in the browser for 
# open ./pa11y/pa11y-results-home.html
# open ./pa11y/pa11y-results-search.html


# To do add screenshot output
# Swap this for a javascript script?? And call it - easier to configure
echo "Testing http://localhost:4579/:"
node_modules/.bin/pa11y --threshold 8 http://localhost:4579/
exitcode=$?

node_modules/.bin/pa11y --threshold 73 http://localhost:4579/search?name=
exitcode=$(($exitcode + $?))

echo "All pages have been tested"

echo "Finished running Pa11y"

echo "Tests complete - check html out put for results"

# Kill the running processes afterwards
echo "Closing test server."
lsof -ti tcp:4579 | xargs kill --silent

if [ $exitcode -eq 0 ]
then 
    echo "Successfully passed pa11y tests for current threshold"
    echo "You may still have errors for your project - above for full results"
    exit 0
else 
    echo "Uh oh. You've added new accessibility issues to this project."
    echo "Please see the html out put in the ./pa11y folder and fix one more issue"
    exit 2
fi
