#!/usr/bin/env python3
from skelet_html import skelet_html

def main():
  l_database = 'PNPR1'
  sel = """select t.datum_verstuurd
                , t.puv_aansluitnummer   PUV
                , t.aantal_bsn_verstuurd verstuurd
                , t.aantal_bsn_ontvangen ontvangen
                , t.aantal_bsn_fout_npr  fout_npr
                , t.aantal_bsn_fout_wo   fout_wo
                , t.datum_antwoord       datum
from COMP_NPC.NPC_WOKP_UITGAAND_BERICHTEN t 
order by t.datum_verstuurd desc"""
  title = """Overzicht uitgaande waardeoverdrachten KleinPensioen"""
  skelet_html(l_database, sel, title)

if __name__ == '__main__':
  main()
