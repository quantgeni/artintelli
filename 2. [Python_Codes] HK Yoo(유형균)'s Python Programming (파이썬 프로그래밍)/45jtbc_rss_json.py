# JTBC 뉴스의 속보에 대한 RSS을 추출해서 
# json 형식으로 파일에 저장
# 대상 : 제목,링크,뉴스본문,배포일
# 파일명 : jtbc_rss_flash.json

from bs4 import BeautifulSoup
import requests
import json
from collections import OrderedDict

url = 'http://fs.jtbc.joins.com//RSS/newsflash.xml'
headers = { 'User-Agent':'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.103 Safari/537.36' }

res = requests.get(url, headers=headers)
res.encoding = 'utf-8'
rss = BeautifulSoup(res.text, 'lxml-xml')

newes = []

for news in rss.find_all('item'):
    newOne = OrderedDict()
    newOne['title'] = news.title.text
    newOne['link'] = news.link.text
    newOne['desc'] = news.description.text
    newOne['pdate'] = news.pubDate.text
    newes.append(newOne)

allnews = OrderedDict()
allnews['news'] = newes

with open('data/jtbc_rss_flash.json', 'w', encoding='utf-8') as f:
    json.dump(allnews, f, ensure_ascii=False, indent=2)

















