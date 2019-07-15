# ex) 온라인 도서 쇼핑몰의 도서 정보를 스크래핑

# hanbit.co.kr > store > bestseller > 전체도서목록 > 도서의 제목, 저자, 정가 추출
# 웹 문서 저장시 파일명은 03fulllist.html
# http://www.hanbit.co.kr/store/books/full_book_list.html


from urllib.request import urlopen
import re

url = 'http://www.hanbit.co.kr/store/books/full_book_list.html'
docs = urlopen(url)

encode = docs.info().get_content_charset()
text = docs.read().decode(encode)


with open('data/03fulllist.html', 'w', encoding='utf-8') as out:
    out.write(text)

# print(text)


with open('data/03fulllist.html', 'r', encoding='utf-8') as f:
    html = f.read()

# print(html)

css1 = r'<td class="left"><a.*?</td>'
css2 = r'<td class="left">[^<>].*?</td>'
css3 = r'<td class="right">[^<>].*?</td>'

titles = []
writers = []
prices = []

for part_html in re.findall(css1, html, re.DOTALL):
    title = re.sub('<.*?>', '', part_html)
    title = re.sub('&#40;', '(', title)
    title = re.sub('&#41;', ')', title)
    # print(title)
    titles.append(title)


for part_html in re.findall(css2, html, re.DOTALL):
    writer = re.sub('<.*?>', '', part_html)
    # print(writer)
    writers.append(writer)


for part_html in re.findall(css3, html, re.DOTALL):
    price = re.sub('<.*?>', '', part_html)
    # print(price)
    prices.append(price)


for i in range(len(titles)):
    print(titles[i], writers[i], prices[i])




# 수집한 내용을 csv 파일로 저장

with open('data/03fulllist.csv', 'w', encoding='utf-8') as out:
    fmt = '%s,%s,%s\n'
    for i in range(len(titles)):
        out.write(fmt % (titles[i], writers[i].strip(), prices[i]))


