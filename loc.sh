#!/bin/bash

dataPath=$(bash ini.sh getValue dataPath)
ids=$(bash ini.sh getValue idsFile)
format=$(bash ini.sh getValue format)

while read line; do
  error=0
  while [ $error -lt 5 ]; do
    resultFile="$dataPath$line.$format"
    echo $line
    ./yaz-client.sh $line $dataPath $format
    if [ "$format" == "xml" ]; then
      echo '<collection>' | cat - $resultFile >temp && mv temp $resultFile # first line
      echo "</collection>" >>$resultFile                                   # end of file
      xml_pp $resultFile && break
      rm $resultFile
    else
      break
    fi
    ((error += 1))
  done
done <$ids
