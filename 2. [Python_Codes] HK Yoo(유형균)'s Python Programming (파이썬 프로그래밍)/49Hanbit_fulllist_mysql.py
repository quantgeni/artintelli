# 한빛 미디어 전체 도서목록을 추출해서
# mysql 데이터베이스에 저장
# 대상 : 브랜드, 도서명, 저자, 발행일, 정가
# 테이블명 : hanbit_book

import requests
from bs4 import BeautifulSoup
import pymysql

# create table hanbit_book (
#   brand   varchar,
#   bkname  varchar,
#   writer  varchar,
#   pdate   varchar,
#   price   varchar
# )


url = 'http://www.hanbit.co.kr/store/books/full_book_list.html'
headers = { 'User-Agent':'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.103 Safari/537.36' }

res = requests.get(url, headers=headers)
html = BeautifulSoup(res.text, 'lxml')


# 추출한 도서정보를 저장하기 위해 변수 선언
bookinfo = []

for book in html.select('table tbody tr td'):
    bookinfo.append(book.text)


books = []
cnt = len(html.select('table tbody tr'))



sql = 'insert into weathers values (%s, %s, %s, %s)'
conn = pymysql.connect(host='52.79.242.106', user='bigdata', password='bigdata0220', db ='bigdata', charset = 'utf8')

cursor = conn.cursor()

cnt = int(len(wts)/4)
for i in range(0, cnt):
    cursor.execute(sql, (wts[i*4],wts[i*4+1],wts[i*4+2],wts[i*4+3]))


conn.commit()
conn.close()













