# 써드 파티 라이브러리로 스크래핑
# requests : urllib 보다 고급기능 제공, 외부패키지

# pip install requests
# pip install lxml
# pip install cssselect


## jupyter notebook 에서 설치
# pip install --user requests
# pip install --user lxml
# pip install --user cssselect



import requests
import lxml.html

url = 'http://www.hanbit.co.kr/store/store_submain.html'

res = requests.get(url)     # 스크래핑 시작
print(res.status_code, res.encoding, res.headers['content-type'])
# status_code : http 요청 응답코드 (200, 404) => 요청 처리 여부 확인용

# print(res.text)
html = res.text       # 인코딩한 결과 출력
# 스크래핑 한 결과를 분석해서 필요한 데이터를 추출하기 위해 변수에 저장


# print(res.content)      # 바이트형으로 출력


root = lxml.html.fromstring(html)
# html 문서내의 내용을 요소로 탐색할 수 있도록 계층구조를 메모리내에 생성함
# 문서내 특정 데이터를 추출하려면 css 또는 xpath 표기법을 사용함

# 도서 제목은 p 태그의 book_tit 라는 클래스에 있음
# css 클래스 속성이 'book_tit' 인 p 요소의 하위요소 a 요소들을 추출함(css 선택자)
# 크롬 개발자 도구 : copy css selector를 이용
for part_html in root.cssselect('p.book_tit > a'):
    print(part_html.text_content())
    print(part_html.get('href'))

# 웹 검사 상에서 마우스 오른쪽 > 카피 > 카피 셀렉터
# touchSlider_book > ul > li:nth-child(1) > div > div:nth-child(1) > div > p.book_tit > a
# p.book_tit > a   ==> 끝부분만 옮겨서 검색해도 됨


# 크롬 개발자 도구 : copy xpath를 이용
# //*[@id="touchSlider_book"]/ul/li[1]/div/div[1]/div/p[1]/a
for part_html in root.xpath('//p[1]/a'):
    print(part_html.text_content())
    print(part_html.get('href'))


for part_html in root.xpath('//p[@class="book_tit"]/a'):
    print(part_html.text_content())
    print(part_html.get('href'))
