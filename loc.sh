#!/bin/bash

dataPath=$(bash ini.sh getValue dataPath)
ids=$(bash ini.sh getValue idsFile)
format=$(bash ini.sh getValue format)
repeat=$(bash ini.sh getValue repeat)
sleep=$(bash ini.sh getValue sleep)

while read line; do
  error=0
  while [ $error -lt 5 ]; do
    resultFile="$dataPath$line.$format"
    echo $line
    ./yaz-client.sh $line $dataPath $format $repeat $sleep
    if [ "$format" == "xml" ]; then
      if [ -s $resultFile ]; then
        # The file is not empty
        echo '<collection>' | cat - $resultFile >temp && mv temp $resultFile # first line
        echo "</collection>" >>$resultFile                                   # end of file
        xml_pp $resultFile && break
      fi
      rm $resultFile
    else
      break
    fi
    ((error += 1))
  done
done <$ids
