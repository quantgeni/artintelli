### 대용량 데이터 읽어오기

# 빠른 처리속도가 장점

## readr 패키지 (추천) : 해들리 위캄 제작 
# => 결과 : 데이터프레임의 특수한 형태인 tibble 객체로 생성

install.packages('readr')
library('readr')


sj <- read_delim('c:/Java/data4.csv', delim=',', col_names=T,
                 locale=readr::locale(encoding='EUC-KR'))
sj

sj <- read_csv('c:/Java/data4.csv', col_names=T)
sj

?readr



## data.table 패키지   : 매트 다울리 제작
# => 결과 : 데이터프레임의 특수한 형태인 data.table 객체로 생성

install.packages('data.table')
library('data.table')

sj <- fread('c:/Java/data4.csv', header=T, sep=',')
sj

?data.table





# ex12) '분석용데이터product' 데이터를 읽어와서 데이터 프레임으로
#       만드는 R 코드를 작성하세요

library('readr')

url <- 'c:/Java/분석용데이터Product.csv'
product <- read_csv(url, col_names=T) 
head(product, n=10)


product2 <- read_delim(url, col_names=T, delim=',') 
head(product2, n=10)


library('data.table')
product3 <- fread(url, header=T, sep=',', encoding='UTF-8') 
head(product3, n=10)






## 데이터베이스를 이용한 외부데이터 추가하기

# MySQL / MariaDB / Oracle 등을 이용해서 
# 테이블에 저장된 데이터를 R 객체로 생성함


# R + MariaDB/MySQL
# RMySQL 패키지를 이용해서 테이블의 데이터를
# 데이터프레임으로 변환가능

install.packages('RMySQL')
library('RMySQL')
?RMySQL


# 접속시도
mysqlconn <- dbConnect(MySQL(), user='bigdata', password='bigdata0220', 
                       dbname='bigdata', host='52.79.242.106')

# 접속후 인코딩방식을 UTF-8 로 재설정
dbSendQuery(mysqlconn, 'SET NAMES utf8;')
dbSendQuery(mysqlconn, 'SET CHARACTER SET utf8;')
dbSendQuery(mysqlconn, 'SET character_set_connection=utf8;')


dbListTables(mysqlconn)
# 디비상의 테이블들을 조회


sql <- 'select * from weathers'
result <- dbSendQuery(mysqlconn, sql)
# 질의 생성후 결과집합 저장


weathers <- fetch(result)
# 결과집합에서 한행씩 추출해서 전부를 저장


dbDisconnect(mysqlconn)   # 접속해제

nrow(weathers)
head(weathers)


# 출력시 한글깨짐 현상이 발생하면 iconv 함수를 이용해서
# UTF-8 로 문자변환함
# iconv(대상, 인코딩)

mode(weathers)   # 자료형은 list

weathers[[2]] <- iconv(weathers[[2]], from='UTF-8')

weathers





# ex12) MariaDB의 bigdata 데이터베이스의 
# Books, Customers, Orders 테이블의 데이터를 
# 읽어와서 데이터프레임으로 만드는 R 코드를 작성하세요

mysqlconn <- dbConnect(MySQL(), user='bigdata', password='bigdata0220', 
                       dbname='bigdata', host='52.79.242.106')

dbSendQuery(mysqlconn, 'SET NAMES utf8;')
dbSendQuery(mysqlconn, 'SET CHARACTER SET utf8;')
dbSendQuery(mysqlconn, 'SET character_set_connection=utf8;')

dbListTables(mysqlconn)

sql1 <- 'select * from Books'
sql2 <- 'select * from Customers'
sql3 <- 'select * from Orders'

result1 <- dbSendQuery(mysqlconn, sql1)
custs <- fetch(result1)

result2 <- dbSendQuery(mysqlconn, sql2)
books <- fetch(result2)

result3 <- dbSendQuery(mysqlconn, sql3)
orders <- fetch(result3)

dbDisconnect(mysqlconn)   # 접속해제


# books 테이블에 대해 인코딩 변환

books[[2]] <- iconv(books[[2]], from='UTF-8')
books[[3]] <- iconv(books[[3]], from='UTF-8')


# Customers 테이블에 대해 인코딩 변환

custs[[2]] <- iconv(custs[[2]], from='UTF-8')
custs[[3]] <- iconv(custs[[3]], from='UTF-8')


nrow(custs)
nrow(books)
nrow(orders)

head(custs)
head(books)
head(orders)






# R + Oracle

# RJDBC, DBI 패키지를 이용해서 데이터를 
# 데이터프레임으로 변환 가능
# 사용하기 전 반드시 관련 JDBC 드라이버를 미리 준비해둘것!!(ojdbc8.jar) 

install.packages('rJava')
install.packages('RJDBC')
install.packages('DBI')

