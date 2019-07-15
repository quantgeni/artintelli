# 결측치/이상치 다루기

# 실제 데이터들 중 오류를 포함할 가능성은 언제나 존재
# 따라서, 분석전 이러한 오류들은 바로 수정해야 함

# 결측치 missing value - NA
# 누락된 값, 비어있는 값
# 함수/수식 적용 불가 - 분석결과 왜곡
# 제거 또는 적절한 값으로 대체한 후 분석실시


setwd('d:/Java/data')
load('leadership.rdata')

leadership


# 결측지 확인 - is.na 함수
# FALSE : 결측치 아님
# TRUE : 결측치 맞음

is.na(leadership)

is.na(leadership$q4)

sum(is.na(leadership$q4))


# 결측치에 대한 빈도표 작성 - table 함수

table(is.na(leadership))


# 컬럼별 결측치 확인 - colSums 함수

colSums(is.na(leadership))



# 결측치 채우기
# 중심경향 값 넣기 : 평균, 최빈값, 중앙값 -> (분석결과는 비교적 양호)
# 난수값 넣기 : 정규분포를 따름
# 회귀분석을 이용한 값 넣기 : 관측치 특성 고려 상황에 따라 결측치를 제외할 수도 있음


# 결측치를 평균으로 대체

m1 <- mean(leadership$q1)
m2 <- mean(leadership$q2)
m3 <- mean(leadership$q3)
m  <- mean(c(m1, m2, m3))

m   # 3.466667 => 3

leadership$q4[4] <- round(m)
leadership$q5[4] <- round(m)


# 좀 더 간편하게 결측치 처리

leadership <- within(leadership, { q4[is.na(q4)] <- round(m) ; 
                                   q5[is.na(q4)] <- round(m) })  



leadership <- within(leadership, 
                     { sumq <- q1 + q2 + q3 + q4 + q5 ;
                       meanq <- sumq / 5 })



# 모든 결측치에 단일값 대체

leadership[is.na(leadership)] <- 0






# 결측치 제거

x <- c(1, 2, 3, NA ,5)
y <- sum(x)   # 결측치가 포함된 벡터에 sum 함수 적용 -> 결과는 NA!!!


y <- sum(x, na.rm=T)   # 결측치 제외 후 sum 함수 적용


na.omit(x)   
# => 결측치를 자료구조에서 아예 제외
#    벡터에서는 요소를, 데이터프레임/행렬 에서는 행을 아예 제거함




# leadership 을 na.rm을 이용해서 계산

load('leadership.rdata')

sumq <- ''

within(leadership, { sumq[1] <- sum(q1[1], q2[1], q3[1], q4[1], q5[1], na.ram= T)
                     sumq[2] <- sum(q1[2], q2[2], q3[2], q4[2], q5[2], na.ram= T)
                     sumq[3] <- sum(q1[3], q2[3], q3[3], q4[3], q5[3], na.ram= T)
                     sumq[4] <- sum(q1[4], q2[4], q3[4], q4[4], q5[4], na.ram= T)
                     sumq[5] <- sum(q1[5], q2[5], q3[5], q4[5], q5[5], na.ram= T) })

leadership <- na.omit(leadership)


# apply 함수를 이용해서 처리

leadership$sumq <- apply(leadership[,6:10], 1, sum, na.rm=T)
leadership


# na.omit 을 이용해서 계산

load('leadership.rdata')

leadership

leadership <- na.omit(leadership)







# ex26) titanic (kaggle.com)
# 타이타닉 생존 요인 예측 중 데이터 전처리

# 승객번호, 생존여부(1:생존), 승선권등급(1:특석), 이름, 성별, 나이,
# 형제수, 자녀수, 승선권번호, 승선권요금, 객실번호, 승선항구명
# (C : cherbourg, Q : queens, S : southampton)



# 데이터 불러오기

library('readr')

setwd('c:/Java/data')

titanic <- read.csv('titanic.csv', header=T, stringsAsFactors=F, na.strings=c('NA',''))
# na.string=c('NA','') 
# => 공백 문자열을 NA 로 대체


head(titanic)

str(titanic)

View(titanic)



# 데이터 전처리 <- 결측치 처리

nrow(titanic)   # 총 데이터수 : 891

table(is.na(titanic))     # 177 / 866
colSums(is.na(titanic))   # Age / Cabin,Embarked



# 전처리 방법 
# Age는 177개 이므로 적당한 값(평균)으로 대체

m <- floor(mean(titanic$Age, na.rm=T))
titanic$Age[is.na(titanic$Age)] <- m


# Cabin 은 866 이므로 컬럼 자체를 제거

titanic$Cabin <- NULL

# Embarked 은 2개 이므로 행 자체를 제거

titanic <- na.omit(titanic)



# 성별과 승선위치를 범주형으로 변환

str(titanic)

titanic$Sex <- as.factor(titanic$Sex)
titanic$Embarked <- as.factor(titanic$Embarked)



# 작업결과를 rdata로 일단 저장

save(titanic, file='c:/Java/data/titanic.rdata')



# 승객번호, 생존여부(1:생존), 승선권등급(1:특석), 이름, 성별, 나이,
# 형제수, 자녀수, 승선권번호, 승선권요금, 객실번호, 승선항구명
# (C : cherbourg, Q : queens, S : southampton)

library(dplyr)


# 살아남은 승객수는 ?

nrow(titanic[titanic$Survived == 1,])

titanic %>% filter(Survived == 1) %>% summarise(count=n())



# 승객 중 남자수는?

nrow(titanic[titanic$Sex == 'male',])

titanic %>% filter(Sex == 'male') %>% summarise(count=n())

titanic %>% filter(Sex == 'male') %>% tally()



# 승선권 등급이2이고 남자인 승객수는?

nrow(titanic[titanic$Pclass == 2 & titanic$Sex == 'male',])

titanic %>% filter(Pclass == 2, Sex == 'male') %>% summarise(count=n())

titanic %>% filter(Pclass == 2, Sex == 'male') %>% tally()



# 살아남은 승객 중 남자/여자 수는?

nrow(titanic[titanic$Survived == 1 & titanic$Sex == 'male',])
nrow(titanic[titanic$Survived == 1 & titanic$Sex == 'female',])

titanic %>% filter(Survived == 1, Sex == 'male') %>% tally()
titanic %>% filter(Survived == 1 & Sex == 'female') %>% summarise(count=n())







## 데이터 집계의 또 다른 패키지 - sqldf 

# SQL을 이용한 데이터 분석기능을 제공
# 단, 사용 편의성을 위해 속도를 다소 희생

install.packages('sqldf')

library(sqldf)

setwd('c:/Java/data')

load('titanic.rdata')

# 살아남은 승객수는 ?

sqldf('select count(sex) from titanic where survived = 1')


# 승객 중 남자수는?

sqldf("select count(sex) from titanic where sex = 'male' ")


# 승선권 등급이2이고 남자인 승객수는?

sqldf("select count(sex) from titanic where sex = 'male' and Pclass = '2' ")


# 살아남은 승객 중 남자/여자 수는?

sqldf('select count(sex) from titanic where sex = "male" and survived = 1 ')
sqldf('select count(sex) from titanic where sex = "female" and survived = 1 ')

sqldf('select sex, survived, count(sex) total from titanic group by 1,2')

sqldf('select sex, count(sex) n from titanic 
      group by survived, sex having survived = 1')
















