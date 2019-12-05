#!/usr/bin/env ruby
require 'oci8'
require 'thamble'

class String
  def numeric?
    Float(self) != nil rescue false
  end
end

def create_html(cols, res)
  # proc_td = Proc.new {|a, b, c, d| b == 3 ? {:align=>"right"} : nil} #{:align=>"left"}}
  align_td = Proc.new {|a| (! a.instance_of? String) || a.numeric? ? {:align=>"right"} : nil} #{:align=>"left"}}
  start=<<EOT

<html>
<!DOCTYPE html>
<head>
  <style>
table, th, td {
  border: 1px solid black;
}
  table {
        margin-left: 88px;
        border-collapse: collapse;
      }
</style>
  <title>
    Overzicht Deelnemerstatus Opvraging
  </title>
</head>
<body style="color: rgb(0, 0, 0); background-color: rgb(255, 255, 255); background-image: url(/backgr_eg02.gif);" alink="#00c6c9" link="#0060ff" vlink="#6e00ce">
<h1>Overzicht van opvragen deelnemerstatus</h1><br/>
EOT

  eind=<<EOT
</body>
  
</html>
EOT

  puts start
  puts Thamble.table(res, :headers => cols, :td => align_td)
  # p cols
  # p res
  puts '<br/>'
  puts eind
end
                           
###########
## Main
###########

DB="OPVDB"
puts ""
conn = OCI8.new(nil,nil,DB)
sel = <<EOT
select t.regeling,to_char(t.datum_bericht,'IW') weeknr, t.npr_status, count(1) aantal  from COMP_WOT.WOT_WOKP_INKOMEND t
where t.datum_bericht >= sysdate - 7 * 10
group by t.regeling,to_char(t.datum_bericht,'IW'), t.npr_status
order by to_char(t.datum_bericht,'IW') desc, t.regeling, t.npr_status
EOT
sel1 = <<EOT
select t.regeling,to_char(t.datum_bericht,'yyyy-mm-dd') datum, t.npr_status, count(1) aantal  from COMP_WOT.WOT_WOKP_INKOMEND t
group by t.regeling,to_char(t.datum_bericht,'yyyy-mm-dd'), t.npr_status
order by to_char(t.datum_bericht,'yyyy-mm-dd') desc, t.regeling, t.npr_status
EOT

res = []
cur = conn.parse(sel)
cur.exec()
cols = cur.get_col_names
cur.fetch do |v|
  res << v.map{|i| i.class.to_s == "BigDecimal" ? "%d" % i : i}
end
cur.close
conn.logoff
create_html(cols, res)
