# yes24 => '빅데이터' 검색 > IT 모바일 카테고리 선택
#                          > 신상품순 선택 > 3 번페이지로 이동
# 도서제목, 저자, 가격
# http://www.yes24.com/searchcorner/Search
# 한글을 querystring 인코딩 하려면
# dencode.com 에서 EUC-KR로 설정하고 변환하면 됨

# 빅데이터 (query) : %ba%f2%b5%a5%c0%cc%c5%cd
# 'IT 모바일' 카테고리(001001003) : disp_no
# 페이지 (3) : PageNumber
# 신상품 (RECENT_DATE) : sort_gb


from bs4 import BeautifulSoup
import requests
import urllib

url = 'http://www.yes24.com/searchcorner/Search'

key = '빅데이터'
keyWord = key.encode('euc-kr')
# keyWord = urllib.parse.quote(key, encoding='euc-kr')

headers = {'User-Agent':'Mozilla/5.0 (Windows NT 10.0; Win64; x64) \
    AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.103 Safari/537.36'}
params = { 'query': keyWord, 'disp_no':'001001003', \
          'PageNumber':'3', 'sort_gb':'RECENT_DATE' }

res = requests.get(url, headers=headers, params=params)
html = BeautifulSoup(res.text, 'lxml')

# 제목
for part_html in html.select('p.goods_name a strong'):
    print(part_html.text)

# 가격
for part_html in html.select('p.goods_price strong'):
    print(part_html.text)

# 저자
for part_html in html.select('div.goods_info'):
    print(part_html.text.split('|')[0])



# python으로 url encoding 하기

# url 문자열에 사용된 텍스트를 모든 브라우저에서 서버로
# 제대로 전송하기 위해 인코딩하는 것을 의미

# 일반적으로 인터넷의 url에는 ASCII 문자열을 이용함
# 한편, 한국어나 일본어, 각종 특수문자를 url 문자열에
# 포함시켜 보내는 경우 문제가 발생할 수 있음
# 따라서, 적절한 인코딩을 통해 url 문자열을 생성해야
# 문자열이 서버로 올바르게 전송됨

# 인코딩한 문자열 형태 : %8진수
# # : %23, 공백 : %20, 가 : %B0%A1 (euc-kr)

# import urllib.parse
#
# key = '빅데이터'
# print(urllib.parse.quote(key))
# print(urllib.parse.quote_plus(key))
# print(urllib.parse.quote(key, encoding='euc-kr'))
# print(urllib.parse.quote_plus(key, encoding='euc-kr'))
#
#
# key = '빅 데이터'
# print(urllib.parse.quote(key))
# print(urllib.parse.quote_plus(key))
# print(urllib.parse.quote(key, encoding='euc-kr'))
# print(urllib.parse.quote_plus(key, encoding='euc-kr'))






