# 포털사이트에서 검색어를 입력하고 출력된 결과 중 검색제목과 링크 추출

from bs4 import BeautifulSoup
import requests

url = 'https://search.naver.com/search.naver'
headers = {'User-Agent':'Mozilla/5.0 (Windows NT 10.0; Win64; x64) \
    AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.103 Safari/537.36'}
param = { 'query': 'html5' }
# 네이버에서 검색어를 입력할 때 사용하는 url은 search.naver.com/search.naver?query= 임

res = requests.get(url, headers=headers, params=param)
html = BeautifulSoup(res.text, 'lxml')



# 지식백과

for part_html in html.select('div.tit_box a'):
    print(part_html.text, part_html.get('href'))


for part_html in html.select('p.txt_box'):
    print(part_html.text)



# 카페

for part_html in html.select('li.sh_cafe_top dl dt a'):
    print(part_html.text, part_html.get('href'))


for part_html in html.select('dd.sh_cafe_passage'):
    print(part_html.text)



# 포스트

for part_html in html.select('div.sp_post ul.type01 li dl dt a'):
    print(part_html.text, part_html.get('href'))


for part_html in html.select('div.sp_post ul.type01 li dl dd:nth-child(3)'):
    print(part_html.text)


# 웹사이트

for part_html in html.select('div.sp_website dl dt a'):
    print(part_html.text, part_html.get('href'))


for part_html in html.select('div.sp_website dd.sh_web_passage'):
    print(part_html.text)


# 네이버 책

for part_html in html.select('div.book_list dl dt a'):
    print(part_html.text, part_html.get('href'))


for part_html in html.select('div.book_list dl dd:nth-child(5)'):
    print(part_html.text)









