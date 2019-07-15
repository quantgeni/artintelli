# 파이썬으로 json 형식 다루기

import json
from collections import OrderedDict
# json 파일을 생성하기 위해 dict형 객체 선언

# json 형식을 단순하게 정의
userid = 'abc123'
passwd = '987xyz'
name = '홍길동'

userinfo = { 'userid' : userid, 
             'passwd' : passwd,
             'name' : name }
print(userinfo)           

# json 객체 생성 : dumps
# json_obj = json.dumps(userinfo)
json_obj = json.dumps(userinfo, \
                        ensure_ascii=False)
print(json_obj)


# json 형식을 OrderedDict를 이용해서 정의
userinfo = OrderedDict()
userinfo['userid'] = userid
userinfo['passwd'] = passwd
userinfo['name'] = name

print(json.dumps(userinfo, \
        ensure_ascii=False))


# 좀 더 복잡한 json 형식 정의
# 개인정보(이름,이메일,전화번호,친구) +
# 친구(수지,혜교,지현) +
# 학력사항(고교,대학,대학원)
persons = OrderedDict()
persons['name'] = '홍길동'
persons['email'] = 'abc123@xyz987.com'
persons['phone'] = '123-1234-9876'
persons['friends'] = ['수지','혜교','지현']

schools = OrderedDict()
schools['high'] = '서울고'
schools['univ'] = '서울대'
schools['grad'] = '서울대학원'

persons['schools'] = schools

print(json.dumps(persons, ensure_ascii=False))


# 생성한 데이터를 파일로 저장
with open('data/persons.json', 'w',
    encoding='utf-8') as j:
    json.dump(persons, j, ensure_ascii=False)


# 날씨 데이터를 json으로 저장
from bs4 import BeautifulSoup
import requests
import json
from collections import OrderedDict

headers = { 'User-Agent':'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.103 Safari/537.36' }

url = 'http://www.kma.go.kr/weather/forecast/mid-term-rss3.jsp?stnId=109'

res = requests.get(url, headers=headers)
rss = BeautifulSoup(res.text, 'lxml')

weathers = []

for weather in rss.find_all('data'):
    tmef = weather.tmef.text 
    wf = weather.wf.text
    tmn = weather.tmn.text
    tmx = weather.tmx.text

    weather = OrderedDict()
    weather['tmEf'] = tmef
    weather['wf'] = wf
    weather['tmn'] = tmn
    weather['tmx'] = tmx
    weathers.append(weather)

allweathers = OrderedDict()
allweathers['weathers'] = weathers

with open('data/weather2.json', 'w', encoding='utf-8') as j:
    json.dump(allweathers, j, ensure_ascii=False, indent=2)

