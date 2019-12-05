#!/usr/bin/env python3
import os
import cx_Oracle
import HTML
import cgitb

def main():
  cgitb.enable()
  l_database = 'PNPR1'
  sel = """select * from COMP_WOT.WOT_WOKP_UITGAAND t order by t.datum_mutatie desc"""
  sel = """select t.datum_verstuurd
                , t.puv_aansluitnummer   PUV
                , t.aantal_bsn_verstuurd verstuurd
                , t.aantal_bsn_ontvangen ontvangen
                , t.aantal_bsn_fout_npr  fout_npr
                , t.aantal_bsn_fout_wo   fout_wo
                , t.datum_antwoord       datum
from COMP_NPC.NPC_WOKP_UITGAAND_BERICHTEN t 
order by t.datum_verstuurd desc"""
  sel2 = """select to_char(t.datum_bericht,'YYYYIW') jaarweek, t.regeling,to_char(t.datum_bericht,'IW') weeknr, t.npr_status, count(1) aantal
from COMP_WOT.WOT_WOKP_INKOMEND t
where to_char(t.datum_bericht,'YYYYIW') >= to_char(sysdate - 7 * 10,'YYYYIW')
group by t.regeling,to_char(t.datum_bericht,'YYYYIW'), to_char(t.datum_bericht,'IW'), t.npr_status
order by to_char(t.datum_bericht,'YYYYIW') desc, t.regeling, t.npr_status"""

  con = cx_Oracle.connect('/@'+l_database)
  cur = con.cursor()
  cur.execute(sel)
  results = []
  for result in cur:
    results.append(result[1:])

  col_names = [row[0] for row in cur.description[1:]]

  cur.close
  con.close

  start =  """

<html>
<!DOCTYPE html>
<head>
  <link rel="stylesheet" type="text/css" href="/table.css">
  <title>
    Overzicht uitgaande waardeoverdrachten KleinPensioen
  </title>
</head>
 <body alink="#00c6c9" link="#0060ff" vlink="#6e00ce"> 
<h1>Overzicht uitgaande waardeoverdrachten KleinPensioen.</h1><br/>
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
  main()

