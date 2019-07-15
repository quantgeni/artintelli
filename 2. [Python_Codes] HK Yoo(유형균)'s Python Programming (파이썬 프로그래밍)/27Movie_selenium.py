# naver.com > 영화 > 영화제목 추출
# daum.net > 영화 > 영화제목 추출

# excutable_path 라는 설정을 사용하지 않기 위해
# chrome driver 를 PATH 환경변수 상 경로에 복사함
# PATH 환경변수 : C:\Java\jdk1.8.0_202\bin

# https://movie.naver.com/
# https://movie.daum.net/main/new#slide-1-0


from selenium import webdriver
from selenium.webdriver.chrome.options import Options
import sys


url = 'https://movie.naver.com'


options = Options()
options.add_argument('--headless')

try:
    chrome = webdriver.Chrome(options=options)
    chrome.get(url)
    res = chrome.page_source
except Exception as ex:   # 모든 예외를 catch 함
    print('오류내용 : %s \n 오류위치 ' % (ex, sys.exc_info[-1].tb_lineno))
finally:
    chrome.close()

from bs4 import BeautifulSoup

html = BeautifulSoup(res, 'lxml')


for title in html.select('p.mv_title'):
    print(title.text)


################################################################

# 다음영화
#
from selenium import webdriver
from selenium.webdriver.chrome.options import Options
import sys

url = 'https://movie.daum.net/main/new#slide-1-0'

options=Options()
options.add_argument('--headless')

try:
    chrome = webdriver.Chrome(options=options)
    chrome.get(url)
    res = chrome.page_source
except Exception as ex:
    print(ex, sys.exc_info[-1].tb_lineno)
finally:
    chrome.close()



from bs4 import BeautifulSoup
html = BeautifulSoup(res, 'lxml')

for title in html.select('strong.tit_poster'):
    print(title.text)



