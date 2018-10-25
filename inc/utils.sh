#!/bin/bash

function verify_directory_exists {

  # Check that the directory actally exists
  if [ ! -d "$1" ]; then
    log "ER" "Expecting directory at '${1}'"
    exit 1
  fi
}

function verify_file_exists {

  # Check that the file actally exists
  if [ ! -f "$1" ]; then
    log "ER" "Expecting file at '${1}'"
    exit 1
  fi
}
