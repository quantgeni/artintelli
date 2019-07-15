### 데이터 조회/보기

# 예제 데이터셋(diamonds) 관련 패키지 설치
install.packages('ggplot2')
library(ggplot2)
?ggplot2

diamonds   # tibble 형 객체


# 전체 데이터 조회
# 객체명을 직접 이용하거나 View() 함수를 이용

diamonds   # 단, 10000행만 출력력

View(diamonds)   # 모두출력, 정렬가능, 필터기능 가능(조건검색)


# 일부 데이터 조회

head(diamonds)
tail(diamonds)



# 데이터 조건에 따라 추출하기
# 원하는 형태로 데이터를 가공 - 데이터 전처리
# 객체의 각 원소에 추출하는 방법은 객체 인덱싱을 이용하거나
# 전처리 전문 패키지인 dplyr를 이용

setwd('c:/Java/data')
examdata <- read.csv('examdata.csv', header=T)

View(examdata)



# 조건에 맞는 데이터만 추출
# 열추출 : 객체명[컬럼명/컬럼인덱스]
# 국어 성적 추출

examdata['kor']
examdata[,'kor']   # 추천! (열이름)
examdata[,3]       # 추천! (인덱스)


# 국어, 영어, 수학 성적 추출

examdata[,c('kor', 'eng', 'mat')]
examdata[,c(3, 4, 5)]
examdata[,3 : 5]



# class 가 1인 학생들의 성적 추출
# 간단한 조건식을 이용해서 데이터 추출
# 객체명[조건식,]

examdata$class == 1

examdata[examdata$class == 1,]


# class 가 3인 학생들의 성적 추출

examdata[examdata$class == 3,]


# class 가 1이 아닌 학생들의 성적 추출

examdata[examdata$class != 1,]


# 국어 점수가 50점이상 학생 추출

examdata[examdata$kor >= 50,]


# class 가 2 또는 4인 학생들의 성적 추출

examdata[examdata$class == 2 | examdata$class == 4,]


# 영어 점수가 70점이상, 수학점수가 85점 이상인 학생 추출

examdata[examdata$eng >= 70 & examdata$mat >= 85,]



# 데이터 추출시 반복적으로 작성해야 하는 객체명이 불편할 수 있음
# => attach 함수/ within 함수를 이용
# 데이터프레임의 각 컬럼을 직접 접근

attach(examdata)   # 직접접근할 객체명 정의

examdata[class == 1,]

detach(examdata)   # 정의한 객체명 해제



# class 가 3인 학생들의 국어 점수 출력

attach(examdata)   

examdata[class == 3, 'kor']

detach(examdata)   



# 국어 / 영어 / 수학 성적에 대한 총점/평균 을 구해서 
# tot, avg 라는 이름의 컬럼을 생성
# 새로운 컬럼을 추가 하려면 '객체명$컬럼명'

examdata$kor + examdata$eng + examdata$mat


attach(examdata)   

examdata$tot <- as.character(examdata$kor + eng + mat)

examdata$avg <- as.character(examdata$kor + eng + mat / 3)

detach(examdata)   

View(examdata)




attach(examdata)   

examdata$tot <- kor + eng + mat

examdata$avg <- tot / 3

detach(examdata)   

View(examdata)



# within(객체, { 관련명령어 })

setwd('c:/Java/data')
examdata <- read.csv('examdata.csv', header=T)


examdata <- within(examdata, { tot <- kor + eng + mat;  avg <- tot / 3; })

examdata

save(examdata, file='examdata.rdata')



# 국어 / 영어 / 수학 성적에 대한 총점/평균 을 기준으로 
# 학점grd이라는 이름의 컬럼을 생성
# 학점은 '수/우/미/양/가' 로 평가함

# examdata$grd <- 수   =< 이렇게 할경우 모든 행에 '수' 지정


setwd('c:/Java/data')
examdata <- read.csv('examdata.csv', header=T)

examdata <- within(examdata, { tot <- kor + eng + mat;  avg <- tot / 3; })

# examdata$grd[examdata$avg >= 90] <- '수'
# examdata$grd[examdata$avg >= 80] <- '우'
# examdata$grd[examdata$avg >= 70] <- '미'
# examdata$grd[examdata$avg >= 60] <- '양'
# examdata$grd[examdata$avg >= 50] <- '가'


examdata$grd[ examdata$avg <  60 ] <- '가'
examdata$grd[ examdata$avg >= 60 ] <- '양'
examdata$grd[ examdata$avg >= 70 ] <- '미'
examdata$grd[ examdata$avg >= 80 ] <- '우'
examdata$grd[ examdata$avg >= 90 ] <- '수'


examdata



# within 으로 재작성

setwd('c:/Java/data')
examdata <- read.csv('examdata.csv', header=T)

examdata <- within(examdata, { tot <- kor + eng + mat;  avg <- tot / 3; })


# examdata$grd <- '-'   # 성적 초기화

