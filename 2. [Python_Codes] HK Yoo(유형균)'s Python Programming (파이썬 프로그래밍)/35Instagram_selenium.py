# 인스타그램을 이용한 스크래핑 예제
# SPA - single page application 구조
# 보도사진 인스타그램에서 해쉬태그 수집
# https://www.instagram.com/randyolson/

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

    # 첫번째 사진 클릭
    chrome.find_element_by_css_selector('div.v1Nh3:first-child a').click()
    time.sleep(2)

    # 해쉬태그 수집
    hashtags = chrome.find_elements_by_css_selector('div.C4VMK span a')
    for tag in hashtags:
        print(tag.text)
        time.sleep(1)

    xbtn = chrome.find_element_by_css_selector('body > div._2dDPU.vCf6V > button.ckWGn')
    mouse = webdriver.ActionChains(chrome)
    mouse.move_to_element(xbtn).click().perform()
    time.sleep(1)


    # 두번째 사진 클릭
    chrome.find_element_by_css_selector('div.v1Nh3:nth-child(2) a').click()
    time.sleep(2)

    # 해쉬태그 수집
    hashtags = chrome.find_elements_by_css_selector('div.C4VMK span a')
    for tag in hashtags:
        print(tag.text)
        time.sleep(1)

    xbtn = chrome.find_element_by_css_selector('body > div._2dDPU.vCf6V > button.ckWGn')
    mouse = webdriver.ActionChains(chrome)
    mouse.move_to_element(xbtn).click().perform()
    time.sleep(1)


    # 세번째 사진 클릭
    chrome.find_element_by_css_selector('div.v1Nh3:nth-child(3) a').click()
    time.sleep(2)

    # 해쉬태그 수집
    hashtags = chrome.find_elements_by_css_selector('div.C4VMK span a')
    for tag in hashtags:
        print(tag.text)
        time.sleep(1)

    xbtn = chrome.find_element_by_css_selector('body > div._2dDPU.vCf6V > button.ckWGn')
    mouse = webdriver.ActionChains(chrome)
    mouse.move_to_element(xbtn).click().perform()
    time.sleep(1)


except Exception as ex:
    print(ex, sys.exc_info()[-1].tb_lineno)
finally:
    chrome.quit()