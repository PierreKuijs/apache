#!/usr/bin/env python3
import cgitb
cgitb.enable()
import os
print('Content-Type: text/html;charset=utf-8')
print()
print("""<html>
 <head>
  <title> Test met python en oracle </title>
 </head>
 <body>
""")
print("<h1>PKU</h1></br>")
os.environ['TNS_ADMIN'] = '/opt/oracle/network/admin'
print(os.environ['TNS_ADMIN'] )
print("""</body>
</html>
""")
