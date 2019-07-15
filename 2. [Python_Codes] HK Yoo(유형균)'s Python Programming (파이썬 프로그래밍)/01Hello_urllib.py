# scrapying 과 crawling

# 스크래핑은 웹사이트에 있는 특정정보를 추출하는 기술을 총칭하는 말
# 크롤링은 프로그램을 이용해서 정기적으로 정보를 추출하는 것을 의미

# 파이썬에서는 스크래핑을 위한 패키지로 requests 와 urllib/urllib2 를 사용함
# urllib/urllib2 : 사용하기 편함, 코드 단순, 내장패키지
# requests : urllib보다 고급기능 제공, 외부패키지

# ex) 온라인 도서 쇼핑몰의 도서 정보를 스크래핑

# 먼저, 도서정보가 있는 사이트의 url을 알아냄
# hanbit.co.kr > store > 도서목록의 제목 추출
# http://www.hanbit.co.kr/store/store_submain.html

# 웹페이지 스크래핑을 위한 필수 패키지 초기화

from urllib.request import urlopen

url = 'http://www.hanbit.co.kr/store/store_submain.html'
docs = urlopen(url)
# 스크래핑 할 웹페이지의 url을 urlopen 함수의 매개변수로 전달함
# docs 에는 open 한 url의 html 소스가 저장됨

print(docs)
# html 소스가 객체형태로 저장되어 있음

text = docs.read()
print(text)
# 객체형태로 저장된 내용을 read 함수를 이용해서 텍스트로 변환후 출력
# 하지만, 인코딩처리 없이 변환했기 때문에 한글은 제대로 보이지 않음

docs = urlopen(url)
encode = docs.info().get_content_charset()
# http 헤더를 기반으로 스크래핑한 문서의 인코딩 방식을 알아냄

text = docs.read().decode(encode)
print(text)
# 알아낸 문서의 인코딩을 이용해서 스크래핑한 문서를 해독하고 출력함


with open('data/01storemain.html','w', encoding=encode) as out:
    out.write(text)




















