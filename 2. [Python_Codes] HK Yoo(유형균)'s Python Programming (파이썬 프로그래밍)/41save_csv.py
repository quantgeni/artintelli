# 수집한 데이터를 csv 형태로 저장하기
# 서울/경기 날씨정보(시간/날씨/최소/최대온도)를
# 추출해서 csv로 저장

from bs4 import BeautifulSoup
import requests
import csv

headers = { 'User-Agent':'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.103 Safari/537.36' }

url = 'http://www.kma.go.kr/weather/forecast/mid-term-rss3.jsp?stnId=109'

res = requests.get(url, headers=headers)
rss = BeautifulSoup(res.text, 'lxml')

# 수집한 데이터를 저장하기 위한 변수 정의
csv_datas = []

for weather in rss.find_all('data'):
    tmef = weather.tmef.text 
    wf = weather.wf.text
    tmn = weather.tmn.text
    tmx = weather.tmx.text

    print(tmef, wf, tmn, tmx)

    csv_datas.append([tmef, wf, tmn, tmx])

# 저장한 날씨 데이터를 csv로 저장함
with open('data/weather.csv', 'w', encoding='utf-8') as f:
    writer = csv.writer(f)
    writer.writerows(csv_datas)


