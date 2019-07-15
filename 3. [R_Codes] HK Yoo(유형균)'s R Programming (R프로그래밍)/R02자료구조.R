### R 의 데이터형


## 기본데이터형 > 수치형, 문자형, 논리형

# 수치형 : 숫자로 구성
#          정수(integer), 실수(double)

a <- 132
b <- 3.141525

a   # print(a) 와 동일
b


# 문자형 : 문자로 구성
#         "" 또는 '' 로 묶여 있음

c <- 'Hello'
d <- "안녕하세요!"

c
d


# 논리형 : 참/거짓으로 구성
#          TRUE, T, FALSE, F 등으로 표현

e <- T
f <- F

e
f




## 특수데이터형 > NULL, NA, NaN

# NULL : 객체는 존재하지만 실제 값이 없는경우

g <- NULL
g


# NA : 객체와 값이 있지만 일시적으로 지정하지 않은 경우
#      결측지를 표현할 때 사용 

h <- NA
h


# NaN : 수학적 계산이 불가능한 경우

i <- sqrt(-3)  # 음수에 대한 제곱근 계산 불가능
i





## 데이터 유형 알아보기 : mode, is~

# mode(객체명) : 해당 객체의 데이터형을 출력

mode(a)   # 수치(정수/실수 => nimeric)
mode(c)   # 문자(character)
mode(e)   # 논리(logical)
mode(g)
mode(h)


# is.데이터형(객체명) : 해당 객체의 세부적인 데이터형을 출력
 
is.integer(a)   # FALSE 로 출력
is.numeric(a)
is.double(b)
is.character(c)
is.logical(e)
is.null(g)
is.na(h)


is.integer(1)
is.double(1)
# => 겉으로 보기에 정수로 선언했지만 R 기본적으로 실수로 인식

is.integer(1L)
# 따라서, 정수로 인식시키려면 해당 리터럴에 L이라는 접미사를 추가해줌




## 데이터유형의 우선순위

# 문자형 > (복소수형) > 수치형 > 논리형




## 데이터의 강제 형변환

# as~ 함수를 이용해서 형변환이 자유롭게 가능

j = 10

as.integer(j)
as.double(j)
as.numeric(j)
as.character(j)
as.logical(j)

k = "100"

as.numeric(k)







### R의 자료구조

## 스칼라 (scalar) : 변수에 한개의 값만 저장

name <- '혜교'
kor <- 35
eng <- 95
mat <- 84

tot <- kor + eng + mat 
avg <- tot / 3   

tot
avg


## 벡터 (vector) : 변수에 여러개의 동일한  데이터 유형의 값으로 저장
#                 c(), seq(), rep(), 함수를 사용해서 벡터를 생성
#                 일반적으로 하나의 변수(속성)을 정의할 때 
#                 사용하는 최소 단위

num10 <- c(1,2,3,4,5,6,7,8,9,10)
num10
# c : combine, concatenate의 약자

# 변수 선언시 '변수명.멤버' 형태로 선언 가능
sj.name <- '혜교'
sj.kor <- 98
sj.eng <- 97
sj.mat <- 78

sj.name2 <- '지현'
sj.name3 <- '수지'
# > 하나씩 지정하는게 번거러움


sj.names <- c('혜교', '지현', '수지')
sj.names
sj.kor <- c(98, 84, 35)
sj.kor

logics <- c(T, F, T, T)
logics


# 벡터에 서로 다른 유형의 자료를 정의

twotype1 <- c(1, 2, '3')
twotype2 <- c('1', '2', 3)
threetypes <- c(1, '2', T)
# => 벡터의 모든 요소의 자료형은 문자형으로 통일 


# 벡터의 인자를 값이 아닌 다른 벡터로 지정 가능

a <- c(1,2,3,4,5)
b <- c(6,7,8,9,10)
c <- c(a, b)
c


# :를 이용한 벡터 정의 
# '시작:끝' 형태로 사용
# 수치형 값 중 1씩 증가하거나 감소하는 규칙이 있을 때 사용

num10 <- c(1,2,3,4,5,6,7,8,9,10)
num10b <- c(1:10)
num10c <- c(10,9,8,7,6,5,4,3,2,1)
num10d <- c(10:1)


# '시작, 끝, 간격' 형태로 사용
# seq(from=시작, to=끝, by=간격)
# sequential 의 약자

odd10 <- c(1,3,5,7,9,11,13,15,17,19)
# odd10b <- seq(1, 19, 2)
odd10b <- seq(from=1, to=19, by=2)

even10 <- c(2,4,6,8,10,12,14,16,18,20)
even10b <- seq( 2, 20, 2)

wonder1 <- c(-3.5:1)
wonder2 <- c(5:-3.5)

wonder1b <- seq(-3.5, 0.5, 1)
wonder2b <- seq(5, -3.5, -1)


# sequence()
# 1 부터 지정한 숫자까지 정수형 벡터로 생성

num10e <- sequence(10)
num5 <- sequence(5.5)

sequence(-10)   # 음수지정불가


# 규칙성 있는 값을 벡터로 생성
# rep(x=대상, times=복사, each=반복)

rep1 <- rep(1, times=5)
rep2 <- rep(1, each=5)

rep3 <- rep(1:3, times=5)
rep4 <- rep(1:3, each=5)

rep5 <- rep(c('a','b','c'), times=3)
rep6 <- rep(c('a','b','c'), each=3)

rep7 <- rep(c('a','b','c'), times=3, each=3)
# => times, each 인수를 동시에 적용하면 
# each 가 먼저 적용된 후 times 가 적용

rep8 <- rep(c('a','b','c'), times=c(3,5,2))
# => a문자가 3번, b문자가 5번, c문자가 2번 출력


# ex) 다음 값들을 벡터로 정의하세요
# 33, -5, 20, 21, 22, 23, 12, -2, -1, 0, 1, 2, 3

nums <- c(33, -5, 20:23, 12, -2:3)


# 함수 도움말

help(c)
help(seq)



## 리스트
## 행렬
## 팩터
## 데이터프레임

