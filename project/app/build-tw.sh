#! /usr/bin/env bash

npx tailwind build ./app/tw-style-base.css -c ./app/tailwind.config.js -o ./app/dist/tailwind-full.css
chown 1000:1000 ./app/dist/tailwind-full.css
chmod g+w ./app/dist/tailwind-full.css