#!/Users/jaredmartin/Virtualenvs/2711/bin/python

import sys
from lxml import etree
import csv

position = sys.argv[1]

root = etree.parse(sys.stdin, etree.HTMLParser())

trs = list()
trs.extend(root.findall(".//tr[@class='row1']"))
trs.extend(root.findall(".//tr[@class='row2']"))

writer = csv.writer(sys.stdout, quoting=csv.QUOTE_MINIMAL, delimiter=',')

for tr in trs:
    tds = tr.findall('./td')
    writer.writerow((
        position,
        tds[0].find('./a').attrib['href'].split('/')[4],
        tds[0].find('./a').text,
        tds[1].text,
        tds[2].text,
        tds[3].text,
        tds[4].text,
        tds[5].text,
        tds[6].text,
        tds[7].text,
        tds[8].text,
        tds[9].text,
        tds[10].text,
        tds[11].text,
        tds[12].text,
        tds[13].text,
        tds[14].text,
        tds[15].text,
        tds[16].text,))
