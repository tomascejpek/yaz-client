#!/bin/bash

dataPath=$(bash ini.sh getValue dataPath)
ids=$(bash ini.sh getValue idsFile)
format=$(bash ini.sh getValue format)

while read line; do
  while true; do
    resultFile="$dataPath$line.$format"
    echo $line
    ./yaz-client.sh $line $dataPath $format
    if [ "$format" == "xml" ]; then
      echo '<collection>' | cat - $resultFile >temp && mv temp $resultFile # first line
      echo "</collection>" >>$resultFile                                   # end of file
      xml_pp $resultFile && break
    else
      break
    fi
  done
done <$ids
