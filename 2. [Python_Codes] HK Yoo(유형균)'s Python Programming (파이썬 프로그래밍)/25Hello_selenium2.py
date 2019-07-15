# headless selenium 사용하기
# 브라우저를 띄우지 않고 지정한 웹사이트의 내용을 추출

# hanbit.co.kr > store > 전체도서목록
# 도서제목, 저자, 가격 추출


from selenium import webdriver
from selenium.webdriver.chrome.options import Options


url = 'http://www.hanbit.co.kr/store/books/full_book_list.html'
executables = r'C:\Program Files (x86)\Google\Chrome\Application\chromedriver.exe'


# headless 를 위한 option 설정

options = Options()
options.add_argument('--headless')

# chrome driver 실행
chrome = webdriver.Chrome(executable_path=executables, options=options)

# 지정한 url 로 접속
chrome.get(url)

# 응답으로 받은 웹페이지소스 변수에 저장
res = chrome.page_source



# 도서제목, 저자, 가격 추출
for a in chrome.find_elements_by_css_selector('td.left a'):
    print(a.text)
for td in chrome.find_elements_by_css_selector('td:nth-child(3).left'):
    print(td.text)
for td in chrome.find_elements_by_css_selector('td.right'):
    print(td.text)


# 브라우저 닫음
chrome.close()



