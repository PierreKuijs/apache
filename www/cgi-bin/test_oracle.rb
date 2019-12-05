#!/usr/bin/env ruby
require 'oci8'
###########
## Main
###########

puts 'Content-Type: text/html;charset=utf-8'
puts ""
puts <<-EOS
<html>
 <head>
  <title> Test met ruby en oracle </title>
 </head>
 <body>
EOS
dbs = 'OPVDA'
conn = OCI8.new(nil,nil,dbs)
cur = conn.parse('select user from dual')
cur.exec
cur.fetch do |v|
  printf "<h1>%s</h1>\n", v[0]
end
cur.close
conn.logoff
puts <<-EOS
</body>
</html>
EOS

