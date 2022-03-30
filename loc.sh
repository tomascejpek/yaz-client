#!/bin/bash

while read line; do
  echo $line
  ./yaz-client.sh $line
done </home/tomas/locids
