# 인스타그램을 이용한 스크래핑 예제
# SPA - single page application 구조
# 보도사진 인스타그램에서 해쉬태그 수집
# requests 와 beautifulsoup 을 이용함

# SPA 특징
# 단일 페이지 만으로 구성해서 웹사이트를 제작함
# AJAX 와 JSON, 적절한 이벤트를 활용해서 세련된 UX 를 제공함
# => 주로 SNS 등이 이러한 패턴으로 제작됨

# 일반적으로 웹 어플리케이션에 필요한 일부/전체 정적 데이터를
# 최초에 모두 다운로드하고 이후 새로운 데이터 요청시
# 새로고침이 발생되지 않는 AJAX 를 이용함

# SPA 특성상 서버로부터 데이터를 읽어오면 script 태그를 이용해서
# _sharedData 변수에 그것을 저장함
# 이미지 클릭시 자바스크립트를 이용해서 UI를 생성하고 브라우저에 표시함



from bs4 import BeautifulSoup
import requests

import re
import json
import pprint

url = 'https://www.instagram.com/randyolson'
headers = {'User-Agent':'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko)\
            Chrome/73.0.3683.103 Safari/537.36'}

res = requests.get(url, headers=headers)
html = BeautifulSoup(res.text, 'lxml')


# 본문에서 script 태그에 정의된 _sharedData 변수를 찾아냄
body = html.find('body')
script = body.find('script')


# script 태그내 문자열만 추출
raw_json = script.text.strip()
raw_json = raw_json.replace('window._sharedData = ', '').replace(';', '')


# 전처리된 json(dict) 데이터 확인
# pprint.pprint(raw_json, indent=2)


# json 형식으로 데이터를 메모리에 불러온 후 필요한 데이터 추출
json_data = json.loads(raw_json)


# 웹 브라우저에서는 크롬의 개발자 도구의 network 도구에서
# 맨 마지막 ?query_hash = 가 요청받은 데이터가 json 형태임을 확인


# 해쉬태그 추출방법 1
# post_data = json_data['entry_data']['ProfilePage'][0]
# post_data = post_data['graphql']['user']
# post_data = post_data['edge_owner_to_timeline_media']
# post_data = post_data['edges'][0]['node']
# post_data = post_data['edge_media_to_caption']['edges']
# tag_data = post_data[0]['node']['text']
# # pprint.pprint(tag_data, indent=2)
#
#
# # '#'으로 시작하는 단어 찾기
# tags = re.findall(r'#\w+', tag_data)
# for i in range(0, len(tags)):
#     print(tags[i])



# 해쉬태그 추출방법 2
tags = re.findall(r'#\w+', raw_json)
for i in range(0, len(tags)):
    print(tags[i])

# 문제는 현재 보여지는 페이지의 사진에 대해서만 해쉬태그를 추출
# 두 번째 페이지 분의 사진을 보려면 화면 스크롤이 필요함
