# ex) 포탈사이트의 메인 뉴스를 스크래핑
# daum.net > news > 언론사별 뉴스 헤드라인 추출
#                 > 댓글이 많은 뉴스 헤드라인 추출
#                 > 연령별 인기 뉴스 헤드라인 추출
# 웹 문서 저장시 파일명은 07daum_news.html
# https://media.daum.net/


from urllib.request import urlopen
import re

url = 'https://media.daum.net/'
docs = urlopen(url)

encode = docs.info().get_content_charset()
text = docs.read().decode(encode)


with open('data/07daum_news.html', 'w', encoding = 'utf-8') as out:
    out.write(text)


with open('data/07daum_news.html', 'r', encoding='utf-8') as f:
    html = f.read()

css1 = r'<ul class="list_view">.*?</ul>'
# re.findall(css1, html, re.DOTALL)
css2 = r'<ul class="list_headline">.*?</ul>'
css3 = r'<ol class="list_popcmt">.*?</ol>'
css4 = r'<ul class="list_agenews list_female">.*?</ul>'
css5 = r'<ul class="list_agenews list_male">.*?</ul>'


for part_html in re.findall(css1, html, re.DOTALL):
    hdline = re.sub(r'<span.*?</span>', '', part_html)
    hdline = re.sub(r'<.*?>', '', hdline)
    hdline = re.sub(r'\s{2,}', '\n', hdline)
    print(hdline.strip())


for part_html in re.findall(css2, html, re.DOTALL):
    hdline = re.sub(r'<span.*?</span>', '', part_html)
    hdline = re.sub(r'<.*?>', '', hdline)
    hdline = re.sub(r'\s{2,}', '\n', hdline)
    print(hdline.strip())


for part_html in re.findall(css3, html, re.DOTALL):
    hdline = re.sub(r'<span.*?</span>', '', part_html)
    hdline = re.sub(r'<!--!-->|0|댓글', '', hdline)
    hdline = re.sub(r'<.*?>', '', hdline)
    hdline = re.sub(r'\s{2,}', '\n', hdline)
    print(hdline.strip())


for part_html in re.findall(css4, html, re.DOTALL):
    hdline = re.sub(r'<span.*?</span>', '', part_html)
    hdline = re.sub(r'<.*?>', '', hdline)
    hdline = re.sub(r'\s{2,}', '\n', hdline)
    print(hdline.strip())


for part_html in re.findall(css5, html, re.DOTALL):
    hdline = re.sub(r'<.*?>', '', part_html)
    hdline = re.sub(r'\s{2,}', '\n', hdline)
    print(hdline.strip())