within(examdata, { 
  grd[avg <  60] <- '가'
  grd[avg >= 60] <- '양'
  grd[avg >= 70] <- '미'
  grd[avg >= 80] <- '우'
  grd[avg >= 90] <- '수'
})






# 데이터 정렬하기

# 벡터정렬 : sort()

v1 <- c(40, 30, 50, 50, 90, 40, 50)
v1

sort(v1)   # 오름차순
sort(v1, decreasing=T)   # 내림차순





# 데이터프레임 정렬 : order()

v2 <- c(5100, 6500, 2000, 2000, 9000, 4500, 3000)

v3 <- c('a', 'b', 'a', 'b', 'a', 'a', 'b')

df <- data.frame(v1, v2, v3)
df


# v1은 오름차순

order(v1)        # 각 행의 인덱스가 출력
df[order(v1),]   # 


# v1은 오름차순, v2는 내림차순

order(v1, -v2)
df[order(v1, -v2),]


# v1, v3은 오름차순, v2는 내림차순

df[order(v1, -v2, v3),]


# v3은 오름차순, v1, v2는 내림차순

df[order(v3, -v1, -v2),]






# 집계하기 : aggregate()
# aggregate(객체, by=기분컬럼, FUN=집계함수)
# => SQL 의 group by 절과 유사

# class 별 최고/최소 평균 점수 추출

aggregate(examdata[,6], by=list(examdata$class), FUN=max)

aggregate(examdata[,6], by=list(examdata$class), FUN=min)

aggregate(examdata[,6], by=list(class=examdata$class), FUN=min)


# 집계 대상을 모든 컬럼으로 하면?

aggregate(examdata, by=list(examdata$class), FUN=max)


# class 별 총 평균점수 추출

aggregate(examdata[,-c(1,8)], by=list(examdata$class), FUN=mean)
# => 연산 안되는 id 와 grd 는 빼고 연산
#    평균을 구할 수 없는 컬럼은 제외해야 함







# ex19) leadership 데이터를 이용해서 다음의 과제를 수행하시오

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

leadership <- data.frame(manager, date, country, gender, age, q1, q2, q3, q4, q5)

leadership


setwd('c:/Java/data')
save(leadership, file='leadership.rdata')



# a. 설문문항 q1 ~ q5 의 총합과 평균을 구해서
# sumq, meanq 라는 컬럼을 생성

leadership$sumq <- leadership$q1 + leadership$q2 + leadership$q3 
+ leadership$q4 + leadership$q5
# => 참고 : 4행의 q4, q5 의 값이 NA임(결측치)
# 결측치가 포함된 행에 산술연산을 적용하면 결과 역시 NA로 출력
# 결측치 처리방법 : 제거, 대체

leadership$meanq <- leadership$sumq / 5


#############################################################

load('leadership.rdata')

within(leadership, { sumq <- q1 + q2 + q3 + q4 + q5; meanq <- sumq /5 })




# b. 나이를 대상으로 ageGroup 이라는 컬럼을 만들고 
# 다음 조건에 따라 초년(<30), 중년(<75), 노년(>=75) 중 하나를 저장하시오

leadership$ageGroup[+
                      leadership$age  < 30] <- '초년'
leadership$ageGroup[+
                      leadership$age >= 30] <- '중년'
leadership$ageGroup[+
                      leadership$age >= 75] <- '노년'

leadership

######################################################

load('leadership.rdata')
leadership$ageGroup <- ''   # 컬럼 추가
within(leadership, { ageGroup[ age < 30]  <- '초년'
                     ageGroup[ age >= 30] <- '중년'
                     ageGroup[ age >= 75] <- '노년'})

leadership


# ex20) mtcars 데이터셋을 이용해서 
# 연비 mpg를 기준으로 내림차순 정렬해서 출력

mtcars
?mtcars


mtcars[ order(-mtcars$mpg),]




# ex21) iris 데이터셋을 이용해서 품종별 붓꽃(Sepal) 
# 너비와 길이에 대해 최대값과 최소값을 출력하세요

iris
?iris
str(iris)

aggregate(iris[,1:2], by=list(iris$Species), FUN=max)

aggregate(iris[,1:2], by=list(species=iris$Species), FUN=max)

aggregate(iris[,1:2], by=list(품종=iris$Species), FUN=max)

aggregate(iris[,1:2], by=list(품종=iris$Species), FUN=min)

# aggregate(iris[,1:2], by=list(품종=iris$Species), FUN=c(max,min))
# => aggregate 자체만으로는 함수(FUN)에 두가지를 쓸 수 없음


library(plyr)   # each 라는 helper 함수를 사용하기 위해 관련 패키지를 불러옴
aggregate(iris[,1:2], by=list(품종=iris$Species), FUN=each(max,min))




# 기존 방식으로 데이터 전처리시 코드가 필요이상으로 길어지는 단점과
# 처리 데이터의 규모에 따라 속도가 다소 느려진다는 문제 발생
# => plyr, dplyr, data.table 등을 이용


