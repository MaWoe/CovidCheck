# CovidCheck
Checks the website of my Covid 19 test's laboratory for result

The test laboratory is located in Freiburg / Germany and I guess
its test result website's HTML structure is completely unique.

Requirements
------------

Python libraries:
- `robotframework` >= 3.0
- `robotframework-seleniumlibrary` >= 3.?
- `selenium`

Additionally you need to have a Selenium server running on
localhost bound to port 4444 and a Chrome installation.

You can use docker for running a headless Chrome instance, e.g. https://hub.docker.com/r/yukinying/chrome-headless-browser-selenium
which comes bundled with a Selenium server.

Usage
-----

Run `./check.sh` to see usage.
