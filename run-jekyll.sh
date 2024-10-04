#!/bin/bash
echo "Removing the _site directory..."
rm -rf _site

echo "Starting Jekyll server with LiveReload..."
bundle exec jekyll serve --livereload
