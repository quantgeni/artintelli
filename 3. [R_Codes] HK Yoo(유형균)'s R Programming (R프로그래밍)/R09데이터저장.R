### 작업 / 분석한 데이터를 외부데이터로 저장하기

# 텍스트, csv, 엑셀 데이터를 R 로 읽어와서 데이터분석을 위해 
# 전처리작업(추출/생성/수정/삭제)을 시행함

# 이러한 작업이 한번에 끝나지 않는 경우 
# 중간 작업 결과를 저장해둬야 할 필요 존재

# 다른 분석가와 함께 작업시 생성한 변수나 모든 종류의 R 객체를 
# 서로 공유하려면 어떤 형태의 파일로 저장해두는 것이 좋음
# 또한 운영체제에 상관없이 공유 가능해야 함






## RData 를 이용한 데이터 저장

# 저장시 save() 함수 이용
# 불러올때는 load() 함수 사용



# 성적데이터를 RData 로 저장해 봄

url <- 'c:/Java/data4.csv'

sj <- read.csv(url, header=T)
sj


# save(대상,..., file=위치/파일명)
# 텍스트 데이터에 대한 직렬화 수행
# 텍스트 데이터를 바이너리 파일로 변환

save(sj, file='c:/Java/data/sj.rdata')

rm(sj)   # R 객체 제거

sj   # 오류발생 (Error: object 'sj' not found)


# load(위치/파일명)
# 바이너리 데이터에 대한 역직렬화 수행
# 바이너리 파일을 텍스트 데이터로 변환

load('c:/Java/data/sj.rdata')
sj


# 여러 객체를 파일로 저장

sj2 <- c('사나', 87, 56, 23)
sj2

save(sj, sj2, file='c:/Java/data/sj2.rdata')

rm(sj, sj2)
sj
sj2

load('c:/Java/data/sj2.rdata')
sj
sj2







# ex16) employees 와 departments 테이블을 join 한 결과를 
#       empdept.rdata로 저장하세요

library('rJava')
library('RJDBC')
library('DBI')

jhenv = 'c:/Java/jdk1.8.0_202'
Sys.setenv(JAVA_HOME=jhenv)
# JAVA_HOME 환경변수 등록


OJDBC <- JDBC(driverClass= 'oracle.jdbc.OracleDriver', classPath= 'c:/Java/ojdbc8.jar')

oracleconn <- dbConnect(OJDBC, 'jdbc:oracle:thin:@//54.180.159.88:1521/xe', 'hr', 'hr')

sql <- "select * from EMPLOYEES e join DEPARTMENTS d using (department_id)"


hr <- dbGetQuery(oracleconn, sql)

dbDisconnect(oracleconn)


head(hr)


# join 결과를 rdata 로 저장

getwd()   # 현재 작업디렉토리 경로 출력

setwd('c:/Java/data')   # 작업디렉토리 변경

save(hr, file='empdept.rdata')

hr


# 데이터 불러오기 

setwd('c:/Java/data')
load('empdept.rdata')
hr










## R 데이터를 외부데이터로 저장


# R 데이터 -> 텍스트파일로 저장
# write.table(데이터명, 파일명, 구분자)

# emp/dept 테이블을 조인한 결과를 탭구분자를이용해서 empdept.txt 로 저장

setwd('c:/Java/data')
write.table(hr, file='empdept.txt', sep='\t', col.names=NA , quote=F, row.names=F)
# sep='\t' : 각 컬럼을 구분하는 기준은 탭
# quote=F : 따옴표 사용 안함
# col.names=NA : 컬럼명(헤더) 사용 안함 
# row.names=F : 행 이름 사용 안함




# R 데이터 -> csv파일로 저장
# write.csv(데이터명, 파일명)

# emp/dept 테이블을 조인한 결과를 탭구분자를이용해서 empdept.csv 로 저장

setwd('c:/Java/data')
write.csv(hr, 'empdept.csv', quote=T, row.names=F)





# R 데이터 -> excel파일로 저장
# openxlsx 패키지의 write.xlsx 함수 사용
# write.xlsx(데이터명, 파일명)

# emp/dept 테이블을 조인한 결과를 탭구분자를이용해서 empdept.xlsx 로 저장

install.packages('openxlsx')
library('openxlsx')

setwd('c:/Java/data')
write.xlsx(hr, 'empdept.xlsx')




# 생성한 모든 R 객체를 조회
# environment 레이아웃 확인
# ls 함수를 이용

ls()


# 불필요한 R 객체를 삭제
# rm 함수를 이용
# rm(대상), rm(대상1, 대상2, 대상3...)

rm(hr)


# R 객체를 모두 삭제

rm(list=ls())








# ex17) R 내장 데이터셋 중 iris 데이터셋을 
# iris.txt, iris.csv, iris.xlsx 로 저장하세요

data()   # 패키지별 데이터셋 확인
iris
?iris


setwd('c:/Java/data')
write.table(iris, file='iris.txt', sep='\t', quote=F, row.names=F, col.names=F)


setwd('c:/Java/data')
write.csv(iris, 'iris.csv', quote=T, row.names=F, fileEncoding='UTF-8')



library('openxlsx')

setwd('c:/Java/data')
write.xlsx(iris, 'iris.xlsx')





# ex18) Books, Customers Orders 테이블을 join 하고
# 그 결과를 bookstore.rdata, bookstore.txt, bookstore.csv, bookstore.xlsx 로 저장

library('rJava')
library('RJDBC')
library('DBI')

jhenv = 'c:/Java/jdk1.8.0_202'
Sys.setenv(JAVA_HOME=jhenv)
# JAVA_HOME 환경변수 등록


OJDBC <- JDBC(driverClass= 'oracle.jdbc.OracleDriver', classPath= 'c:/Java/ojdbc8.jar')

oracleconn <- dbConnect(OJDBC, 'jdbc:oracle:thin:@//54.180.159.88:1521/xe', 
                        'bigdata', 'bigdata0220')

sql <- "select * from CUSTOMERS c join ORDERS o using (CUSTID) 
        join BOOKS b using (BOOKID)"


bookstore <- dbGetQuery(oracleconn, sql)

dbDisconnect(oracleconn)


head(bookstore)




# rdata 저장

setwd('c:/Java/data')
save(bookstore, file='bookstore.rdata')


# 텍스트파일 저장

write.table(bookstore, 'bookstore.txt', sep='\t', row.names=F, col.names=F, quote=F)


# csv 저장

write.csv(bookstore, 'bookstore.csv', row.names=F, quote=F,fileEncoding='UTF-8')


# xlsx 저장

library('openxlsx')

write.xlsx(bookstore, 'bookstore.xlsx')





















































