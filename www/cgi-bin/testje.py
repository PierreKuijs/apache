#!/usr/bin/env python3
import cgitb
import cx_Oracle
import HTML
import os
import re

def main():
  cgitb.enable()
  print("Content-type: text/html\n")
  print("<html>")
  print("<body>")
  print("  <h1>Dit is een cgi met python3</h1>")
  print('Oke met Python3')
  print("</body>")
  print("</html>")


if __name__ == '__main__':
  main()
