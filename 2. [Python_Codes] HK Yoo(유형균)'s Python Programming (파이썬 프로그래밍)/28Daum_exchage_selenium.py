# daum.net > 증권 > 오늘의 지수
# daum.net > 증권 > 환율 > 환율조회
# http://finance.daum.net/
# http://finance.daum.net/exchanges

from selenium import webdriver
from selenium.webdriver.chrome.options import Options
import sys

url = 'http://finance.daum.net/'

options = Options()
options.add_argument('--headless')


try:
    chrome = webdriver.Chrome(options=options)
    chrome.get(url)
    chrome.implicitly_wait(2)   # 시간 지연
    res = chrome.page_source
except Exception as ex:
    print(ex, sys.exc_info()[-1].tb_lineno)
finally:
    chrome.quit()


from bs4 import BeautifulSoup

html = BeautifulSoup(res, 'lxml')

for title in html.select('div.stock h5 a'):
    print(title.text.strip())

for indexs in html.select('div.DOMESTIC span strong'):
    print(indexs.text.strip())

for indexs in html.select('div.DOMESTIC span p'):
    print(indexs.text.strip())



##################################################################



from selenium import webdriver
from selenium.webdriver.chrome.options import Options
import sys

url = 'http://finance.daum.net/exchanges'

options = Options()
options.add_argument('--headless')


try:
    chrome = webdriver.Chrome(options=options)
    chrome.get(url)
    chrome.implicitly_wait(2)   # 시간 지연
    res = chrome.page_source
except Exception as ex:
    print(ex, sys.exc_info()[-1].tb_lineno)
finally:
    chrome.quit()


from bs4 import BeautifulSoup

html = BeautifulSoup(res, 'lxml')

for exchage in html.select('table.exchage tbody tr'):
    print(exchage.text.strip())
