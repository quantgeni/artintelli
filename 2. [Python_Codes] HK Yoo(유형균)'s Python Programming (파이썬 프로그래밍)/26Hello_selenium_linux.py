# centos에 설치한 selenium 과 chrome driver 를 이용한 스크래핑 실습
# yes24.com > 신상품 > 도서제목,저자,가격 추출


from selenium import webdriver
from selenium.webdriver.chrome.options import Options

url = 'http://www.yes24.com/24/Category/NewProduct'

# headless 설정
options = Options()
options.add_argument('--headless')

# chrome driver 실행
chrome = webdriver.Chrome(options=options)

# 지정한 url로 접속
chrome.get(url)

# 응답으로 받은 페이지소스를 변수에 저장
res = chrome.page_source


# 브라우저 닫음
chrome.close()

# 신상도서 제목,저자,가격 추출
from bs4 import BeautifulSoup

html = BeautifulSoup(res, 'lxml')

for title in html.select('ul#topBooksUl_001 p.goods_name a'):
    print(title.text)

for author in html.select('ul#topBooksUl_001 span.goods_auth'):
    print(author.text)

for price in html.select('ul#topBooksUl_001 p.goods_price'):
    print(price.text)