library('rJava')
library('RJDBC')
library('DBI')


OJDBC <- JDBC(driverClass= 'oracle.jdbc.OracleDriver', 
              classPath= 'c:/Java/ojdbc8.jar')
# 오라클 JDBC 드라이버 객체 생성


oracleconn <- dbConnect(OJDBC, 'jdbc:oracle:thin:@//54.180.159.88:1521/xe',
                        'bigdata', 'bigdata0220')
# 연결문자열을 이용해서 연결객체 생성


sql <- 'select * from BOOKS'
book <- dbGetQuery(oracleconn, sql)
# 질의문을 실행하고 결과를 저장


dbDisconnect(oracleconn)
# 연결종료


head(books)








# ex13) 우편번호 데이터를 이용해서 
# 도로명을 '약수암길'로 지정해서 검색한 후
# 데이터프레임으로 저장하세요
# 테이블명 : SEOUL
# 도로명 컬럼 : ROAD

jhenv <- 'c:\\Java\\jdk1.8.0_202'
Sys.setenv(JAVA_HOME=jhenv)
# 환경변수설정


library('rJava')
library('RJDBC')
library('DBI')


OJDBC <- JDBC(driverClass= 'oracle.jdbc.OracleDriver', 
              classPath= 'c:/Java/ojdbc8.jar')

oracleconn <- dbConnect(OJDBC, 'jdbc:oracle:thin:@//54.180.159.88:1521/xe',
                        'bigdata', 'bigdata0220')

sql <- "select * from SEOUL where ROAD like '%약수암길' "

addr <- dbGetQuery(oracleconn, sql)

dbDisconnect(oracleconn)

head(addr)





# ex14) MariaDB의 bigdata 데이터베이스의 
# Books, Customers, Orders 테이블을 이용해서 박지성 고객의 
# 주문 내역을 모두 조회해서 데이터프레임으로 만드는 R 코드를 작성하세요

library('rJava')
library('RJDBC')
library('DBI')


OJDBC <- JDBC(driverClass= 'oracle.jdbc.OracleDriver', 
              classPath= 'c:/Java/ojdbc8.jar')

oracleconn <- dbConnect(OJDBC, 'jdbc:oracle:thin:@//54.180.159.88:1521/xe',
                        'bigdata', 'bigdata0220')

sql <- "select * from CUSTOMERS join ORDERS using (CUSTID) 
          join ORDERS using (BOOKID) where NAME like '박지성' "

bco <- dbGetQuery(oracleconn, sql)

dbDisconnect(oracleconn)

head(bco)

bco





# 선생님 풀이

library('RMySQL')

sessionInfo()
# 윈도우(= R) 인코딩 : win949 / cp949 => euc-kr 확장판

mysqlconn <- dbConnect(MySQL(), user='bigdata', password='bigdata0220', 
                       dbname='bigdata', host='52.79.242.106')

dbSendQuery(mysqlconn, 'SET NAMES euckr;')
# db 클라이언트 인코딩 : utf-8
# 따라서, 윈도우(= R) 인코딩과 디비 클라이언트 인코딩을 일치시켜야 
# 질의문에 한글조건 검색 가능


sql <- "select name, order_id, book_name, saleprice 
        from Customers c join Orders o using (cu_id) 
        join Books using (book_id) where name = '박지성' "

result <- dbGetQuery(mysqlconn, sql)

dbDisconnect(mysqlconn)

# result[[1]] <- iconv(result[[1]], from='UTF-8')
# result[[3]] <- iconv(result[[3]], from='UTF-8')
# db 클라이언트 인코딩을 euc-kr 로 설정하는 경우에는 변환과정 불필요


head(result)








# ex15) HR 데이터베이스를 이용해서 직책이 
# 'FI_ACCOUNT'인 사원들의 성, 이름과 부서명, 급여를 조회해서
# 데이터프레임으로 만드는 R 코드를 작성하세요

library('rJava')
library('RJDBC')
library('DBI')

jhenv = 'c:/Java/jdk1.8.0_202'
Sys.setenv(JAVA_HOME=jhenv)
# JAVA_HOME 환경변수 등록


OJDBC <- JDBC(driverClass= 'oracle.jdbc.OracleDriver', classPath= 'c:/Java/ojdbc8.jar')

oracleconn <- dbConnect(OJDBC, 'jdbc:oracle:thin:@//54.180.159.88:1521/xe', 'hr', 'hr')

sql <- "select last_name, first_name, department_name, salary, job_id from 
        EMPLOYEES e join DEPARTMENTS d using (department_id) 
        where JOB_ID = 'FI_ACCOUNT' "

emp <- dbGetQuery(oracleconn, sql)

dbDisconnect(oracleconn)

head(emp)




