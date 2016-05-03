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

## Setup

To run the prepared image you can just run `docker-compose up` and it should build the SlimerJS image, and run it. Additionally it will run a Selenium Grid image, and link the two containers together. You can later communicate with the Grid and the runner through `<DOCKER_IP>:4444`, and by selecting the runner for your selenium tests to be `phantomjs`.

You can also connect to the runner on `<DOCKER_IP>:8080` as a standalone selenium runner, bypassing the grid.
