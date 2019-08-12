### Accessibility Exploration

Keen to learn more about accessibility and how it's a responsibility of a web developer to ensure the features and products they build are consumable by as many people as possible, regardless of the use of assisted technology. 

#### Tools
1. [Pa11y](https://github.com/pa11y/pa11y/tree/e044480b14c84c489b2f5846567dd252ad9018cf#examples)
##### Live App:
Used the cli (rather than node option) to run the following queries against a basic javascript and html [chess game repo](https://github.com/CLTPayne/pairing-rowan):

```pa11y http://127.0.0.1:8080/chessboard.html -S ./pa11yOutputs/screenCaptureLocalServedChessSite.png -r json > ./pa11yOutputs/reportLocalServedChessSite.json```

This runs the test against the whole home page, and encountered 31 errors (plus further notices and warnings that you can choose to include in the output with `--include-warnings` or `--include-notices`). 

You can also see a snapshot of the site the report has been run against. This confirms that the test has been run against the intended portion of the site. 

##### Absolute Path To HTML:
```pa11y ~/Documents/Projects/pairing-rowan/chessboard.html -S ./pa11yOutputs/screenCaptureAbsolutePathToChessHTML.png -r json > ./pa11yOutputs/reportAbsolutePathToChessHTML.json```

This means that anything rendered with javascript or not client rendered will not be part of the tested page. You can see this evidenced in the screenshots included in this repo. 

Learning:
1. Really need to run against the served site. 

Issue:
1. How to access the other pages of the app?

#### Parallel NPM Script: 
Use `npm-run-all` to run a series of scripts in parallel. This enables spinning up the server for running the application locally. 
Adding in a sleep / wait in order to allow time for the site to build and in order to shut down the app. 
![Parallel Script](./run_pa11y_via_npm_script.png)

Iteration:

Goal - the most simple implementation that shows devs the errors but doen't error / exit any process with a non `0` value. 

- Decided to use a node script to enable running of `pa11y` with multiple urls. 
- Implemented with [shelljs](https://www.npmjs.com/package/shelljs) as it enables use of the linux shell within node. 
- By using Javascript this is hopefully more familar than a bash script, and will not need executing rights. 
- The object data structure means that urls can be reference by property and value, enabling dynamically named screenshot output.
- Exit code is 0 regardless of whether test pass or fail. 
- Add bespoke messaging via Javascript to amplify the pa11y output.
- Assumes that the application is all ready built and running.

Next steps:
    - Add to a test script (last part or first part?)