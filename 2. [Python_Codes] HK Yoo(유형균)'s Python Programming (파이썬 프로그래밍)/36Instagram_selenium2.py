# 인스타그램을 이용한 스크래핑 예제
# SPA - single page application 구조
# 보도사진 인스타그램에서 해쉬태그 수집
# https://www.instagram.com/randyolson/
# 첫 화면에 보이는 모든 사진 12장에 대한 해쉬태그 수집
# 단, #이 붙은 태그만 추출 (@태그는 제외)
# 중복 해쉬태그는 제외


from selenium import webdriver
from selenium.webdriver.chrome.options import Options
import sys
import time

url = 'https://www.instagram.com/randyolson'

options = Options()

try:
    chrome = webdriver.Chrome(options=options)
    chrome.get(url)
    time.sleep(2)

    # 모든 사진에 대한 해쉬태그 추출 1
    # for i in range(1, 3+1):
    #     img = 'div.v1Nh3:nth-child(%d) a' % (i)
    #     chrome.find_element_by_css_selector(img).click()
    #     time.sleep(2)
    #
    #     hashtags = chrome.find_elements_by_css_selector('div.C4VMK span a')
    #     for tag in hashtags:
    #         print(tag.text)
    #
    #     chrome.find_element_by_css_selector('button.ckWGn').click()
    #     time.sleep(2)



    # 모든 사진에 대한 해쉬태그 추출 2
    # 총 게시물 수 추출
    cnt = chrome.find_element_by_css_selector('span.g47SY:first-child').text
    print(cnt)


    # 첫번째 사진 클릭
    chrome.find_element_by_css_selector('div.v1Nh3:first-child a').click()
    time.sleep(2)

    # 해쉬태그 추출후 다음 버튼 클릭
    for _ in range(1, int(cnt)):
        hashs = chrome.find_elements_by_css_selector('div.C4VMK span a')
        for tag in hashs:
            print(tag.text)

        chrome.find_element_by_css_selector('a.HBoOv').click()
        time.sleep(2)




except Exception as ex:
    print(ex, sys.exc_info()[-1].tb_lineno)
finally:
    chrome.quit()





