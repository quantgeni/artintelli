## 상관분석

# 두 변수 x, y가 있을때 두 변수가 
# 서로 어떤 관계에 있는지 분석하는과정

# 보통 2개의 등간/비율 척도 변수를 분석할때 우선적으로 
# 산점도를 그려 변수간의 관계를 시각화 한 후 상관계수를 계산


# ex) 키x가 클수록 몸무게도 증가하는가?
# 교육을 많이 받으면 수입도 증가하는가?
# 광고를 많이 하면 판매량이 증가하는가?
# 운동을 많이 하면 몸무게는 감소하는가?
# 담배를 줄이면 심혈관 질병 발생비율은 낮아지는가?

# 두 변수 정의 : 독립변수, 종속변수

# 독립변수 : 종속변수를 추정하거나 예측하는데 토대를 제공 (원인/설명 변수)
# 종속변수 : 예측되거나 추정되는 변수
#            독립변수의 특정값에 대한 결과를 의미 (결과/반응 변수)

# 독립변수와 종속변수는 인과관계를 가질 가능성이 높음 (원인-결과 관계)



## 상관관계(correlation)
# 두 변수 사이에 서로 주고 받는 관계가 있음
# => 선형관계 여부와 연관성이 존재

# 양/음의 상관관계, 무 상관관계의 3가지 존재
# => 각 변수의 관계를 기울기에 따라 양/음의 상관계수로 분류함

# 상관관계를 나타내는 정도를 상관계수라 하는데
# 한편, 강력하게 관계가 나타나기도 하지만 
# 아리까리하게 있는 듯 없는 듯한 관계도 있을 수 있음

# 이러한 차이를 명확하게 하기 위해 상관계수를 사용
# - 피어슨 상관계수

# R 에서는 cov, cor 함수를 사용 




## 공분산(covariance)

# 두 변수의 각 평균으로 부터 떨어져 있는 정도를
# 구한 후 표본의 갯수로 나누어 계산한 것
# 결과가 양수 또는 음수로 나올 수 있음

# 양수 -> 양의 상관관계 있음 (x증가 -> y증가)
# 음수 -> 음의 상관관계 있음 (x증가 -> y감소)


# ex) 판매원 15명의 판촉횟수와 판매량 자료가 다음과 같을 때
# 전화횟수에 따라 판매량 변화가 있는지 알아보시오

# 전화횟수p : 96, 40, 104, 128, 164, 76, 72, 80, 36, 84, 180, 132, 120, 44, 84
# 판매량s : 41, 41, 51, 60, 61, 29, 39, 50, 28, 43, 70, 56, 45, 31, 30 

p <- c(96, 40, 104, 128, 164, 76, 72, 80, 36, 84, 180, 132, 120, 44, 84)
s <- c(41, 41, 51, 60, 61, 29, 39, 50, 28, 43, 70, 56, 45, 31, 30)

plot(p, s)

abline(v=mean(p), col='red')

abline(h=mean(s), col='blue')

cor(p, s)   # 상관계수
# 0.8646318 (x > 0 => y > 0)




## 상관계수 범위에 따른 상관정도 해석

# -1.0 ~ -0.7  : 매우 강한 음의 상관관계 있음
# -0.7 ~ -0.3  : 강한 음의 상관관계 있음
# -0.3 ~ -0.1  : 약한 음의 상관관계 있음
# -0.1 ~ 0.1   : 상관관계 없음
#  0.1 ~ 0.3   : 약한 양의 상관관계 있음
#  0.3 ~ 0.7   : 강한 양의 상관관계 있음
#  0.7 ~ 1.0   : 매우 강한 양의 상관관계 있음



## 상관계수 종류
?cor
# method 속성에는 크게 3가지가 지원
# "pearson"(기본), "kendall", "spearman"

# pearson : 등간/비율척도, 정규성을 띄어야 함
#           상관관계를 모수적 관점에서 분석

# spearman : 순서척도, 정규성을 띄지 않음
#            상관관계를 비모수적 관점에서 분석

# kendall : 순서척도, 정규성을 띄지 않음
#           상관관계를 비모수적 관점에서 분석





## 상관계수 공식

# 상관계수 = 공분산 / 각변수 표준편차들의 곱
# 공분산 = ((각 변수 - 평균)들의 곱)의 합 / 표본수 - 1


# 1. (각 변수 - 평균) 계산
# p 변수 평균편차 : p - mean(p)
# s 변수 평균편차 : s - mean(s)


# 2. ((각 변수 - 평균)들의 곱)의 합
# sum(p - mean(p) * s - mean(s))
x <- p - mean(p)
y <- s - mean(s)
sum(x * y)


# 3. 공분산 : ((각 변수 - 평균)들의 곱)의 합 / 표본수 - 1
cov <- sum(x * y) / (length(p) - 1)

