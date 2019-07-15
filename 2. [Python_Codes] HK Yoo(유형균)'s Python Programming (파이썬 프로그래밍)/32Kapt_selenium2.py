# 공동주택관리 정보시스템
# 2018.08, 서울, 강남구, 삼성동 소재 모든 아파트
# 아파트 명칭, 법정동 주소
# 아파트 주차대수 (지상, 지하) 등을 추출
# http://www.k-apt.go.kr/kaptinfo/openkaptinfo.do

from selenium import webdriver
from selenium.webdriver.chrome.options import Options
import sys
import time

url = 'http://www.k-apt.go.kr/kaptinfo/openkaptinfo.do'

options = Options()

try:
    chrome = webdriver.Chrome(options=options)
    chrome.get(url)
    time.sleep(2)

    # 검색할 단지 정보 입력
    chrome.find_element_by_xpath('''//*[@title="년도 선택"]/option[text()="2018"]''').click()
    time.sleep(1)
    chrome.find_element_by_xpath('''//*[@title="월 선택"]/option[text()="08"]''').click()
    time.sleep(1)
    chrome.find_element_by_xpath('''//*[@title="광역시도 선택"]/option[text()="서울특별시"]''').click()
    time.sleep(1)
    chrome.find_element_by_xpath('''//*[@title="시군구 선택"]/option[text()="강남구"]''').click()
    time.sleep(1)
    chrome.find_element_by_xpath('''//*[@title="읍면동 선택"]/option[text()="삼성동"]''').click()
    time.sleep(1)

    # 동내 첫번째 아파트에 대한 법정동 주소 출력하기
    # chrome.find_element_by_xpath('//tr[@id="1"]').click()
    # time.sleep(1)
    # chrome.find_element_by_css_selector('img[alt="기본정보"]').click()
    # time.sleep(1)
    #
    # aptname = chrome.find_element_by_id('kapt_name')
    # print('이름 : ', aptname.text)
    # adr = chrome.find_element_by_id('kab_addr')
    # print('주소 : ', adr.text)

    # 동내 모든 아파트에 대한 법정동 주소 출력하기
    for i in range(1, 15+1):
        aptno = '//tr[@id="%s"]' % (i)
        chrome.find_element_by_xpath(aptno).click()
        time.sleep(1)

        chrome.find_element_by_css_selector('img[alt="기본정보"]').click()
        time.sleep(1)

        name = chrome.find_element_by_id('kapt_name')
        print(i, ': ', name.text)
        adr = chrome.find_element_by_id('kab_addr')
        print('주소 : ', adr.text)
        time.sleep(1)

        chrome.find_element_by_css_selector('img[alt="단지검색"]').click()
        time.sleep(2)

        # chrome.find_element_by_css_selector('img[alt="관리시설정보"]').click()
        # parking = chrome.find_element_by_id('parking_cnt')
        # print(parking.text)
        # time.sleep(1)

except Exception as ex:
    print(ex, sys.exc_info()[-1].tb_lineno)
finally:
    chrome.quit()