# 한빛 미디어 전체 도서 목록을 추출해서
# json 형식으로 파일에 저장
# 대상 : 브랜드,도서명,저자,발행일,정가
# 파일명 : hanbit_fulllist.json

import requests
from bs4 import BeautifulSoup
import json
from collections import OrderedDict

url = 'http://www.hanbit.co.kr/store/books/full_book_list.html'
headers = { 'User-Agent':'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.103 Safari/537.36' }

res = requests.get(url, headers=headers)
html = BeautifulSoup(res.text, 'lxml')

# 추출한 도서정보를 저장하기 위해 변수 선언
brand = []
bkname = []
writer = []
pdate = []
price = []


# 도서정보 추출
for book in html.select('table tbody tr'):
    for td in book.select('td:nth-child(1)'):
        brand.append(td.text)
    for td in book.select('td:nth-child(2)'):
        bkname.append(td.text)
    for td in book.select('td:nth-child(3)'):
        writer.append(td.text)
    for td in book.select('td:nth-child(4)'):
        pdate.append(td.text)
    for td in book.select('td:nth-child(5)'):
        price.append(td.text)


# json 파일 생성
books = []
cnt = len(html.select('table tbody tr'))

for i in range(0, cnt):
    book = OrderedDict()
    book['brand'] = brand[i]
    book['bkname'] = bkname[i]
    book['writer'] = writer[i]
    book['pdate'] = pdate[i]
    book['price'] = price[i]
    books.append(book)

# [ {},{},{}, .... ] 이런 형태로 저장됨
# [] : books
# {} : 각 요소들

allbook = OrderedDict()
allbook['books'] = books


# 생성된 json 객체를 파일에 저장
with open('data/hanbit_fulllist.json', 'w', encoding='utf-8') as f:
    json.dump(allbook, f, ensure_ascii=False, indent=2)





#################################################################






# 좀 더 세련되게 코드 작성

import requests
from bs4 import BeautifulSoup
import json
from collections import OrderedDict

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

# 추출된 도서정보로 json 생성
for i in range(0, cnt):
    book = OrderedDict()
    book['brand'] = bookinfo[i*5]       # 0 5 10
    book['bkname'] = bookinfo[i*5+1]    # 1 6 11
    book['writer'] = bookinfo[i*5+2]    # 2 7 12
    book['pdate'] = bookinfo[i*5+3]     # 3 8 13
    book['price'] = bookinfo[i*5+4]     # 4 9 14
    books.append(book)

allbook = OrderedDict()
allbook['books'] = books

# 생성된 json 객체를 파일에 저장
with open('data/hanbit_fulllist2.json', 'w', encoding='utf-8') as f:
    json.dump(allbook, f, ensure_ascii=False, indent=2)