cov (p, s)


# 4. 상관계수 : 공분산 / 각 변수 표준편차 곱
cov / (sd(p) * sd(s))

cor(p, s)



# ex) applewood 자동차 판매 데이터를 기초로 구매자 연령과
# 판매이익간의 상관계수를 계산하고 상관분석을 하시오

library(stringr)
setwd('c:/Java/data')
apwd <- read.csv('applewood.txt', header=T, sep=' ')

age <- apwd$Age 

pro <- apwd$Profit 
pro <- str_remove_all(pro, ',')   # , 제거
pro <- str_remove_all(pro, '\\$')   # $ 제거
pro <- as.integer(pro)
pro

plot(age, pro)
abline(v=mean(age), col='red')
abline(h=mean(pro), col='blue')

cov(age, pro)
cor(age, pro)   # 0.261529
# => 판매자 연령과 판매이익은 그리 큰 상관관계가 없음




# ex) 회사에서 신제품이 출시되었을때
# 안내 메일 발송 횟수와 판매량 사이 관계를 조사했다
# 상관계수를 계산하고 상관분석을 하시오

# 메일발송 m: 1, 2, 3, 4, 5
# 판매량 p: 3, 5, 8, 11, 13 (단위 : 천만)

m <- c(1, 2, 3, 4, 5)
p <- c(3, 5, 8, 11, 13)
plot(m, p)
abline(v=mean(m), col='red')
abline(h=mean(p), col='blue')

cor(m, p)   # 0.9970545
# => 메일 발송 횟수와 판매량간에는 상한 상관관계가 존재함




# ex) ggplot2가 제공하는 데이터 셋 중 economics 데이터를 이용해서
# 실업자수(unemploy) 와 개인소비지출(pce), 개인저축율(psavert) 의
# 상관관계를 분석하시오

library(ggplot2)
?economics
str(economics)   # 6 변수 / 574행

unemp <- economics$unemploy
pce <- economics$pce
psave <- economics$psavert

head(unemp)
head(pce)
head(psave)


# 실업자 대비 소비율 상관관계

plot(unemp, pce)

cor(unemp, pce)   # 0.6139997


# 실업자 대비 저축율 상관관계

plot(unemp, psave)

cor(unemp, psave)   # -0.3540073





# ex) MASS 패키지의 Cars93 데이터 셋을 이용해서 
# 고속도로highway / 시내city 연비와 차체 중량weights의 상관관계를 알아보시오

library(MASS)
Cars93

highway <- Cars93$MPG.highway
city <- Cars93$MPG.city
weight <- Cars93$Weight

plot(weight, highway)
cor(weight, highway)   # -0.8106581


plot(weight, city)
cor(weight, city)   # -0.8431385



# 놀이동산 parks 데이터를 이용해서 놀이기구 rides 와
# 전체 만족도의 상관관계를 분석하시오

library(stringr)
setwd('c:/Java/data')
parks <- read.csv('parks.csv', header=T)

rides <- parks$rides
overall <- parks$overall

plot(rides, overall)
cor(rides, overall)   # 0.5859863




## 상관행렬

# 여러 변수(2개 이상)의 상관관계를 한번에 알아보고자 하는 경우
# => 모든 변수에 대한 상관관계를 한번에 알려주는 상관행렬을 사용함
# R 에서는 corrplot() 함수를 이용

install.packages('corrplot')
library(corrplot)


# ex) iris 데이터셋을 이용해

plot(iris$Sepal.Length, iris$Sepal.Width)
plot(iris$Petal.Length, iris$Petal.Width)

plot(iris[, 1:4])


# corrplot 함수
# 상관관계 정도를 한눈에 보기 쉽게 그래프로 그려줌
# 빨간색 : 음의 상관관계
# 파란색 : 양의 상관관계

cor <- cor(iris[, 1:4])
corrplot(cor)
corrplot(cor, method = 'circle')
corrplot(cor, method = 'square')
corrplot(cor, method = 'pie')
corrplot(cor, method = 'color')
corrplot(cor, method = 'shade')
corrplot(cor, method = 'ellipse')
corrplot(cor, method = 'number')



# ex) Cars93 데이터셋을 이용해서 연비와 관련된 
# 변수와의 상관관계를 corrplot으로 확인하시오

library(MASS)

Cars93

# 1) 고속도로 연비 vs 가격/엔진크기/마력/RPM/중량

View(Cars93)

plot(Cars93[, c(8, 5, 12:14, 25)])

cor <- cor(Cars93[, c(8, 5, 12:14, 25)])
corrplot(cor, method = 'ellipse')
corrplot(cor, method = 'number')


# 2) 시내연비 vs 가격/엔진크기/마력/RPM/중량

