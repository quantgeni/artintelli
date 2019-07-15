# 기본적으로 테이블 확인 => str, summary(기술통계), table!! 3개 외울 것

# 통계학 종류

# 1. 기술descriptive 통계학
# 자료를 중심으로 통계수치, 표, 그래프를 이용해서 집단 특성 파악
# (위치: 평균 / 분포: 흩어짐 경향)

# 2. 추론referential 통계학
# 관측된 자료 중에서 표본을 이용해서 모집단 특성 파악
# 기본적으로 확률이론을 바탕
# 모수통계(모집단 분포 가정)와 비모수통계(모집단 분포 가정 없음)로 나뉨

#통계에서 사용하는 데이터 유형
#질적qualitative 변수 - 문자형태 자료
#     > 명목 척도 - 범주형 데이터 (M&M 초콜릿 색상)
#     > 서열 척도 - 순서형 데이터 (연예인 인기순위)
#양적quantitative 변수 - 숫자형태 자료
#     등간 척도 - 범주+정수 데이터 (옷 치수)
#     비율 척도 - 실수데이터 (시간대별 방문자 수)
#     > 이산discrete형 변수 - 정수 데이터
#     > 연속continuous형 변수 - 실수 데이터

#명독척도예시
#지금관심있는 IT관련기술은?

#서열척도 예시
#당신이 판단할 때 본인이 속한 계층은?
#1) 상류 2) 중산 3) 하류 4) 보호대상자

#등간척도 예시 (본 등간 => 서열을 포함하고 있음)
#당신이 판단할 때 본인의 IT 실력은?
#1) 최상 2) 좋음 3) 보통 4) 다소 부족 5) 형편없음

#비율척도 예시
#가장 높은 수준 척도. 가장 자세한 정보 제공. 서로 구분, 크기 구분, 크기 비교,
#크기 차이, 특성들 간 계산 가능 등 이 모든 것이 숫자료 표현 가능
#당신이 가진  IT 관련 자격증 수는? (없으면 0)

setwd('c:/Java/data')
data <- read.csv('descriptive.csv', header=T)
save(data,file='c:/Java/data/descriptive.rdata')
rm(data)
load('c:/Java/data/descriptive.rdata')
data
str(data) #8개 변수, 300개 관측치

#명목척도 : 범주형 => gender 성별
#1 남자 2 여자

summary(data$gender) #기술통계 확인 => 의미없음 (명목척도이니)

#표로 확인 => 남/여 비율 확인
table(data$gender) #0, 5가 보임 => 이상치

data$gender[data$gender==1 | data$gender==2] #컴마를 안 씀 -_-;;
#칼럼 단 이라면 그런 듯-_-;;

subset(data$gender,data$gender==1 | data$gender==2)

gender <- data$gender[data$gender==1 | data$gender==2]
table(gender)

#그래프로 확인 => 남/여 비율 확인
x <- table(gender) #table() 먼저 쳐주는거 확인!!
barplot(x)


library(sqldf)
gender2 <- sqldf('select gender from data where gender in (1,2)')
table(gender2)

#빈도 별 비율 계산 : prop.table
prop.table(x)
y <- prop.table(x)
round(y * 100) #백분율 환산
round(y * 100,1)
round(y * 100,2)

#서열척도 : 범주형 + 순서 => level 학력수준
#1 고졸 2 대졸 3 대학원졸
data$level
summary(data$level) #의미 없음

#표로 확인
sqldf("select level from data where level <> 'NA'")
level <- data$level[!is.na(data$level)]
x <- table(data$level)
x
y <- prop.table(x)
round(y*100, 2)

#그래프

#빈도 별 비율 계산
prop.table()

#ex28) descriptive 데이터셋의 pass 변수는 합격여부에 대한 자료.
#pass 1 합격 2 불합격일때 기술 통계 실시
#기술통계 => 의미 없음
#표로 확인 => 합격 불합격 비율 확인 table() 함수

setwd('c:/Java/data')
descriptive <- read.csv('descriptive.csv', header=T)
save(descriptive,file='c:/Java/data/descriptive.rdata')
load('c:/Java/data/descriptive.rdata')
descriptive

pass <- sqldf("select pass from descriptive where pass<>'NA'")
table(pass)
x <- table(pass)
barplot(x)      #barplot() vs. prop.table()
prop.table(x)
y <- prop.table(x)
round(y*100,1)


#ex29) titanic 데이터셋 이용, 명목/서열 척도 구분. 기술통계 실시
#명목척도: 생존여부, 성별, 승선위치(애매하긴 하지만)
#서열척도: 승선권등급(Pclass), 위 승선위치도 어찌보면 서열척도

setwd('c:/Java/data')
load('titanic.rdata')
titanic

str(titanic)
summary(titanic)
table(titanic)

