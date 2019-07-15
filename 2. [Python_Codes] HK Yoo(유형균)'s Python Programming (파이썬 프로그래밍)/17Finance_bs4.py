# 네이버 증권 : 환전고시환율, 국제시장환율
# 다음 증권 : 오늘의 증시, 환율조회

from bs4 import BeautifulSoup
import requests

url = 'http://finance.daum.net/'
headers = {'User-Agent':'Mozilla/5.0 (Windows NT 10.0; Win64; x64) \
    AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.103 Safari/537.36'}

res = requests.get(url, headers=headers)

html = BeautifulSoup(res.text, 'lxml')

for part_html in html.select('div.stock'):
    print(part_html.text.strip())
# => 내용이 보이지 않음



url = 'http://finance.daum.net/exchanges'
headers = {'User-Agent':'Mozilla/5.0 (Windows NT 10.0; Win64; x64) \
    AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.103 Safari/537.36'}

res = requests.get(url, headers=headers)

html = BeautifulSoup(res.text, 'lxml')

for part_html in html.select('div.tableB'):
    print(part_html.text.strip())
# => 내용이 보이지 않음






# 네이버

from bs4 import BeautifulSoup
import requests


url = 'https://finance.naver.com/'
headers = {'User-Agent':'Mozilla/5.0 (Windows NT 10.0; Win64; x64) \
    AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.103 Safari/537.36'}

res = requests.get(url, headers=headers)

html = BeautifulSoup(res.text, 'lxml')

# for part_html in html.select('div.section1 > div.group1 > table > tbody > tr > th'):
#     print(part_html.text.strip())
#
# for part_html in html.select('div.section1 > div.group1 > table > tbody > tr > td:nth-child(2)'):
#     print(part_html.text.strip())
#
# for part_html in html.select('div.section1 > div.group1 > table > tbody > tr > td:nth-child(3)'):
#     print(part_html.text.strip())

exchange1 = []
for part_html in html.select('div.section1 > div.group1 > table > tbody > tr'):
    # print(part_html.text.strip())
    exchange1.append(part_html.text.strip())

for i in range(len(exchange1)):
    print(exchange1[i].replace('\n',', '))



exchange2 = []
for part_html in html.select('div.section1 > div.group2 > table > tbody > tr'):
    # print(part_html.text.strip())
    exchange2.append(part_html.text.strip())

for i in range(len(exchange2)):
    print(exchange2[i].replace('\n', ', '))





