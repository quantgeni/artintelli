# 기상청 날씨 데이터 수집하기
# www.kma.go.kr
# 기상청 날씨누리 -> 특보.예보 -> 동네예보
# 기상청 날씨누리 -> 생활과산업 
#        -> 서비스 -> 인터넷 -> RSS

# RSS : rich site summary
# 사이트를 구독subscribe한 사용자에게 업데이트된 
# 컨덴츠를 간편하게 배포하고자 만든 데이터 형식

# RSS 구독 프로그램을 이용하면
# 사이트를 방문하지 않고도 해당 사이트의 
# 컨텐츠를 이용할 수 있다는 장점 존재

# 중기예보 : 서울&경기 날씨 RSS
# http://www.kma.go.kr/weather/forecast/mid-term-rss3.jsp?stnId=109

# 동네예보 : 서울 강남구 논현1동
# http://www.kma.go.kr/wid/queryDFSRSS.jsp?zone=1168052100

from urllib.request import urlopen
from html import unescape
import csv

# 파이썬에서 xml문서를 처리하기 위한 모듈 (lxml)
from xml.etree import ElementTree

# 지정한 url에서 xml 문서를 읽어서 화면에 출력
url = 'http://www.kma.go.kr/weather/forecast/mid-term-rss3.jsp?stnId=109'

f = urlopen(url)
text = f.read().decode('utf-8')
# print(text)


# 화면에 출력한 내용은
# 파일(data/weather.xml)에 저장
with open('data/weather.xml', 'w', encoding='utf-8') as f:
    f.write(text)

# xml parser를 이용해서 파일을 읽어오고
# 메모리에 xml 계층구조를 만들기 위해
# ElementTree 객체 생성
tree = ElementTree.parse('data/weather.xml')

# getroot 메서드로 XML 상위요소를 추출
root = tree.getroot()

# findall 메서드로 추출할 데이터가 있는
# 요소element를 지정함
for weather in root.findall(
    'channel/item/description/body/location/data'):
    # find 메서드로 요소를 지정하고
    # text 속성으로 해당 데이터을 추출함
    tmef = weather.find('tmEf').text    # 시간
    wf = weather.find('wf').text        # 날씨정보
    tmn = weather.find('tmn').text      # 최소온도
    tmx = weather.find('tmx').text      # 최고온도

    print(tmef, wf, tmn, tmx)


# 동네예보 출력
# 파일로 저장 : data/town.xml
# 날짜,시각,날씨,강수확률,기온,습도
import datetime

url = 'http://www.kma.go.kr/wid/queryDFSRSS.jsp?zone=1168052100'

f = urlopen(url)
text = f.read().decode('utf-8')

with open('data/town.xml', 'w', encoding='utf-8') as f:
    f.write(text)

tree = ElementTree.parse('data/town.xml')
root = tree.getroot()

for wtop in root.findall(
    'channel/item/description'):

    # 먼저 날짜정보 추출
    day = wtop.find('header/tm').text[0:8]
    # 추출한 날짜 문자열을 날짜형으로 생성
    today = datetime.datetime.\
            strptime(day, '%Y%m%d')
    
    for weather in wtop.findall('body/data'):
        # 경과일을 추출해서 날짜와 합산
        day = int(weather.find('day').text)
        myday = str(today + \
            datetime.timedelta(days=day))[0:10]

        hour = weather.find('hour').text # 시각
        wf = weather.find('wfKor').text # 날씨
        pop = weather.find('pop').text # 강수
        temp = weather.find('temp').text # 기온
        reh = weather.find('reh').text # 습도

        print(myday, hour, wf, pop, temp, reh)


# requests + bs4를 이용한 RSS 데이터 수집
from bs4 import BeautifulSoup
import requests

headers = { 'User-Agent':'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.103 Safari/537.36' }

url = 'http://www.kma.go.kr/wid/queryDFSRSS.jsp?zone=1168052100'

res = requests.get(url, headers=headers)
html = BeautifulSoup(res.text, 'lxml')

for weather in html.findAll('data'):
    print(weather.day.string)
    # weather['day'].text
    print(weather.wfkor.string)
    print(weather.temp.string)

for weather in html.find_all('data'):
    print(weather.day.text)
    print(weather.wfkor.text)
    print(weather.temp.text)
