#!/usr/bin/env python3
from skelet_html import skelet_html
import cgi, cgitb

def main():
  # Create instance of FieldStorage 
  form = cgi.FieldStorage()
  # Get data from fields
  first_name = form.getvalue('first_name')
  l_database = form.getvalue('database')
  title = form.getvalue('title')
  sel = form.getvalue('sel')
  sel = 'select * from (' + sel + ') where rownum <= 40'
  try:
    skelet_html(l_database, sel, title)
  except Exception as e:
    print("Content-type:text/html\r\n\r\n")
    print("<html>")
    print("<head>")
    print("<script>")
    print('function reset_addr() {window.history.replaceState("string", "Title", "/");}')
    print("</script>")
    print("<title>Fout in het uivoeren van de query</title>")
    print("</head>")
    print("<body>")
    print("<script> reset_addr(); </script> ")
    print("<h2>Fout in het uivoeren van de query</h2>")
    print("type error: " + str(e))
    print("</body>")
    print("</html>")


if __name__ == '__main__':
  main()
