# 포털사이트의 언론사별 뉴스를 스크래핑
# daum news > 뉴스 > 맨 아래 언론사별 뉴스
#                  > TV, 동영상 JTBC
#                  > 최신뉴스 > 모든페이지
# => 뉴스제목, 간략뉴스 추출

# 웹 문서 저장시 파일명 : 10jtbc_news.html


from urllib.request import urlopen
import re

urlfmt = 'https://media.daum.net/cp/310?regDate=%s&page=%s'

regdate = input('검색할 뉴스날짜는? : ')    # 20190401

url = urlfmt % (regdate, '1')

docs = urlopen(url)
encode = docs.info().get_content_charset()
text = docs.read().decode(encode)

with open('data/10jtbc_news.html', 'w', encoding='utf-8') as out:
    out.write(text)


with open('data/10jtbc_news.html', 'r', encoding='utf-8') as f:
    html = f.read()



# 검색할 뉴스의 총페이지 알아내기

css1 = r'<span class=" screen_out">.*?<a.*?</span>'

pages = ''
for part_html in re.findall(css1, html, re.DOTALL):
    page = re.sub(r'현재 페이지', '', part_html)
    page = re.sub(r'<.*?>', '', page)
    page = re.sub(r'\s{2,}', '\n', page)
    pages = page.strip()

pages = int(pages.split('\n')[-1])


# 각 페이지별 뉴스제목과 간략뉴스 추출
css2 = r'<strong class="tit_thumb">.*?</a>'
css3 = r'<span class="link_txt">.*?</span>'

hdlines = []
descnews = []


for i in range(2, pages+2):
    for part_html in re.findall(css2, html, re.DOTALL):
        hdline = re.sub('<.*?>', '', part_html)
        hdlines.append(hdline)

    # 뉴스제목 저장 중 추천연재의 뉴스제목 2개는 제외함
    hdlines.pop()
    hdlines.pop()


    for part_html in re.findall(css3, html, re.DOTALL):
        descnew = re.sub('<.*?>', '', part_html)
        descnews.append(descnew)


    # 새로운 뉴스 페이지 불러오기
    url = urlfmt % (regdate, i)

    docs = urlopen(url)
    encode = docs.info().get_content_charset()
    text = docs.read().decode(encode)

    with open('data/10jtbc_news.html', 'w', encoding='utf-8') as out:
        out.write(text)

    with open('data/10jtbc_news.html', 'r', encoding='utf-8') as f:
        html = f.read()

# 제목과 간략뉴스 출력
# print(hdlines)
# print(descnews)

for i in range(len(hdlines)):
    print('%s\n%s\n' % (hdlines[i].strip(), descnews[i].strip()))


