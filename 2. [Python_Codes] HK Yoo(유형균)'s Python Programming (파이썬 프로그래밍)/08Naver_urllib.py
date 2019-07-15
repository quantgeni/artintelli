# ex) 포탈사이트의 메인 뉴스를 스크래핑
# naver.com > news > 각 분야별 헤드라인 추출
# 웹 문서 저장시 파일명은 06naver_news.html
# https://news.naver.com/


from urllib.request import urlopen
import re

url = 'https://news.naver.com/'

docs = urlopen(url)
encode = docs.info().get_content_charset()
text = docs.read().decode(encode)

with open('data/06naver_news.html', 'w', encoding = 'utf-8') as out:
    out.write(text)


with open('data/06naver_news.html', 'r', encoding='utf-8') as f:
    html = f.read()

# print(html)

css1 = r'<div class="hdline_article_tit"><a.*?</a>'
# css2 = r'<strong>[^<>].*?</strong>'
css2 = r'<ul class="mlist2 no_bg">.*?</ul>'

re.findall(css2, html, re.DOTALL)



for part_html in re.findall(css1, html, re.DOTALL):
    hdline = re.sub(r'<.*?>', '', part_html)
    hdline = re.sub(r'&hellip;', '…', hdline)
    hdline = re.sub(r'&quot;', '', hdline)
    hdline = re.sub(r'&rdquo;', '', hdline)
    hdline = re.sub(r'&ldquo;', '', hdline)
    hdline = re.sub(r'&middot;', '', hdline)
    hdline = re.sub(r'<.*?>;', '', hdline)

    # print(hdline.strip())


for part_html in re.findall(css2, html, re.DOTALL):
    hdline = re.sub(r'<i.*?</i>', '', part_html)
    hdline = re.sub(r'<span.*?</span>', '', hdline)
    hdline = re.sub(r'<.*?>', '', hdline)
    hdline = re.sub(r'\s{2,}', '\n', hdline)

    print(hdline.strip())



