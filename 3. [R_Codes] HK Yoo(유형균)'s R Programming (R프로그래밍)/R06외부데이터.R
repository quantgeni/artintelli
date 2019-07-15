### 외부데이터를 이용하기

# 내장 데이터셋 이용
# 외부파일(txt, csv, xlxs, xml, json) 등을 이용


## 내장 데이터셋 목록보기

library(help='datasets')

data()

plot(Nile)
data(Nile)   # 해당 데이터셋의 자료출력
head(Nile)
str(Nile)
summary(Nile)

data(AirPassengers)
plot(AirPassengers)
head(Nile)
str(Nile)
summary(Nile)

data("iris")
plot(iris)
head(Nile)
str(Nile)
summary(Nile)




## 외부 데이터 읽어오기

# 텍스트데이터 읽어오기 : read.table()

# 데이터와 데이터를 구분하기 위해 구분자(공백, 콤마, 탭)을 사용


# 1. 공백으로 분리된 텍스트 파일

# 메모장에서 데이터를 파일을 작성함(인코딩은 euc-kr/ansi 로 지정)
# read.table(파일명, 머릿글여부, 구분자)

sj1 <- read.table('c:/Java/data1.txt', header=T, sep=' ')  # 공백
sj1

sj2 <- read.table('c:/Java/data2.txt', header=T, sep=',')  # 콤마
sj2

sj3 <- read.table('c:/Java/data3.txt', header=T, sep='\t')  # 탭
sj3



# 콤마로 분리된 텍스트 csv 파일 : read.csv()
# read.csv(파일명, 머릿글여부)

sj4 <- read.csv('c:/Java/data4.csv', header=T)
sj4


# 엑셀파일 : read_xecel() 함수
# 해들리 위컴이 개발한 readxl 패키지를 이용

install.packages('readxl')
library(readxl)

xlsx <- read_excel('c:/Java/ebook.xlsx', sheet='data', col_names=T)
xlsx

head(xlsx, n=15)
# readxl 패키지 덕택에 head 함수의 출력결과가 다르게 보임








# ex6) 서울시/경기도 우편번호 데이터를 읽어와서  
# 데이터프레임으로 만드는 R 코드를 작성하세요

seoul <- read_excel('c:/Java/서울특별시.', sheet='data', col_names=T)

seoul <- read.csv('c:/Java/서울특별시.csv', header=T)
seoul

colnames(seoul)

seoul1 <- data.frame("Year", "City", "Sport", "Discipline", "Athlete",   
                     "Country", "Gender", "Event" , "Medal")

seoul1




# ex7) summermedal 우편번호 데이터를 읽어와서  
# 데이터프레임으로 만드는 R 코드를 작성하세요

smml <- read_excel('c:/Java/summermedal.xlsx', sheet='data', col_names=T)

smml <- read.csv('c:/Java/summermedal.csv', header=T)
smml




# ex8) 인구주택총조사2015 데이터를 읽어와서  
# 데이터프레임으로 만드는 R 코드를 작성하세요

hht <- read_excel('c:/Java/인구주택총조사2015.xlsx', 
                  sheet='data', col_names=T)

hht <- read.csv('c:/Java/인구주택총조사2015.csv', header=T)
hht

hht <- read.csv('c:/Java/인구주택총조사2015.csv', header=T)
hht
















