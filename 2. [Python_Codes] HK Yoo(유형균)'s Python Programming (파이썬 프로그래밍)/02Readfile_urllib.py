import sys
import re

# 스크래핑 한 결과를 저장한 파일로 부터 내용을 읽어들여 화면에 출력

with open('data/01storemain.html', 'r', encoding='utf-8') as f:
    html = f.read()

print(html)




# 도서제목을 추출하기 위해 정규표현식을 이용
# 파이썬 정규표현식 패키지는 re

htm = r'<p class="book_tit"><a.*?</p>'

for part_html in re.findall(htm, html, re.DOTALL):
    # print(part_html)
    title = re.sub(r'<.*?>', '', part_html)
    print(title)
