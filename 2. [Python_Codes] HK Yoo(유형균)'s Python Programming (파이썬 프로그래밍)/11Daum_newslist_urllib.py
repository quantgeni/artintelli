# 포털사이트의 언론사별 뉴스를 스크래핑
# daum news > 뉴스 > 맨 아래 언론사별 뉴스
#                  > TV, 동영상 JTBC
#                  > 최신뉴스 > 모든페이지
# => 뉴스제목, 간략뉴스 추출

# 웹 문서 저장시 파일명 : 10jtbc_news.html

from urllib.request import urlopen
import re

url = 'https://media.daum.net/cp/310'

docs = urlopen(url)
encode = docs.info().get_content_charset()
text = docs.read().decode(encode)


with open('data/10jtbc_news.html', 'w', encoding='utf-8') as out:
    out.write(text)

with open('data/10jtbc_news.html', 'r', encoding='utf-8') as f:
    html = f.read()


css1 = r'<strong class="tit_thumb">.*?</a>'
css2 = r'<span class="link_txt">.*?</span>'

hdlines = []
descnews = []


for part_html in re.findall(css1, html, re.DOTALL):
    hdline = re.sub('<.*?>', '', part_html)
    # print(hdlines.strip())
    hdlines.append(hdline.strip())



for part_html in re.findall(css2, html, re.DOTALL):
    descnew = re.sub('<.*?>', '', part_html)
    # print(descnews.strip())
    descnews.append(descnew.strip())


for i in range(len(hdlines)-2):
    print('%s\n%s\n' % (hdlines[i], descnews[i]))


# print(len(hdlines), len(descnews))


# 현재 뉴스기사 페이지의 마지막 페이지 알아내기

css3 = r'<span class=" screen_out">.*?<a.*?</span>'

pagenum = 0

for part_html in re.findall(css3, html, re.DOTALL):
    page = re.sub(r'현재 페이지', '', part_html)
    page = re.sub(r'<.*?>', '', page)
    page = re.sub(r'\s{2,}','\n', page)
    pagenum = page.strip()

print(pagenum.split('\n')[-1])











