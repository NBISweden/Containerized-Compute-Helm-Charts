#!/bin/bash

# usage: ./upload.sh <folder> <dataset>

FOLDER=$1
DATASET=$2

sda-admin upload "$FOLDER"

for file in $(sda-admin ingest); do
  sda-admin ingest "$file"
done

sleep 5

for file in $(sda-admin accession); do
  sda-admin accession "$(uuidgen)" "$file"
done

sleep 5

for file in $(sda-admin dataset); do
  sda-admin dataset "$DATASET" "$file"
done
