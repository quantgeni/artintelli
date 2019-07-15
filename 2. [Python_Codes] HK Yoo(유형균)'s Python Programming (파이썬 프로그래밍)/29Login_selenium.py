# 포탈 사이트 로그인한 후 메일건수 추출
# https://www.naver.com/
# https://www.daum.net


from selenium import webdriver
from selenium.webdriver.chrome.options import Options
import sys
import time


url = 'https://www.naver.com/'

options = Options()

try:
    chrome = webdriver.Chrome(options=options)
    chrome.get(url)

    # chrome.implicitly_wait(2)
    time.sleep(2)
    # 페이지내용이 브라우저에 모두 로딩되기를 기다림

    # 로그인 버튼을 찾아서 selenium이 클릭하게 함
    loginbtn = chrome.find_element_by_class_name('lg_local_btn')
    mouse = webdriver.ActionChains(chrome)
    mouse.move_to_element(loginbtn).click().perform()

    # 로그인 정보 입력
    time.sleep(2)

    userid = ''
    passwd = ''

    # 로그인 페이지의 id, pwd 입력창, 로그인버튼 찾음
    uid = chrome.find_element_by_id('id')
    upw = chrome.find_element_by_id('pw')
    loginbtn = chrome.find_element_by_class_name('btn_global')

    # id, pwd 입력창에 값 입력
    uid.send_keys(userid)
    time.sleep(2)
    upw.send_keys(passwd)
    time.sleep(2)

    # 로그인 버튼 클릭
    mouse = webdriver.ActionChains(chrome)
    mouse.move_to_element(loginbtn).click().perform()
    time.sleep(3)


except Exception as ex:
    print(ex, sys.exc_info()[-1].tb_lineno)
finally:
    chrome.quit()

