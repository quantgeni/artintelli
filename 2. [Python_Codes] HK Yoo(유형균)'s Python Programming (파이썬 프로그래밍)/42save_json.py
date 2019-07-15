# 수집한 데이터를 json 형태로 저장하기
# 서울/경기 날씨정보(시간/날씨/최소/최대온도)를
# 추출해서 json으로 저장

# JSON : javascript object notation
# 자바스크립트의 객체를 표현하는 방식을 이용해서
# 각종 프로그래밍 언어에서 데이터를 표현
# csv, xml로 데이터를 표현했던 것을 JSON으로 대체

# json은 파이썬의 dict 형식과 유사함
# [ {키:값}, {키:값}, {...} ]
# { 'userid':'abc123', 'passwd':'987xyz' }

from bs4 import BeautifulSoup
import requests
import json

headers = { 'User-Agent':'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.103 Safari/537.36' }

url = 'http://www.kma.go.kr/weather/forecast/mid-term-rss3.jsp?stnId=109'

res = requests.get(url, headers=headers)
rss = BeautifulSoup(res.text, 'lxml')

json_datas = []

for weather in rss.find_all('data'):
    tmef = weather.tmef.text 
    wf = weather.wf.text
    tmn = weather.tmn.text
    tmx = weather.tmx.text

    print(tmef, wf, tmn, tmx)

    json_datas.append( { 'tmEf':tmef, \
        'wf':wf, 'tmn':tmn, 'tmx':tmx } )

# 저장한 날씨 데이터를 json으로 저장함
with open('data/weather.json', 'w', 
    encoding='utf-8') as f:
    json.dump(json_datas, f, 
        ensure_ascii=False, indent=2)
