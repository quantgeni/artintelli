# nwes.daum.net 에서 JTBC 뉴스의 헤드라인, 간략뉴스를 추출해서
# jtbcnews 컬렉션에 저장
# 필드명 : news, desc


from bs4 import BeautifulSoup
import requests
from pymongo import MongoClient


url = 'https://media.daum.net/cp/310?regDate=20190502'

headers = {'User-Agent':'Mozilla/5.0 (Windows NT 10.0; Win64; x64) \
    AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.103 Safari/537.36'}


res = requests.get(url, headers=headers)
html = BeautifulSoup(res.text, 'lxml')


news = []
desc = []

# 뉴스 헤드라인
for item in html.select('strong.tit_thumb a'):
    news.append(item.text.strip())
news.pop(); news.pop()


# 간략 뉴스
for item in html.select('div.desc_thumb span'):
    desc.append(item.text.strip())

# print(news)
# print(desc)


######################################################################


client = MongoClient('mongodb://192.168.180.133:27017')

db = client.bigdata
coll = db.jtbcnews

coll.remove({})

for i in range(len(news)):
    newOne = { 'news': news[i], 'desc': desc[i] }
    coll.insert_one(newOne)


client.close()

