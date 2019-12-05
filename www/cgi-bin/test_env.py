#!/usr/bin/env python3
import os
import re
def main():
  print('Content-Type: text/html;charset=utf-8')
  print()
  print("""<html>
 <head>
  <title> Test met python en oracle </title>
 </head>
 <body>
""")
  print(os.environ)
  print('</br>')
  for key in os.environ:
    if not re.search(r'BASH_FUNC', key):
      print(key + ' ==> ' + os.environ[key] + '</br>')

  print("""</body>
</html>
""")

if __name__ == '__main__':
  main()
