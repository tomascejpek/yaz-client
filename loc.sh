#!/bin/bash

dataPath=$(bash ini.sh getValue dataPath)
ids=$(bash ini.sh getValue idsFile)

while read line; do
  while true; do
    echo $line
    echo "<collection>" >$dataPath$line'.xml'
    ./yaz-client.sh $line $dataPath
    echo "</collection>" >>$dataPath$line'.xml'
    xml_pp $dataPath$line'.xml' && break
  done
done <$ids
