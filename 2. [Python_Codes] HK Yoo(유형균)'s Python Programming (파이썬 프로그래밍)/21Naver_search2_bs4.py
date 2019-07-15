# 포털사이트에서 검색어를 입력하고 출력된 결과 중 검색제목과 링크 추출
# 검색어를 '빅데이터'로 지정
# 검색결과 중 지식백과의 제목과 링크 추출

from bs4 import BeautifulSoup
import requests

url = 'https://search.naver.com/search.naver'
headers = {'User-Agent':'Mozilla/5.0 (Windows NT 10.0; Win64; x64) \
    AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.103 Safari/537.36'}
param = { 'query': '빅데이터' }

res = requests.get(url, headers=headers, params=param)
html = BeautifulSoup(res.text, 'lxml')


# 지식백과

for part_html in html.select('div.tit_box a'):
    print(part_html.text, part_html.get('href'))


