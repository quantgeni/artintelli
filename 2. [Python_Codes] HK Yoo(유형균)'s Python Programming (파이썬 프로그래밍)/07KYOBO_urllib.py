# ex) 온라인 도서 쇼핑몰의 도서 정보를 스크래핑

# kyobobook.co.kr > 베스트 > 도서의 제목, 저자, 정가 추출
# 웹 문서 저장시 파일명은 05kyobo_best.html
# http://www.kyobobook.co.kr/bestSellerNew/bestseller.laf?orderClick=d79

from urllib.request import urlopen
import re

url = 'http://www.kyobobook.co.kr/bestSellerNew/bestseller.laf?orderClick=d79'
docs = urlopen(url)

encode = docs.info().get_content_charset()
text = docs.read().decode(encode)

with open('data/05kyobo_best.html', 'w', encoding = encode) as out:
    out.write(text)
# 일반적으로 웹페이지의 인코딩은 utf-8로 지정
# 간혹 오래전에 만든 몇몇 사이트들은 euc-kr 방식으로 인코딩을 사용하고 있음
# 이럴때는 euc-kr 인코딩을 이용해서 파일을 저장하고 파일을 열어야 함


with open('data/05kyobo_best.html', 'r', encoding='euc-kr') as f:
    html = f.read()

# print(html)

css1 = r'<div class="title">\s+<a.*?</strong>'
css2 = r'<div class="author">\s+.*?<span'
css3 = r'<div class="price">\s+.*?</strong>'
re.findall(css3, html, re.DOTALL)


titles = []
writers = []
prices = []

for part_html in re.findall(css1, html, re.DOTALL):
    title = re.sub(r'<.*?>', '', part_html)
    print(title.strip())
    titles.append(title.strip())


for part_html in re.findall(css2, html, re.DOTALL):
    writer = re.sub(r'<.*?>', '', part_html)
    writer = re.sub(r'<span', '', writer)
    print(writer.strip())
    writers.append(writer.strip())


for part_html in re.findall(css3, html, re.DOTALL):
    price = re.sub(r'<.*?>', '', part_html)
    price = re.sub(r'도서', '', price)
    price = re.sub(r',', '', price)
    print(price.strip())
    prices.append(price.strip())


# 수집한 내용을 csv 파일로 저장
with open('data/05kyobo_best.csv', 'w', encoding='utf-8') as out:
    fmt = '%s,%s,%s\n'
    for i in range(len(titles)):
        out.write(fmt % (titles[i], writers[i].strip(), prices[i]))