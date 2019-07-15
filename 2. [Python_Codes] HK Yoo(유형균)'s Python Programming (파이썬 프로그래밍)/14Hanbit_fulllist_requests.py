# 한빛미디어 스토어의 전체 도서 목록에서
# 도서제목을 requests 와 css 선택자를 이용해서 추출함


import requests
import lxml.html
import cssselect

url = 'http://www.hanbit.co.kr/store/books/full_book_list.html'

res = requests.get(url)
html = res.text

root = lxml.html.fromstring(html)

for part_html in root.cssselect('td.left a'):
    print(part_html.text_content())

# //*[@id="container"]/div[2]/div[4]/table/tbody/tr[1]/td[2]/a
for part_html in root.xpath('//td[2]/a'):
    print(part_html.text_content())

for part_html in root.xpath('//td[@class="left"]/a'):
    print(part_html.text_content())






