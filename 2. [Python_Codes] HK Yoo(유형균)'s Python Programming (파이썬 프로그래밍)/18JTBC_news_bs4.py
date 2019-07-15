# daum.net => 뉴스 > 언론사별 뉴스 > JTBC
# 2019-04-16, 3page 의 뉴스제목, 간략뉴스 추출
# 덧붙여, 뉴스 페이지의 총 페이지 수 추출
# https://media.daum.net/cp/310?regDate=20190416
# https://media.daum.net/cp/310?regDate=%s&page=%s


from bs4 import BeautifulSoup
import requests

url = 'https://media.daum.net/cp/310'
headers = {'User-Agent':'Mozilla/5.0 (Windows NT 10.0; Win64; x64) \
    AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.103 Safari/537.36'}

params = { 'page' : '3', 'regDate' : '20190416'}

res = requests.get(url, headers=headers, params=params)
html = BeautifulSoup(res.text, 'lxml')

# hdlines = []
# descnews = []


# 뉴스 헤드라인
for part_html in html.select('strong.tit_thumb a.link_txt'):
    print(part_html.text.strip())


# 간략 뉴스
for part_html in html.select('span.link_txt'):
    print(part_html.text.strip())


# 총페이지수

for part_html in html.select('a.num_page:last-child'):
    print(part_html.text.strip())
