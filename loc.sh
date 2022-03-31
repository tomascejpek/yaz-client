#!/bin/bash

dataPath=$(bash ini.sh getValue dataPath)
ids=$(bash ini.sh getValue idsFile)
format=$(bash ini.sh getValue format)

while read line; do
  while true; do
    echo $line
    ./yaz-client.sh $line $dataPath $format
    if [ "$format" == "xml" ]; then
      echo '<collection>' | cat - $dataPath$line.$format >temp && mv temp $dataPath$line.$format # first line
      echo "</collection>" >>$dataPath$line.$format                                              # end of file
      xml_pp $dataPath$line.$format && break
    else
      break
    fi
  done
done <$ids