#승선권등급(서열척도)
head(titanic,n=2)
pclass <- sqldf("select Pclass from titanic where Pclass<>'NA'")
pclass
table(pclass)
x1 <- table(pclass)
barplot(x1)
y <- prop.table(x1)
round(y*100,1)

#생존여부(명목척도)
x2 <- table(titanic$Survived)
barplot(x2)
y <- prop.table(x2)
round(y*100,2)
barplot(y)

#승선위치(명목척도)
x3 <- table(titanic$Embarked)
barplot(x3)
y <- prop.table(x3)
round(y*100,2)
barplot(y)

#---------------------------- 양적변수
#등간척도: 범주형+정수형 => survey 설문
#만족도 1 2 3 4 5

#기술통계 확인 => 의미없음
setwd('c:/Java/data')
load('descriptive.rdata')
summary(data$survey)


#표로 확인
table(data$survey)

#그래프로 확인
x <- table(data$survey)
barplot(x)
hist(data$survey, breaks=6) #-_-a...? 이상하게 나옴

#====> NA가 너무 많아서 통계적 유의성은 없음 (평균/중앙값 등으로
#대체해야..)

#빈도 별 비율 확인
x <- table(data$survey)
y <- prop.table(x)
round(y*100,1)

#비율척도 : 정수형 => cost 비용

#기술통계확인
cost <- data$cost[!is.na(data$cost)]
cost

summary(cost) #이상치 포함 => 결과 왜곡

range(cost)

cost2 <- cost[cost >= 0 & cost <= 10]
# 범위를 0 ~ 10 로 줄임 (이상치제거)

range(cost2)

summary(cost2)   # 최소 2, 최대 8


# 표로 확인 => 등간척도로 변환해야 함

cost3 <- cost2

cost3[cost3 >= 2 & cost3 < 3] <- '2-'
cost3[cost3 >= 3 & cost3 < 4] <- '3-'
cost3[cost3 >= 4 & cost3 < 5] <- '4-'
cost3[cost3 >= 5 & cost3 < 6] <- '5-'
cost3[cost3 >= 6 & cost3 < 7] <- '6-'
cost3[cost3 >= 7 & cost3 < 8] <- '7-'
cost3[cost3 >= 8 & cost3 < 9] <- '8-'

table(cost3)


# 빈도 비율 확인 => 

x <- table(cost3)
y <- prop.table(x)
round(y * 100, 1)


#그래프로 확인 : 산점도, 상자수염 
plot(cost)
boxplot(cost)

plot(cost2)
boxplot(cost2)

barplot(cost2)   
# 연속형 변수 이므로 값이 빽빽하게 출력
# 따라서, 등간척도로 변환해야 함

hist(cost2)

barplot(x)






# ex30) describtive 데이터셋의 age 컬럼에 대해 기술통계를 실시하시오

data$age

# 기술통계

summary(data$age)


# 표로 확인 => 등간척도로 변환해야 함

age2 <- data$age

age2[age2 >= 40 & age2 < 50] <- '40-'
age2[age2 >= 50 & age2 < 60] <- '50-'
age2[age2 >= 60 & age2 < 70] <- '60-'

table(age2)


##################################################


age3 <- data$age
# 45이하(중년), 59이하(장년), 60이상(노년)

age3[age3 <= 45] <- '중년층'
age3[age3 > 45 & age3 < 60] <- '장년층'
age3[age3 >= 60 & age3 < 80] <- '노년층'

table(age3)


# 빈도 비율 확인

y <- prop.table(table(age2))
round(y * 100, 1)


y <- prop.table(table(age3))
round(y * 100, 1)


# 그래프로 확인

plot(data$age)

boxplot(data$age)

barplot(table(age2))
barplot(table(age3))

hist(data$age)


pie(prop.table(table(age2)))
pie(prop.table(table(age3)))





# ex31) iris 데이터셋을 이용해서 기술통계를 실시하시오

str(iris)


# 명목척도
s <- iris$Species


# 표/비율/그래프로 확인
table(s)

y <- prop.table(table(s))
round(y * 100, 1)


barplot(table(s))

pie(y)



# 비율척도
i <- iris[,-5]


# 통계/표/비율/그래프로 확인
summary(i)


sl <- i$Sepal.Length

sl[sl >= 4 & sl < 5] <- '4-'
sl[sl >= 5 & sl < 6] <- '5-'
sl[sl >= 6 & sl < 7] <- '6-'
sl[sl >= 7 & sl < 8] <- '7-'
sl[sl >= 8 & sl < 9] <- '8-'

table(sl)


y <- prop.table(table(sl))
round(y * 100, 1)


plot(i$Sepal.Length)

plot(i)   # 산점도 행렬

boxplot(i$Sepal.Length)

barplot(table(sl))

pie(y)
pie(round(y * 100, 1))







# ex30) titanic 데이터셋을 이용해서 등간척도와 비율척도를 구분하고
# 기술통계를 실시하시오







# ex31) Employees 데이터셋을 이용해서 기술통계를 실시하시오