plot(Cars93[, c(7, 5, 12:14, 25)])

cor <- cor(Cars93[, c(7, 5, 12:14, 25)])
corrplot(cor, method = 'ellipse')
corrplot(cor, method = 'number')





# ex) 놀이공원 만족도에 대한 상관관계 분석
# 주말이용여부, 동반자녀수, 공원까지거리, 기구만족도,
# 게임만족도, 대기시간만족도, 청결만족도 중에서 
# 전체만족도에 많은 영향을 주는 변수는 무엇인가?

setwd('c:/Java/data')

park <- read.csv('parks.csv', header = T)
View(park)

plot(park[, c(8, 3:7)])

cor <- cor(park[, c(8, 3:7)])
corrplot(cor, method = 'ellipse')
corrplot(cor, method = 'number')



# ex) mtcars 데이터셋을 이용해서 자동차의 
# 각 요소에 대한 연비 상관관계를 분석하시오
# (배기량, 마력, 중량)

View(mtcars)

plot(mtcars[, c(1, 3:7)])

cor <- cor(mtcars[, c(1, 3:7)])
corrplot(cor, method = 'ellipse')
corrplot(cor, method = 'number')





## 상관계수 유의성 검정

# 판촉 전화 횟수와 판매량이 서로 관련 없는데 
# 상관계수가 양으로 나온것은 아닐까?
# 유의수준 0.05를 기준으로 가설검정 실시
# R 에서는 cor.test 함수를 사용

# 상관계수의 검정통계량은 t분포를 이용

# 귀무가설 : 상관계수 0이다 (연관성 없음)
# 대립가설 : 상관계수 0이 아니다 (연관성 있음)

# t 검정값 : 상관계수 * sqrt((n - 2)/ (1 - 상관계수^2))

# 임계값 : 유의수준 0.05, 양측검정, df = 13
#          => 2.160, -2.160

cor.test(p, s)   # 6.2051

t = 0.8646318 * sqrt((13/(1-0.8646318^2))) = 6.205089 (=> 6.2051)


# t 검정값과 t 분포표를 이용해서 p-value의 예상값을 예측해봄
# => t 분포표에서 df=13, 양측, 0.05 유의수준에 해당하는 행을 찾음
# => 각 열을 기준으로 t 검정값이 있을거라 예상되는 열을 찾아 봄
# => p-value가 0.001 일 때, t 검정값은 4.221 임
# 따라서, t 검정값이 6.2051 이라면 p-value는 0.001보다 훨씬 작을 것임

options(scipen=100)
pt(6.2051, df=13, lower.tail = F)
# => 귀무가설 기각! => 연관성이 있음





# ex) applewood 자동차 판매 데이터를 기초로 구매자 연령과
# 판매이익간의 상관계수를 계산하고 상관분석을 하시오

# 임계값 : df=178, 0.05, 양측 => 1.973
# t 검정값 : 3.6151
# 귀무가설 기각 => 연관성 있음

cor.test(age, pro)




# ex) 어느 대학교 학생회에서는 학생이 마시는 맥주와 
# 혈중알콜농도 사이 관계를 알고자 한다
# 18명의 학생을 확률표본추출하여 맥주캔 500ml을 마시게 하고
# 30분 후 경찰서에서 혈중알콜농도를 측정하였음
# 시음량과 혈중알콜농도 사이에는 어떤 상관관계가 있는가?
# 상관계수 유의성 검정도 실시하시오

# beer : 6, 7, 7, 4, 5, 3, 3, 6, 6, 3, 3, 7, 1, 4, 2, 7, 2, 1
# blood : 0.1, 0.09, 0.09, 0.1, 0.1, 0.07, 0.1, 0.12, 0.09, 
#         0.07, 0.05, 0.08, 0.04, 0.07, 0.06, 0.12, 0.05, 0.02


beer <- c(6, 7, 7, 4, 5, 3, 3, 6, 6, 3, 3, 7, 1, 4, 2, 7, 2, 1)
blood <- c(0.1, 0.09, 0.09, 0.1, 0.1, 0.07, 0.1, 0.12, 0.09, 
           0.07, 0.05, 0.08, 0.04, 0.07, 0.06, 0.12, 0.05, 0.02)

plot(beer, blood)
abline(v=mean(beer), col='red', lty=3)
abline(h=mean(blood), col='green', lty=3)

cor(beer, blood)   # 0.7787953
cor.test(beer, blood)

# 임계값 : 2.160
# t 검정값 : 4.9662
# => 귀무가설 기각 => 연관성이 있음



## 상관분석

# 독립변수/종속변수간 연관성 분석
# 그래프로 상관정도를 시각적으로 확인
# 상관계수를 계산
# 상관계수의 유의성 조사

