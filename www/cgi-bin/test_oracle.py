#!/usr/bin/env python3
import cgitb
cgitb.enable()
import os
import cx_Oracle

def main():
  l_database = 'OPVDA'
  print('Content-Type: text/html;charset=utf-8')
  print()
  print("""<html>
 <head>
  <title> Test met python en oracle </title>
 </head>
 <body>
""")
  con = cx_Oracle.connect('/@'+l_database)

  cur = con.cursor()
  t="select user from dual"
  cur.execute(t)
  results = []
  for result in cur:
    results.append(result)
    print("<h1>" + result[0] + "</h1>")  
  
  #print(results)
  cur.close()
  con.close()

  print("""</body>
</html>
""")

if __name__ == '__main__':
  main()
