## 리스트

# 다양한 종류의 데이터형으로 구성된 데이터를 원소로 가질 수 있는 자료구조
# 기본 자료형 외에 벡터/행렬/리스트/데이터프레임 까지도 원소로 가질 수 있음

# 메모리 영역에는 키 와 값 형태로 저장
# => 파이썬의 dict 와 유사
# 키를 통해 값을 불러올 수 있음 


# 리스트는 list() 을 이용해서 생성

sj <- c('혜교', 99, 77)
sj
# 모두 문자로 변환

sj <- list('혜교', 99, 77)
sj
# 각 원소의 자료형이 그대로 유지

mode(sj)


v1 <- 1:5
v1
m1 <- matrix(1:6, nrow=2, ncol=3)
f1 <- factor(c('T', 'T', 'F', 'F', 'T'))

l1 <- list(v1, m1, f1) 
l1




# 리스트원소에 접근
# [] : 지정한 위치값의 키와 데이터를 출력
# [[]] : 지정한 위치값의 키에 대한 데이터를 출력
# 리스트 생성시 키를 따로 지정하지 않으면 숫자형태의 키가 자동 생성

sj[1]     # 이름 : 값과 키가 같이 출력
sj[3]     # 영어점수
sj[[1]]   # 이름 : 키에 대한 값이 출력
sj[[3]]   # 영어점수

l1[1]
l1[2]
l1[3]

l1[[1]]
l1[[2]]

l1[[1]][3]     # 첫번째 요소의 3번째 값
l1[[2]][1,]    # 두번째 요소의 1번째 행 
l1[[2]][2,3]   # 두번째 요소의 2행3열


# 키와 값 형식으로 리스트 객체 생성
# list(키=값, ... ...)

sj <- list(name='혜교', kor=99, eng=93, mat=77)
sj

sj$name   # sj[['name]]
sj$kor
sj$eng
sj$mat


l2 <- list(v1=v1, m1=m1, f1=f1)

l2$v1
l2$m1
l2$f1

l2$.v1[c(3,5)]   # l2[[v1]][c(3,5)]
l2$m1[2,]




# 리스트의 원소 수정/제거

sj$name <- '수지'

sj$mat <- NULL



# 리스트 크기 알아보기 

length(sj)   # 원소 갯수 출력
length(l1)        



# list 를 다루는 주된 함수는 
# unlist(), lapply(), sapply() 등이 있음

# unlist() : 리스트를 벡터로 변환하는 함수

sj
sj <- unlist(sj)
sj






## 데이터프레임 dataframe

# R의 대표적인 자료구조
# 2차원 구조로 행/열로 구성

# 행렬과 달리 여러가지 자료형으로 구성된 데이터를 원소로 가질 수 있음
# 일반적으로 데이터분석시 데이터들은 데이터프레임으로 구성해야 함

# 데이터베이스의 테이블과 유사한 구조
# 컬럼단위로 서로 다른 유형의 데이터를 저장할 수 있음

# data.frame(), read.table(), read.csv()
# 등으로 데이터프레임 객체 생성


# 벡터로 데이터프레임 객체 생성

names <- c('혜교', '지현', '수지')
kor <- c(99, 98, 99)
eng <- c(55, 77, 95)
mat <- c(78, 56, 23)

sj <- data.frame(names, kor, eng, mat)
sj


# 데이터프레임 구조 알아보기
# str(객체명)

str(sj)
# 3 obs. of  4 variables
# 4개의 변수(열/컬럼)에 3개의 관측값(행)
# 문자형 데이터는 데이터프레임 생성시 
# 자동적으로 factor(범주형)으로 변경되기 때문에
# 이것을 막으려면 stringsAsFactors=FALSE 지정

sj <- data.frame(names, kor, eng, mat, stringsAsFactors=F)
str(sj)


# 범주형 변수를 문자형 변수로 변경하려면
# as.character() 함수를 사용

sj <- data.frame(names, kor, eng, mat)
str(sj)

sj$names <- as.character(sj$names)
str(sj)


# 데이터프레임 생성시 컬럼명을 지정

sj <- data.frame(이름=names, 국어=kor, 영어=eng, 수학=mat, stringsAsFactors=F)
sj



# 데이터프레임 다루기

