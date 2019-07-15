from bs4 import BeautifulSoup
import requests
import json

headers = { 'User-Agent':'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.103 Safari/537.36' }

url = 'http://www.kyobobook.co.kr/bestSellerNew/bestseller.laf?orderClick=d79'

res = requests.get(url, headers=headers)
rss = BeautifulSoup(res.text, 'lxml')

json_datas = []

for kyobo in rss.find_all('title'):
    bkname = kyobo.bkname.text
    writer = kyobo.writer.text
    price = kyobo.price.text

    print(bkname, writer, price)

    json_datas.append( { 'bkname':bkname, 'writer':writer, 'price':price } )

with open('data/kyobobest.json', 'w', encoding='utf-8') as f:
    json.dump(json_datas, f, ensure_ascii=False, indent=2)
