# yes24 베스트셀러 도서제목, 저자, 가격 추출
# 교보문고 베스트셀러 도서제목, 저자, 가격 추출

from bs4 import BeautifulSoup
import requests

url = 'http://www.yes24.com/24/category/bestseller'
headers = {'User-Agent':'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.103 Safari/537.36'}

res = requests.get(url, headers=headers)

html = BeautifulSoup(res.text, 'lxml')


# 도서제목   ol > li > p:nth-child(3) > a
for part_html in html.select('ol > li > p:nth-child(3) > a'):
    print(part_html.text.strip())
# bestList > ol > li.num1 > p:nth-child(3) > a

# 도서저자  ol > li > p.aupu
for part_html in html.select('p.aupu'):
    print(part_html.text.split('|')[0].strip())
# bestList > ol > li.num1 > p.aupu > a:nth-child(1)

# 도서가격  ol > li.num1 > p.price > strong
for part_html in html.select('p.price > strong'):
    print(part_html.text.strip())
# bestList > ol > li.num1 > p.price > strong




# 교보문고

url = 'http://www.kyobobook.co.kr/bestSellerNew/bestseller.laf?orderClick=d79'
headers = {'User-Agent':'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.103 Safari/537.36'}

res = requests.get(url, headers=headers)

html = BeautifulSoup(res.text, 'lxml')



# 도서제목
for part_html in html.select('div.title > a > strong'):
    print(part_html.text.strip())

# 도서저자
import re
for part_html in html.select('div.author'):
    # print(part_html.text.strip())
    title = part_html.text.split('|')[0]
    print(title.strip())

# 도서가격
for part_html in html.select('strong.book_price'):
    print(part_html.text.strip())





