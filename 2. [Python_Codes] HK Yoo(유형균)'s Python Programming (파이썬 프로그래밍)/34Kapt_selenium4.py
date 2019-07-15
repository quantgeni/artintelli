# 공동주택관리 정보시스템
# 2018.08, 서울, 강남구, 삼성동 소재 모든 아파트
# 아파트 명칭, 법정동 주소
# 아파트 주차대수 (지상, 지하) 등을 추출
# http://www.k-apt.go.kr/kaptinfo/openkaptinfo.do

# 실제 URL 상에서 질의문자열으 포함시켜 정보 추출
# openkaptinfo.do : 요청 폼 데이터 없음

# getKaptInfo_poi.do : 요청 폼 데이터 포함
# bjd_code : 11680105, search_date : 201808
# ?bjd_code=11680105&search_date=201808

# getKaptInfo_detail.do : 요청 폼 데이터 포함
# kap_code : A10026350
# ?kapt_code=A10026350

# getKaptSetday.do : 요청 폼 데이터 포함
# ?kapt_code=A10026350
# 주차장 대수 : kapSetDatList > kaptInfo > KAPTD_PCNTU > "1247"

# 따라서, 2018, 08, 서울, 강남구, 삼성동을 선택했을때
# 보여지는 코드값이 무엇인지 파악해봄
# 11 680 105, A10026350, 201808


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

    time.sleep(3)

    # 선택한 시, 구, 동에 대한 코드값 출력
    for option in sido.options:
        if option.text == '서울특별시':
            print(option.text, option.get_attribute('value'))

    # 선택한 시, 구, 동에 대한 아파트의 코드값 출력
    # td 태그의 style 속성에 display:none 이 지정
    # 따라서, 요소명.text 로는 해당 코드값을 추출 X




except Exception as ex:
    print(ex, sys.exc_info()[-1].tb_lineno)
finally:
    chrome.quit()












