// Basic script to execute pa11y on multipe URLs at once without a fail state (above 0) 
// This provides errors in the console but should not error on Circle Ci. 

const shell = require('shelljs');

const urls = {
    home: "https://www.thesquids.co.uk/",
    chess: "https://www.thesquids.co.uk/schedule"
}

for (let url in urls) {
    shell.exec(`pa11y -S ./pa11yOutputs/${url}.png -i "" ${urls[url]} --color always`)
};

console.log("\x1b[36mPa11y has finished running - check the outputs folder for screenshots \x1b[0m");
console.log("\x1b[36mIf there are \033[31mfalse errors\x1b[36m, you can skip these via the ignore flag \x1b[0m");