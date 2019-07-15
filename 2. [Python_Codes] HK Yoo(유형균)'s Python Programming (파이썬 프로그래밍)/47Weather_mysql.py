# 기상청 날씨 데이터 수집하기
# 수집한 데이터를 mysql 데이터베이스의
# tmef(시간), wf(날씨), tmn(최소온도), tmx(최대온도)
# weathers 테이블에 저장함

# create table weathers (
#   tmef    varchar(20),
#   wf      varchar(20),
#   tmn     varchar(5),
#   tmx     varchar(5)
# )

# weathers 테이블에 날씨정보를 저장하는 sql
# insert into weathers
# values ('','','','')

from bs4 import BeautifulSoup
import requests
import pymysql


# 중기예보 - 서울/경기
url = 'http://www.kma.go.kr/weather/forecast/mid-term-rss3.jsp?stnId=109'
headers = { 'User-Agent':'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.103 Safari/537.36' }

res = requests.get(url, headers=headers)
rss = BeautifulSoup(res.text, 'lxml')

wts = []

# for w in rss.find_all('data'):
#     print(w.tmef.text)
#     print(w.wf.text)
#     print(w.tmn.text)
#     print(w.tmx.text)

for w in rss.find_all('data'):
    wts.append(w.tmef.text)
    wts.append(w.wf.text)
    wts.append(w.tmn.text)
    wts.append(w.tmx.text)



# mysql 에 날씨 정보 저장하기
sql = 'insert into weathers values (%s, %s, %s, %s)'
conn = pymysql.connect(host='52.79.242.106', user='bigdata', password='bigdata0220', db ='bigdata', charset = 'utf8')

cursor = conn.cursor()

cnt = int(len(wts)/4)
for i in range(0, cnt):
    cursor.execute(sql, (wts[i*4],wts[i*4+1],wts[i*4+2],wts[i*4+3]))

conn.commit()
conn.close()
















