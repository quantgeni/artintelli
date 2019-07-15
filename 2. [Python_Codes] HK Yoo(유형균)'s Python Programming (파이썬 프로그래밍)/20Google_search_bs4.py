# google.com에서 HTML5라는 검색어를 입력하고 출력된 결과 중 검색제목과 링크 추출
# 구글에서 검색어를 입력할 때 사용하는 url은
# https://www.google.com/search?q=html5

from bs4 import BeautifulSoup
import requests

url = 'https://www.google.com/search'
headers = {'User-Agent':'Mozilla/5.0 (Windows NT 10.0; Win64; x64) \
    AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.103 Safari/537.36'}
params = { 'q': 'html5' }

res = requests.get(url, headers=headers, params=params)
html = BeautifulSoup(res.text, 'lxml')

for part_html in html.select('h3.LC20lb'):
    print(part_html.text)

for part_html in html.select('cite.iUh30'):
    print(part_html.text)
