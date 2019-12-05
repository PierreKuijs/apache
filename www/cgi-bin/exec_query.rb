#!/usr/bin/env ruby
require 'cgi'
require './thamble_skelet.rb'

###########
## Main
###########

cgi = CGI.new("html5")  # add HTML generation methods
t = cgi.params
sel = t['sel'][0]
database = t['database'][0]
title = t['title'][0]
thamble_skelet(database,title,sel)

