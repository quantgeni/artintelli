# selenium 으로 스크래핑 하기

# 웹 브라우저를 이용한 작업들을 자동화 할 수 있도록 특수제작된 브라우저
# seleniumhq.org

# requests, bs4 로 스크래핑 할 수 없는 동적 데이터를 포함하는 웹 페이지를
# 원격 조작이 가능한 웹브라우저를 이용해서 처리

# https://chromedriver.storage.googleapis.com/index.html?path=73.0.3683.68/  > selenium 다운
# chromedriver_win32.zip => chromedriver.exe
# C:\Program Files (x86)\Google\Chrome\Application

# pip install selenium => selenium-3.141.0 (2019-04-17)

# http://www.hanbit.co.kr/ => store > 전체도서목록
#                                   > 도서제목, 저자, 가격 추출


from selenium import webdriver
from bs4 import BeautifulSoup

url = 'http://www.hanbit.co.kr/store/books/full_book_list.html'

# chrome driver 실행

chrome = webdriver.Chrome(executable_path=r'C:\Program Files (x86)\Google\Chrome\Application\chromedriver.exe')

# 지정한 url 로 접속
chrome.get(url)

# 응답으로 받은 웹페이지소스 출력
print(chrome.page_source)
res = chrome.page_source

# 작업종료를 위해 브라우저 닫음
chrome.close()


# 도서제목, 저자, 가격 추출
html = BeautifulSoup(res, 'lxml')

for title in html.select('td.left a'):
    print(title.text)

for writer in html.select('td:nth-child(3).left'):
    print(writer.text)

for price in html.select('td:nth-child(5).right'):
    print(price.text)




