## factor

# 범주형 데이터를 표현하기 위한 자료형
# factor() 함수를 이용해서 범주형 변수 생성

# 범주형 category : 데이터의 값이 일정한 범위내에 존재
#                   즉, 특정값으로만 분류됨
# ex) 성별 : 남/여, M/F, male/female

gender <- c('M', 'F', 'F', 'M', 'F')
gender

gender2 <- factor(gender)
gender2
# levels : 범주형 변수가 가질 수 있는 값의 목록 (M / F)

levels(gender2)  
# => 알파벳 순서대로 정렬되어 출력
# 범주형 변수가 가질수 있는 값의 종류는 모두 2개

as.numeric(gender2)
# 번주형 변수를 숫자형으로 바꾸면 정의된 순서대로 서수가 부여됨


gender3 <- factor(gender, levels=c('M', 'F'), labels=c('남','여'))
gender3
# 일반적으로 벡터의 원소값이 범주형값으로 지정
# 만일 다른 문자형값을 범주형값으로 변경하고 싶다면 labels 속성을 이용



# 학점데이터를 벡터로 정의
# 'a', 'b', 'c', 'd', 'f' 등을 '수','우','미','양','가' 로 변경해서
# 범주형 변수로 작성하세요

grades <- c('a', 'c', 'b', 'b', 'f')

grades2 <- factor(grades)

grades2

# grades3 <- factor(grades, labels=c('수', '우', '미', '양', '가')) => 오류!!
# 범주형 값 목록수와 레이블 목록수가 일치하지 않으면 오류 발생!!

grades3 <- factor(grades, labels=c('수', '우', '미', '가'))

grades3



# 취미 hobby를 범주형변수를 정의
# '게임', '여행', '운동', '독서', '운동', '여행'
# 또한, 범주형 값 목록을 숫자형으로도 출력

hobby <- c('게임', '여행', '운동', '독서', '운동', '여행')

hobby2 <- factor(hobby)

hobby2

levels(hobby2)
as.numeric(hobby2)

hobby3 <- factor(hobby, labels=c('a', 'b', 'c', 'd'))

hobby3






### 행렬 matrix

# 벡터의 2차원 배열
# 데이터가 행과 열로 구성된 경우 행렬로 표현 가능
# 단, 동일한 유형의 데이터로 구성되어야 함
# 주로 선형대수에 많이 사용


# 행렬을 생성하는 함수
# rbind(), cbind(), matrix()


## 단순 행렬 생성 : matrix
# nrow : 행의 갯수
# ncol : 열의 갯수
# byrow : 행 우선으로 값이 저장되도록 함

mx <- matrix(1:10)    # 열 우선으로 행렬 생성
mx


# 2x5 행렬 생성 : 12345 678910
# 행우선으로 행렬 생성

mx2 <- matrix(1:10, nrow=2)   # 열 우선
mx2

mx3 <- matrix(1:10, nrow=2, byrow=T)   # 행 우선 
mx3


# 5x2 행렬 생성 12 34 56 78 910

mx4 <- matrix(1:10, nrow=5, byrow=T)
mx4

mx5 <- matrix(1:10, ncol=2, byrow=T)
mx5


# 3x3 행렬 132 456 798

mx6 <- matrix(1:9, nrow=3, byrow=T)
mx6

mx7 <- matrix(1:9, ncol=3, byrow=T)
mx7


# 행렬크기랑 데이터수가 다를때
# 3x3 행렬, 데이터 7개의 데이터를 이용

mx8 <- matrix(1:7, nrow=3, byrow=T)
mx8
# => 재사용규칙 : 모자라는 데이터는 기존 데이터를 다시 활용




## 2개의 벡터를 이용해서 행렬 생성
# rbind() : 2개의 벡터를 행을 기준으로 합침
# cbind() : 2개의 벡터를 열을 기준으로 합침
# rbind 의 경우, 벡터의 갯수가 행렬의 행의 갯수로 결정
# cbind 의 경우, 벡터의 갯수가 행렬의 열의 갯수로 결정


x <- c(1:5)
y <- c(6:10)
z <- c('가', '나', '다', '라', '마')

a <- rbind(x, y)    # 2x5 행렬
a
mode(a)


b <- cbind(x, y)    # 5x2 행렬
b

mode(a)

c <- rbind(x, y, z)   # 3x5 행렬
c
mode(c)
# 벡터형 처럼 혼합형 데이터는 모두 문자형으로 변환

d <- cbind(x, y, z)   # 5x3 행렬
d
mode(d)



# 행렬의 각 원소에 접근하기

x <- c(1:5)
y <- c(6:10)
z <- c('가', '나', '다', '라', '마')

a <- rbind(x, y)

# 1행 전체 출력 : 객체명[행번호,]

a[,1] 


# 1열 전체 출력 : 객체명[,열번호]

a[1,]


# 2행 3열의 원소 출력 : 객체명[행번호,열번호]

a[2,3]


# 1행 2열/3열/4열/5열 출력 

a[1, c(2,3,4,5)]
a[1, c(2:5)]


# 1행/2행 5열 출력 

a[c(1,2), 5]



# 행렬의 크기

nrow(a)     # 행의 갯수
ncol(a)     # 열의 갯수
dim(a)      # 행/열 갯수
length(a)   # 원소의 갯수



# 행렬간 연산

x <- matrix(1:12, nrow=3)
y <- matrix(13:24, nrow=3)


x + y
x * y
x == y



# 행렬에 행/열 에 이름 부여
# rownames(객체명) <- c(이름목록)   # 행 이름 부여
# colnames(객체명) <- c(이름목록)   # 열 이름 부여

colnames(a) <- c('one', 'two', 'three', 'four', 'five')
a

a[,'one']
a[,c('two', 'four', 'five')]


rownames(a) <- c('1행', '2행')
a

a['1행',]
a['2행', c('three', 'five')]




# 행렬 생성시 행/열 이름 지정
# dimnames=list(c(), c())
#                행, 열

e <- matrix(1:4, nrow=2, dimnames=list(c('a', 'b'), c('x', 'y')))
e





# ex4) 예제
# ex1), ex2), ex3) 에서 생성한 벡터를 이용해서 행열을 각각 작성하세요

# 변수명이 컬럼기준으로 출력 되는것이 좋음

# ex1)

age <- c(01, 03, 05, 02, 11, 09, 03, 09, 12, 03)
weight <- c(4.4, 5.3, 7.2, 5.2, 8.5, 7.3, 6.0, 10.4, 10.2, 6.1)

baby <- cbind(age, weight)
baby



# ex2)

patientID <- c(1, 2, 3, 4)
AdmDate <- c('10/15/2014', '11/01/2014', '10/21/2014', '10/28/2014')
age <- c(25, 34, 28, 52)
diabetes <- c('type1', 'type2', 'type3', 'type4')
status <- c('poor', 'improved', 'excellent', 'poor')

hospital <- cbind(patientID, AdmDate, age, diabetes, status)
hospital



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

leadership <- cbind(manager, date, country, gender, age, q1, q2, q3, q4, q5)
leadership

ncol(c)     # 열의 갯수
dim(c)      # 행/열 갯수
length(c)
