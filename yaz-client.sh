#!/usr/bin/expect -f

set id [lindex $argv 0]
set timeout 2

set times 0;
while { $times < 1 } {
  spawn /usr/bin/yaz-client -m /home/tomas/harvester/loc/$id.txt lx2.loc.gov:210/LCDB
  expect -re ".*Connecting...OK.*"
  exp_send "format xml\r"
  exp_send "find @attr  1=9 $id\r"
  expect {
    -re ".*Number of hits: 0.*" {
      set file [open /home/tomas/harvester/loc/$id.txt w]
      puts $file "<record xmlns=\"http://www.loc.gov/MARC21/slim\">
  <datafield tag=\"010\" ind1=\" \" ind2=\" \">
    <subfield code=\"a\">$id</subfield>
  </datafield>
  <datafield tag=\"914\" ind1=\" \" ind2=\" \">
    <subfield code=\"a\">cpk0</subfield>
  </datafield>
</record>"
      close $file
      exit
    }
    -re ".*Number of hits:.*" {
      exp_send "show all\r"
      expect -re ".*Records: .*"
      exit
    }
    -re ".*Not connected yet.*" {
      set file [open /home/tomas/harvester/not-connected.txt a]
      puts $file "$id"
      close $file
      sleep 5
    }
  }
}
exp_send "close\r"