sj <- data.frame(names, kor, eng, mat)
sj

sj$kor  # 국어/수학 점수만 출력
sj$mat  

sj[2]
sj[4]

sj[c(2,4)]   # 기본적으로 열우선 출력
sj[,c(2,4)]

sj[c(1,3),]  # 1, 3행 출력



# 기존 데이터프레임에 새로운 변수를 추가
# 기존 성적 데이터프레임에 학점 변수 추가
# 객체명$변수명 <- 벡터

grd <- c('우', '미', '수')

sj$grd <- as.factor(grd)
sj



# 데이터프레임 컬럼이름 바꾸기
# colnames(객체명) <- c()

colnames(sj) <- c('이름', '국어', '영어', '수학', '학점')

sj



# 데이터프레임의 부가기능
# 기술통계량 확인 : summary(객체명)
# => 최대/최소/중위수/평균/사분위수

summary(sj)



# 많은 행으로 구성된 데이터프레임 조회
# head(), tail()

numbers <- data.frame(x=1:10000)
numbers   # 최대 1000행까지만 출력 - 나머지 생략

head(numbers)   # 위에서 6행까지 출력
tail(numbers)   # 밑에서 6행까지 출력

head(numbers, n=10)   # 10행까지만 출력
tail(numbers, n=10)



# 행렬을 이용해서 데이터프레임으로 생성
# as.data.frame(행렬객체)

mx1 <- matrix(1:12, nrow=3)
mx1

df1 <- as.data.frame(mx1)
df1



# rbind/cbind/merge 함수를 이용해서 데이터프레임 생성
# 즉, 2개 이상의 데이터프레임을 결합해서 생성

df1 <- data.frame(name=c('혜교', '지현'), weight=c(159, 164))

df2 <- data.frame(name=c('수지', '현아'), weight=c(155, 175))

df3 <- rbind(df1, df2)   # 행기반
df3

df4 <- data.frame(age=c('35', '27'), height=c(55, 75))
df4

df5 <- cbind(df1, df4)   # 열기반
df5

df6 <- data.frame(name=c('혜교', '지현'), id=c(2, 1))
df6

df7 <- cbind(df5, df6)   # 중복 데이터 존재
df7

df7 <- merge(df5, df6, key='name')
df7
# 관계형 데이터베이스의 join 과 유사한 기능으로 두 데이터프레임을 합침






# ex5) 예제 
# ex1), ex2), ex3) 에서 생성한 벡터를 이용해서
# 데이터프레임으로 각각 작성하세요

# ex1)

age <- c(01, 03, 05, 02, 11, 09, 03, 09, 12, 03)
weight <- c(4.4, 5.3, 7.2, 5.2, 8.5, 7.3, 6.0, 10.4, 10.2, 6.1)

baby <- data.frame(개월수=age, 몸무게=weight, stringsAsFactors=F)
baby

summary(baby)



# ex2)

patientID <- c(1, 2, 3, 4)
AdmDate <- c('10/15/2014', '11/01/2014', '10/21/2014', '10/28/2014')
age <- c(25, 34, 28, 52)
diabetes <- c('type1', 'type2', 'type3', 'type4')
status <- c('poor', 'improved', 'excellent', 'poor')

hospital <- data.frame(patientID, AdmDate, age, diabetes, status)
hospital

str(hospital)

hospital$AdmDate <- as.character(hospital$AdmDate)

summary(hospital)



# ex3)

manager <- c(1, 2, 3, 4, 5)
date <- c('10/24/14', '10/28/14', '10/01/14', '10/12/14', '05/01/14')
country <- c('US', 'US', 'UK', 'UK', 'UK')
gender <- c('M', 'F', 'F', 'M', 'F')
age <- c(32, 45, 25, 39, 99)
q1 <- c(5, 3, 3, 3, 2)
q2 <- c(4, 5, 5, 3, 2)
q3 <- c(5, 2, 5, 4, 1) 
q4 <- c(5, 5, 5, NA, 2)
q5 <- c(5, 5, 2, NA, 1)

leadership <- data.frame(manager, date, country, gender, 
                         gender, age, q1, q2, q3, q4, q5)
leadership

str(leadership)

leadership$date <- as.character(leadership$date)

summary(leadership)


