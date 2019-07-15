# ex) 온라인 도서 쇼핑몰의 도서 정보를 스크래핑

# yes24.co.kr > 베스트 > 도서의 제목, 저자, 정가 추출
# 웹 문서 저장시 파일명은 04yes24_best.html
# http://www.yes24.com/24/category/bestseller


from urllib.request import urlopen
import re

url = 'http://www.yes24.com/24/category/bestseller'
docs = urlopen(url)

encode = docs.info().get_content_charset()
text = docs.read().decode(encode)


with open('data/04yes24_best.html', 'w', encoding='utf-8') as out:
    out.write(text)

# print(text)


with open('data/04yes24_best.html', 'r', encoding='utf-8') as f:
    html = f.read()

print(html)

css1 = r'\[도서.*?</a>'
css2 = r'<p class="aupu"><a.*?\|'
css3 = r'<p class="price">.*?</strong>'
# re.findall((css3, html, re.DOTALL))


titles = []
writers = []
prices = []

for part_html in re.findall(css1, html, re.DOTALL):
    title = re.sub(r'<.*?>', '', part_html)
    title = re.sub(r'\[도서\]', '', title)
    # print(title.strip())
    titles.append(title.strip())


for part_html in re.findall(css2, html, re.DOTALL):
    writer = re.sub(r'<.*?>', '', part_html)
    writer = re.sub(r'\|', '', writer)
    # print(writer.strip())
    # print(writer)
    writers.append(writer.strip())


for part_html in re.findall(css3, html, re.DOTALL):
    price = re.sub(r'<.*?>', '', part_html)
    price = re.sub(r'\,', '', price)

    # print(price.strip())
    prices.append(price.strip())


# for i in range(len(titles)):
#     print(titles[i], writers[i], prices[i])


# 수집한 내용을 csv 파일로 저장

with open('data/04yes24_best.csv', 'w', encoding='utf-8') as out:
    fmt = '%s, "%s", %s\n'
    for i in range(len(titles)):
        out.write(fmt % (titles[i], writers[i].strip(), prices[i]))



