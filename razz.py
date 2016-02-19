#!/Users/jaredmartin/Virtualenvs/2711/bin/python

import sys
from lxml import etree
import csv

def none_or_utf8(obj):
    return None if obj is None else obj.encode('utf-8')

root = etree.parse(sys.stdin, etree.HTMLParser())

trs = root.findall(".//table[@id='neorazzstatstable']/tbody/tr")

writer = csv.writer(sys.stdout, quoting=csv.QUOTE_MINIMAL, delimiter=',')

for tr in trs:
    tds = tr.findall('./td')
    writer.writerow((
        tds[1].find('./a').attrib['href'].split('/')[2],
        none_or_utf8(tds[1].find('./a').text),
        tds[2].find('./a').text,
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
        tds[16].text,
        tds[17].text,
        tds[18].text,
        tds[19].text,
        tds[20].text,
        tds[21].text,
        tds[22].text,
        tds[23].text,
        tds[24].text,
        tds[25].text,
        tds[26].text,
        tds[27].text,))
