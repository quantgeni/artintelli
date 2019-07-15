# 인스타그램을 이용한 스크래핑 예제
# SPA - single page application 구조
# 보도사진 인스타그램에서 해쉬태그 수집
# beautifulsoup, selenium 을 이용함
# 페이지 자동 스크롤을 이용해서
# json 형식의 데이터로부터 해쉬태그 추출

# 첫번째 페이지의 해쉬태그는 script 태그내 _sharedData에서 추출하고
# 두번째 페이지부터는 이미지들의 alt 속성에 있는 텍스트 중 해쉬태그를 찾음


from bs4 import BeautifulSoup
from selenium import webdriver
from selenium.webdriver.chrome.options import Options

import re
import sys
import time


url = 'https://www.instagram.com/randyolson'
options = Options()


try:
    chrome = webdriver.Chrome(options=options)
    chrome.get(url)
    time.sleep(2)


    # 첫번째 페이지 해쉬태그 추출
    res = chrome.page_source
    html = BeautifulSoup(res, 'lxml')

    body = html.find('body')
    script = body.find('script')

    raw_json = script.text.strip().replace('window._sharedData = ', '').replace(';','')

    tags = re.findall(r'#\w+', raw_json)
    for i in range(0, len(tags)):
        print(tags[i])


    # 나머지 페이지 해쉬태그 추출
    sscroll = 0    # 처음 스크롤 위치
    while True:
        # 브라우저를 스크롤함
        moves = '''scrollTo(0, document.body.scrollHeight);'''
        chrome.execute_script(moves)
        time.sleep(2)

        # html 소스를 bs 객체로 변환
        html = BeautifulSoup(chrome.page_source, 'lxml')
        time.sleep(2)

        # bs 객체로 부터 img 태그의 alt 속성에서 해쉬태그 추출
        for img in html.select('img[alt]'):
            alt = img.get('alt')
            tags = re.findall(r'#\w+', alt)
            for i in range(len(tags)):
                print(tags[i])

        time.sleep(1)

        # 총 스크롤한 거리 파악
        oscroll = chrome.execute_script('return window.pageYOffset;')
        # print(sscroll, oscroll)

        # 이동한 거리와 이동가능한 거리를 비교
        if sscroll == oscroll:
            print('스크롤불가')
            break
        elif sscroll < oscroll:
            sscroll = oscroll

        time.sleep(1)


except Exception as ex:
    print(ex, sys.exc_info()[-1].tb_lineno)
finally:
    chrome.quit()













