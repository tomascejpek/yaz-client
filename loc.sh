#!/bin/bash

while read line; do
  while true; do
    echo $line
    echo "<collection>" >'/home/tomas/harvester/loc/'$line'.xml'
    ./yaz-client.sh $line
    echo "</collection>" >>'/home/tomas/harvester/loc/'$line'.xml'
    xml_pp '/home/tomas/harvester/loc/'$line'.xml' && break
  done
done </home/tomas/locids
