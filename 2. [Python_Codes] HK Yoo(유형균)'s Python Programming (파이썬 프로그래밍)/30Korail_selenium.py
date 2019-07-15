# 코레일 사이트에 접속해서 열차정보 추출
# http://www.letskorail.com/

from selenium import webdriver
from selenium.webdriver.common.alert import Alert
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.options import Options
import sys
import time

url = 'http://www.letskorail.com/'

options = Options()

userid = '1468413274'
passwd = ''


try:
    chrome = webdriver.Chrome(options=options)
    chrome.get(url)
    time.sleep(2)

    # 로그인 버튼을 클릭해서 로그인 페이지로 이동
    loginbtn = chrome.find_element_by_css_selector('ul.gnb_list > li:nth-child(2) > a')
    mouse = webdriver.ActionChains(chrome)
    mouse.move_to_element(loginbtn).click().perform()
    time.sleep(2)

    # 로그인 정보 입력하고 로그인
    uid = chrome.find_element_by_id('txtMember')
    upw = chrome.find_element_by_id('txtPwd')

    uid.send_keys(userid)
    time.sleep(2)
    upw.send_keys(passwd)
    time.sleep(2)

    # 로그인버튼 클릭
    loginbtn = chrome.find_element_by_css_selector('img[alt="확인"]')
    mouse = webdriver.ActionChains(chrome)
    mouse.move_to_element(loginbtn).click().perform()
    time.sleep(5)

    # 로그인 한 후 메인페이지에서 '승차권 예매' 버튼 클릭
    resvbtn = chrome.find_element_by_css_selector('img[alt="승차권예매"]')
    mouse = webdriver.ActionChains(chrome)
    mouse.move_to_element(resvbtn).click().perform()
    time.sleep(5)

    # '승차권 예매' 페이지에서 '일반승차권'을 대상으로 인원정보, 좌석방향,
    # 기차유형, 출발/도착역, 출발일(년/월/일/시) 변경 후 '조회하기' 버튼 클릭
    psnum = chrome.find_element_by_id('peop01')
    seatdr = chrome.find_element_by_id('seat02')
    trntype = chrome.find_element_by_css_selector('input[title="KTX"]')
    bgnst = chrome.find_element_by_id('start')
    endst = chrome.find_element_by_id('get')
    stnbtn = ''
    styear = chrome.find_element_by_id('s_year')
    stmon = chrome.find_element_by_id('s_month')
    stday = chrome.find_element_by_id('s_day')
    sttime = chrome.find_element_by_id('s_hour')
    findbtn = chrome.find_element_by_css_selector('img[alt="조회하기"]')
    time.sleep(1)

    # 실제 값 지정하기
    trntype.click()     # 열차유형 : KTX 선택
    time.sleep(1)
    # alert 창을 띄우기 위해 의도적으로 출발/도착역 지정
    # 2019.04.04 강원도 산불 관련 안내
    bgnst.clear(); bgnst.send_keys('청량리')
    time.sleep(1)
    endst.clear(); endst.send_keys('양평')
    time.sleep(1)

    # select 요소를 선택하려면 by_xpath 함수를 사용해야 함
    chrome.find_element_by_xpath('//*[@id="peop01"]/option[text()="어른 3명"]').click()
    time.sleep(1)
    chrome.find_element_by_xpath('//*[@id="seat02"]/option[text()="역방향석"]').click()
    time.sleep(1)
    chrome.find_element_by_xpath('//*[@id="s_year"]/option[text()="2019"]').click()
    time.sleep(1)
    chrome.find_element_by_xpath('//*[@id="s_month"]/option[text()="4"]').click()
    time.sleep(1)
    chrome.find_element_by_xpath('//*[@id="s_day"]/option[text()="30"]').click()
    time.sleep(1)
    chrome.find_element_by_xpath('//*[@id="s_hour"]/option[text()="12 (오후00)"]').click()
    time.sleep(1)

    # 조회하기 버튼 클릭
    mouse = webdriver.ActionChains(chrome)
    mouse.move_to_element(findbtn).click().perform()
    time.sleep(3)

    # alert 대화상자 처리

    Alert(chrome).accept()
    time.sleep(3)

    # 예매페이지가 잘 보이도록 페이지를 아래로 스크롤 함
    chrome.execute_script('scrollTo(0,550)')
    time.sleep(5)

except Exception as ex:
    print(ex, sys.exc_info()[-1].tb_lineno)
finally:
    chrome.quit()



















