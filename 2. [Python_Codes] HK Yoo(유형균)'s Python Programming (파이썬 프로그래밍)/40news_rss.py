# 한계레, 파이낸스, JTBC 뉴스 RSS를 이용해서
# 전체기사의 제목과 간략뉴스을 추출함
# www.hani.co.kr
# www.fnnews.com
# news.jtbc.joins.com

# 한계레 신문 RSS
from bs4 import BeautifulSoup
import requests

headers = { 'User-Agent':'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.103 Safari/537.36' }

url = 'http://www.hani.co.kr/rss/'

res = requests.get(url, headers=headers)
rss = BeautifulSoup(res.text, 'lxml')

for news in rss.find_all('item'):
    print(news.title.text, news.description.text)


# 경제신문 RSS
from bs4 import BeautifulSoup
import requests

headers = { 'User-Agent':'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.103 Safari/537.36' }

url = 'http://www.fnnews.com/rss/new/fn_realnews_all.xml'

res = requests.get(url, headers=headers)
rss = BeautifulSoup(res.text, 'html.parser')
# 특수문자를 포함한 텍스트 데이터를 
# 정의하기 위해 CDATA 블럭을 사용한 경우
# bs4의 parser를 lxml이 아닌 html.parser로 변경
# <bold> 10 &gt; 100 </bold>
# <bold> <![CDATA[ 10 > 100 ]]> </bold>

for news in rss.find_all('item'):
    print(news.title.string)
    print(news.description.text)


# JTBC RSS 

from bs4 import BeautifulSoup
import requests

headers = { 'User-Agent':'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.103 Safari/537.36' }

url = 'http://fs.jtbc.joins.com/RSS/newsflash.xml'

res = requests.get(url, headers=headers)
# print(res.encoding)   # ISO-8859-1
res.encoding = 'utf-8'
# RSS의 인코딩이 영어인 경우 한글이 깨짐
# RSS의 인코딩을 적절히 지정하면 정상적으로 출력
rss = BeautifulSoup(res.text, 'lxml')

for news in rss.find_all('item'):
    print(news.title.text)
    print(news.description.text)
