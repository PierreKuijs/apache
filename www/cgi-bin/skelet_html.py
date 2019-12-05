#!/usr/bin/env python3
import os
import cx_Oracle
import HTML
import cgitb

def skelet_html(l_database, sel, title):
  cgitb.enable()
  # l_database = 'PNPR1'
  con = cx_Oracle.connect('/@'+l_database)
  cur = con.cursor()
  cur.execute(sel)
  results = []
  col_names = [row[0] for row in cur.description]
  noprint='NOPRINT'
  if noprint in col_names:
    i = col_names.index(noprint)
    col_names = col_names[:i] + col_names[i+1:]
    for result in cur:
      results.append(result[:i] + result[i+1:])
  else:
    for result in cur:
      results.append(result)


  cur.close
  con.close

  start = f"""

<html>
<!DOCTYPE html>
<head>
  <link rel="stylesheet" type="text/css" href="/table.css">
  <title>
    {title}
  </title>"""

  start += """
  <script>
  function reset_addr() {window.history.replaceState("", "", "/");}
  </script>
"""
  start += f"""
</head>
 <body alink="#00c6c9" link="#0060ff" vlink="#6e00ce"> 
 <script> reset_addr(); </script>
<h1>{title}.</h1><br/>
"""

  eind = """
</body>
  
</html>
"""

  print(start)
    
  t=HTML.Table(header_row=col_names,cellpadding=2)
  for x in results:
    y = list(map(lambda i: HTML.TableCell(i,align='right') if type(i) is int else i, x))
    t.rows.append(y)
  print(t)
  print('<br/>')

  print(eind)

if __name__ == '__main__':
  skelet_html('OPVDA', "select user naam, 'aap' noprint from dual", 'test_html')
