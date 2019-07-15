# BeautifulSoup
# https://www.crummy.com/software/BeautifulSoup/
# 유명한 스크래핑 크롤링 패키지
# 주로 html 과 xml 파일에서 데이터 추출 시 사용

# pip install beautifulsoup

from bs4 import BeautifulSoup
import requests

url = 'http://www.hanbit.co.kr/store/store_submain.html'
headers = {'User-Agent':'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.103 Safari/537.36'}
# 브라우저처럼 보이기 위해 가짜 요청헤더를 생성
res = requests.get(url, headers=headers)

# html = BeautifulSoup(res.text, 'html.parser')
html = BeautifulSoup(res.text, 'lxml')

# requests 패키지를 통해 응답받은 html 소스를
# BeautifulSoup패키지의 html.parser를 DOM 계층구조로 변환

# print(html)
print(html.prettify())      # 들여쓰기 적용


print(html.title.string)
# 스크래핑한 문서에서 title 요소의 문자열 출력

print(html.p)
# 스크래핑한 문서에서 p 요소 출력

print(html.p['class'])
# 스크래핑한 문서에서 p 요소의 class 속성 출력

print(html.find_all('p'))
# 스크래핑한 문서에서 모든 p요소 추출

print(html.find_all('a'))
# 스크래핑한 문서에서 모든 a요소 추출

for part_html in html.select('p.book_tit a'):
    print(part_html.text.strip())
# 스크래핑한 문서에서 도서 제목 추출

