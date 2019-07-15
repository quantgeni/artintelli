# ex) 포탈사이트의 영화 순위를 스크래핑
# naver.com / daum.net > 영화 > 순위별 영화제목 추출

# 웹 문서 저장시 파일명은 08naver_movie.html
# 웹 문서 저장시 파일명은 09daum_movie.html

# https://movie.naver.com/
# https://movie.daum.net/main/new#slide-1-0


from urllib.request import urlopen
import re

url1 = 'https://movie.naver.com/'

docs = urlopen(url1)
encode = docs.info().get_content_charset()
text = docs.read().decode(encode)

with open('data/08naver_movie.html', 'w', encoding='utf-8') as out:
    out.write(text)

with open('data/08naver_movie.html', 'r', encoding='utf-8') as f:
    html = f.read()


css1 = r'<p class="mv_title">.*?</p>'
re.findall(css1, html, re.DOTALL)

# => 브라우저 내에서 보여지는 html 소스와
# 이것을 파일로 저장했을때 소스가 서로 다름
# 즉, 브라우저 내에서 보여지는 소스는
# 동적처리가 된 상태의 결과물이고
# 파일로 저장한 소스는 동적처리 전 결과물임



url2 = 'https://movie.daum.net/main/new#slide-1-0'


docs = urlopen(url2)
encode = docs.info().get_content_charset()
text = docs.read().decode(encode)

with open('data/09daum_movie.html', 'w', encoding='utf-8') as out:
    out.write(text)

with open('data/09daum_movie.html', 'r', encoding='utf-8') as f:
    html = f.read()


css2 = r'<strong class="tit_poster">.*?</a>'
re.findall(css2, html, re.DOTALL)






