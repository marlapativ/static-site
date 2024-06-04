# CSYE7125 Static Site hosted with Caddy

This repository contains configurations and html files for a static site hosted with Caddy.

## Prerequisites

- [Caddy](https://caddyserver.com/docs/install) installed on your machine.

## Getting Started

1. Clone this repository.
2. (**Optional**) Setup the env variable `CADDY_ADDRESS` to the address you want to host the site on. If this is not provided, the config defaults to port ```:8080```.
    ```export CADDY_ADDRESS=:8080```
3. Run `caddy run` in the root directory of this repository.

## Project Structure

- `Caddyfile`: Configuration file for Caddy.
- `index.html`: Homepage of the site.
- `Dockerfile`: Dockerfile for building the container consisting of static site & Caddy.
- `Jenkinsfile`: Jenkins pipeline for building and pushing image of the static site.
