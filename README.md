slimerjs-docker-selenium
========================

> This project attempts to run SlimerJS headless browser, as a selenium runner node inside Docker.

## Status

Currently the process is failing, but work is in progress.

## Problems

SlimerJS from version 0.10.0pre supports the GhostDriver, and can connect to Selenium Grid Hub. Unfortunately, after connecting it is not able to get tasks from the Hub, and execute required steps.

On trial it fails with:

```
Error forwarding the new session new session request for webdriver should contain a location header or an 'application/json;charset=UTF-8' response body with the session ID.
```

I also tried to run it as a standalone selenium runner, without the grid, and send requests straight to it, but in than just fails with `Bad Request` information.

The webdriver log file does not contain any information on any of those errors.

To get to the logs of the webdriver, a line in the original source of SlimerJS has to be commented out. The line is presented [here](https://github.com/laurentj/slimerjs/blob/master/src/vendors/ghostdriver/logger.js#L103). This is done during the Docker build step of the SlimerJS image, by substituting the current version of this file with the [fix.data](fix.data) file.

## Setup

To run the prepared image you can just run `docker-compose up` and it should build the SlimerJS image, and run it. Additionally it will run a Selenium Grid image, and link the two containers together. You can later communicate with the Grid and the runner through `<DOCKER_IP>:4444`, and by selecting the runner for your selenium tests to be `phantomjs`.
