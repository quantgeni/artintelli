# 공동주택관리 정보시스템
# 2018.08, 서울, 강남구, 삼성동 소재 모든 아파트
# 아파트 명칭, 법정동 주소
# 아파트 주차대수 (지상, 지하) 등을 추출
# http://www.k-apt.go.kr/kaptinfo/openkaptinfo.do

# 보완점 : 검색된 단지 내 아파트 총수를 파악
# 아파트별 id 값을 추출하여 id 값으로 데이터 출력

from selenium import webdriver
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.support.select import Select
import sys
import time

url = 'http://www.k-apt.go.kr/kaptinfo/openkaptinfo.do'

options = Options()

try:
    chrome = webdriver.Chrome(options=options)
    chrome.get(url)
    time.sleep(2)

    # 검색할 단지 정보 입력 2
    yy = Select(chrome.find_element_by_class_name('combo_YYYY'))
    yy.select_by_visible_text('2018')
    time.sleep(1)

    mm = Select(chrome.find_element_by_class_name('combo_MM'))
    mm.select_by_visible_text('08')
    time.sleep(1)

    sido = Select(chrome.find_element_by_class_name('combo_SIDO'))
    sido.select_by_visible_text('서울특별시')
    time.sleep(1)

    gugun = Select(chrome.find_element_by_class_name('combo_SGG'))
    gugun.select_by_visible_text('강남구')
    time.sleep(1)

    dong = Select(chrome.find_element_by_class_name('combo_EMD'))
    dong.select_by_visible_text('삼성동')
    time.sleep(1)


    # 아파트 목록 마지막 id 값 알아내기 1
    # trs = chrome.find_elements_by_css_selector('tr.ui-widget-content')
    # for tr in trs:
    #     id = tr.get_attribute('id')
    # print(id)


    # 아파트 목록 마지막 id 값 알아내기 2
    # table[id="aptInfoList"] tr:last-child
    # //table[@id="aptInfoList"]/tbody/tr
    tr = chrome.find_element_by_css_selector('table[id="aptInfoList"] tr:last-child')
    id = tr.get_attribute('id')
    # print(id)


    # 동내 모든 아파트에 대한 법정동 주소 출력하기
    for i in range(1, int(id)+1):
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




except Exception as ex:
    print(ex, sys.exc_info()[-1].tb_lineno)
finally:
    chrome.quit()
