# 포탈 사이트 로그인한 후 메일건수 추출
# https://www.naver.com/
# https://www.daum.net
# 다음의 경우 로그인 폼이 iframe 속에 들어 있음

from selenium import webdriver
from selenium.webdriver.chrome.options import Options
import sys
import time


url = 'https://www.daum.net'

options = Options()

try:
    chrome = webdriver.Chrome(options=options)
    chrome.get(url)

    # selenium의 제어를 main 이 아닌 iframe 으로 이동
    iframe = chrome.find_element_by_id('loginForm')
    chrome.switch_to.frame(iframe)
    time.sleep(2)

    userid = ''
    passwd = ''

    uid = chrome.find_element_by_id('id')
    upw = chrome.find_element_by_id('inputPwd')
    loginbtn = chrome.find_element_by_id('loginSubmit')

    uid.send_keys(userid)
    time.sleep(2)
    upw.send_keys(passwd)
    time.sleep(2)

    mouse = webdriver.ActionChains(chrome)
    mouse.move_to_element(loginbtn).click().perform()
    time.sleep(2)

    # 받은 메일 확인
    mailnum = chrome.find_element_by_class_name('link_num')
    print('받은메일 : ', mailnum.text)
    time.sleep(2)

    # 로그아웃 버튼 클릭
    logoutbtn = chrome.find_element_by_class_name('btn_logout')
    logoutbtn.submit()  # submit 버튼이므로
    time.sleep(2)



except Exception as ex:
    print(ex, sys.exc_info()[-1].tb_lineno)
finally:
    chrome.quit()








