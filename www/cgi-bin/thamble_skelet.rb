#!/usr/bin/env ruby
require 'oci8'
require 'cgi'
require 'thamble'

class String
  def numeric?
    Float(self) != nil rescue false
  end
end

def create_html(cols, res, title)
  # proc_td = Proc.new {|a, b, c, d| b == 2 ? {:align=>"right"} : nil} #{:align=>"left"}}
  align_td = Proc.new {|a| (! a.instance_of? String) || a.numeric? ? {:align=>"right"} : nil} #{:align=>"left"}}
  cgi = CGI.new("html5")  # add HTML generation methods
  cgi.out do
    cgi.html do
      cgi.head do
        cgi.title { title } +
        cgi.style { %[table, th, td {
            border: 1px solid black;
          }
            table {
                  margin-left: 88px;
                  border-collapse: collapse;
                }
          ]
        } +
        cgi.script {'function reset_addr() {window.history.replaceState("string", "Title", "/");}'}
      end +
      cgi.body("style" => "color: rgb(0, 0, 0); background-color: rgb(255, 255, 255); background-image: url(/backgr_eg02.gif);", "alink" => "#00c6c9", "link" => "#0060ff", "vlink" => "#6e00ce" ) do
        "<h1>#{title}</h1><br/>" +
        cgi.script {'reset_addr();'} +
        Thamble.table(res, :headers => cols, :td => align_td)
      end
    end
  end
end

def thamble_skelet(db,title,sel)
  conn = OCI8.new(nil,nil,db)
  
  res = []
  cur = conn.parse(sel)
  cur.exec()
  cols = cur.get_col_names
  cur.fetch do |v|
    res << v.map{|i| i.class.to_s == "BigDecimal" ? "%d" % i : i}
  end
  cur.close
  conn.logoff
  create_html(cols, res, title)
  
end

def main()
  db = "AMOR"
  title = "Test title"
  sel = <<EOT
select * from COMP_FIN.fin_rabo_creditcard t order by t.datum desc
EOT
  thamble_skelet(db,title,sel)
end
###########
## Main
###########

main if __FILE__ == $0

