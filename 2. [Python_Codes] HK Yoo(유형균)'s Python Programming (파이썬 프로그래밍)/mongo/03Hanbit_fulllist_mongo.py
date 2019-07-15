# hanbit 도서사이트
# http://www.hanbit.co.kr/ > store > 전체도서목록
# 브랜드, 도서명, 저자, 발행일, 정가 등을 추출해서
# hanbitbook 이라는 컬렉션에 저장
# 필드명 : brand, bkname, writer, pdate, price


from bs4 import BeautifulSoup
import requests
from pymongo import MongoClient


url = 'http://www.hanbit.co.kr/store/books/full_book_list.html'

headers = {'User-Agent':'Mozilla/5.0 (Windows NT 10.0; Win64; x64) \
    AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.103 Safari/537.36'}

res = requests.get(url, headers=headers)
html = BeautifulSoup(res.text, 'lxml')

books = []
for book in html.select('div.table_area tbody tr td'):
    books.append(book.text)
# print(books)

cnt = len(html.select('div.table_area tbody tr'))

########################################################################

client = MongoClient('mongodb://192.168.180.133:27017')

db = client.bigdata
coll = db.hanbitbook

# 문서 저장전 기본문서를 모두 제거
coll.remove({})

for i in range(cnt):
    book = { 'brand' : books[5*i + 0],
             'bkname': books[5*i + 1],
             'writer': books[5*i + 2],
             'pdate' : books[5*i + 3],
             'price' : books[5*i + 4] }
    coll.insert_one(book)


client.close()








