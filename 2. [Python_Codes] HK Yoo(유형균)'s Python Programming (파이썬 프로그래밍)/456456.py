from bs4 import BeautifulSoup
import requests
import csv

headers = { 'User-Agent':'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.103 Safari/537.36' }

url = 'https://media.daum.net/cp/310?regDate=20180427'

res = requests.get(url, headers=headers)
rss = BeautifulSoup(res.text, 'lxml')

# 수집한 데이터를 저장하기 위한 변수 정의
csv_datas = []

for daum in rss.find_all('data'):
    hdlines = daum.tmef.text
    descnews = daum.wf.text

    print(hdlines, descnews)

    csv_datas.append([hdlines, descnews])

# 저장한 날씨 데이터를 csv로 저장함
with open('data/jtbc20180427.csv', 'w', encoding='utf-8') as f:
    writer = csv.writer(f)
    writer.writerows(csv_datas)
