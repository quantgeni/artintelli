## 회귀분석 (regression analysis)

# 상관분석은 변수들이 얼마나 밀접한 관계를 가지고 있는지
# 분석하는 통계적 기법

# 한편, 회귀분석은 (상관분석 + 예측)하는 통계적 기법
# 수량형 값을 예측하는데 주로 사용되는 통계적 모형

# 즉, 두 변수간의 선형(직선)관계를 식으로 표현하고
# 독립변수가 주어지면 종속변수의 값이 얼마인지 추정

# 독립변수와 종속변수 사이의 관계를 선형방정식으로
# 나타낸 것을 회귀방정식이라 함

y = a + bx

a = 절편 : mean() - 기울기 * mean()
b = 기울기 : cor() * (sd() / sd())

# 회귀직선을 그릴때는 '최소제곱법' 이라는 수학적 기법을
# 이용하는, 이는 두 변수의 선형관계를 계량화 한 것임

# R 에서는 lm(종속 ~ 독립), predict() 함수를 이용함



## 회귀분석의 시초

# 영국 유전자학 골턴은 부모의 키와 
# 자녀들의 키 사이의 연관관계를 조사 => 선형적 관계가 있음을 파악
# 후에 칼 피어슨이 이것을 수학적으로 증명
# => 회귀분석이론이 정립

# 즉, 앞으로 발생할 일은 지난 과거에 일어난 일의 
# [평균수준]으로 돌아가는 성질이 있음
# 아버지의 키가 아무리 크더라도 아들의 키는
# 아버지 세대의 평균 키에 맞춰짐



# ex) 판촉전화횟수와 판매량 사이의 관계를 
# 최소제곱법을 이용해서 선형방정식으로 표현하고 
# 판촉전화를 100회 시행시 추정되는 판매량은 얼마인가?

p <- c(96, 40, 104, 128, 164, 76, 72, 80, 36, 84, 180, 132, 120, 44, 84)
s <- c(41, 41, 51, 60, 61, 29, 39, 50, 28, 43, 70, 56, 45, 31, 30)


# 상관계수 및 표준편차로 절편과 기울기 계산

a = 절편 : mean(종속변수) - 기울기 * mean(독립변수)
b = 기울기 : cor() * (sd(독립변수) / sd(종속변수))

기울기 : cor(p, s) * (sd(s) / sd(p)) = 0.260625
절편 : mean(s) - 0.260625 * mean(p) = 19.98

y = a + bx 
  = 19.98 + 0.2601 * x



# 기울기/절편 자동으로 계산하기
lm(s ~ p)


# 작성된 선형 방정식
y = 19.98 + 0.261 * x

# (0.2601 * x) 의미 
# => 판촉전화 1회 시도시 제품은 0.261대 팔 수 있음

# 19.98 의미
# => 판촉전화 한번도 하지 않아도 제품을 19.98대를 팔 수 있다???
#    판촉전화의 횟수범위 : range(p) => 36 
#    판촉전화를 한번도 하지 않았다는 말은 옳지 않음 
#    => 예측에는 사용할 수 없는 값


# 선형방정식을 이용해서 예측하기
# 판촉전화 100회 시도시 예상 판매량은?

y = 19.98 + 0.261 * 100 = 46.08


# 산점도에 선형방정식을 이용한 직선 표시

plot(p, s)
abline(lm(s ~ p), col='red')



## 최소 제곱법을 이용한 절편/기울기 계산

# 기울기 : sum((x - x평균) * (y - y평균)) / sum((x - x평균^2))
# 절편 : y평균 - (x평균 * 기울기)

xbar <- mean(p)
ybar <- mean(s)

a <- sum((p - xbar) * (s - ybar)) / sum((p - xbar)^2)
# a = 0.260625

b <- ybar - (xbar * a)
# b = 19.98

따라서, y = 19.98 + 0.261 * x



# ex) applewood 데이터를 기초로 해서 구매자 연령과
# 판매이익간의 관계를 최소제곱법을 이용해서
# 선형방정석으로 나타내시오

age <- apwd$Age
pro <- apwd$Profit

plot(age, pro)
abline(lm(pro ~ age), col='red')


View(aw)
Age <- aw$Age
Profit <- aw$Profit
str(Profit)
# aw$Profit 정제 후 자료형 integer으로 변경
str
Profit <- gsub('\\$','',Profit)
Profit <- gsub('\\,','',Profit)
Profit
str(Profit)
str(Age)
Profit <- as.integer(Profit)

plot(Age,Profit)
abline(lm(Profit~Age), col='red')




# ex) 최고의 중소기업 중 12개를 임의로 추출하여
# 매출액과 이익을 조사하였음 (smallbs.txt)
# 산점도를 그리고, 상관계수와 회귀방정식을 구해서
# 매출액이 5000일 때, 이익금액을 추정하시오


setwd ('C:/Java/data/')
s <- read.table('smallbs.txt', sep="\t", header=T)
cor(s$Sales, s$Earnings) # 0.6734993

View(s)
Sales <- s$Sales
Earnings <- s$Earnings
plot(Sales,Earnings)
abline(lm(Earnings~Sales), col='red')

xbar <- mean(Sales) # 독립변수
ybar <- mean(Earnings) # 종속변수
b <- sum((Sales - xbar)*(Earnings - ybar)) / sum((Sales - xbar)^2) # 0.08357448
a <- ybar -(xbar * b) # 1.851736

# a = 절편 = mean(종속변수)  - 기울기*mean(독립변수)
# b = 기울기 = cor(독립변수,종속변수) * (sd(종속변수)/sd(독립변수))
b(기울기) = cor(Sales,Earnings) * (sd(Earnings)/sd(Sales)) # 0.08357448
a(절편) = mean(Earnings)  - 0.08357448*mean(Sales) # 1.851736
# 기울기, 절편을 구하는 함수사용
lm(Earnings ~ Sales) # (Intercept) : 1.85174 / p : 0.08357
# 작성된 선형방정식
y = a+bx = 1.85174 + 0.08357 * x
1.85174 + 0.08357 * 50 = 6.03024





# ex) 뮤추얼펀드에 투자하기 위해 자산과 5년간 실적을 조사하였다
# 9개의 뮤추얼펀드를 임의로 추출하여 자산가치와 수익율을 토대로
# 산점도를 그리고, 상관계수와 회귀방정식을 구해서 
# 펀드투자액이 4억일때 5년 수익율은? (funds.txt)

setwd ('C:/Java/data/')
f <- read.table('funds.txt', sep="\t", header=T)
View(f)
Assets <- f$Assets
Return <- f$Return
plot(Assets,Return)
abline(lm(Return~Assets), col='red')

cor(Assets, Return) # -0.0460508 상관관계 없음

# a = 절편 = mean(종속변수)  - 기울기*mean(독립변수)
# b = 기울기 = cor(독립변수,종속변수) * (sd(종속변수)/sd(독립변수))
b(기울기) = cor(Assets,Return) * (sd(Return)/sd(Assets)) # -0.0003933355
a(절편) = mean(Return)  - (-0.0003933355)*mean(Assets) # 9.919827
# 기울기, 절편을 구하는 함수사용
lm(Return ~ Assets) # (Intercept) : 9.9198271 / p : -0.0003933
# 작성된 선형방정식
y = a+bx = 9.9198271 + (-0.0003933) * x
9.9198271 + (-0.0003933) * 400 = 9.762507





# ex) 시의회에서 범죄발생율을 낮추기 위해 경찰관을 늘리고자 함
# 다른 시의 경찰관 수와 범죄발생건수를 토대로 산점도를 그리고,
# 상관계수와 회귀방정식을 구해서 경찰관 수가 20일 때 범죄발생율은?
# (citycrime.txt)

setwd ('C:/Java/data/')
cc <- read.table('citycrime.txt', sep="\t", header=T)
View(cc)
Police <- cc$Police
Crimes <- cc$Crimes
plot(Police,Crimes)
abline(lm(Crimes~Police), col='red')

cor(Police, Crimes) # -0.8743956 매우강한 음의 상관

# a = 절편 = mean(종속변수)  - 기울기*mean(독립변수)
# b = 기울기 = cor(독립변수,종속변수) * (sd(종속변수)/sd(독립변수))
b(기울기) = cor(Police,Crimes) * (sd(Crimes)/sd(Police)) # -0.9596273
a(절편) = mean(Crimes)  - (-0.9596273)*mean(Police) # 29.3882
# 기울기, 절편을 구하는 함수사용
lm(Crimes ~ Police) # (Intercept) : 29.3882 / p : -0.9596
# 작성된 선형방정식
y = a+bx = 29.3882 + (-0.9596273) * x
29.3882 + (-0.9596273) * 20 = 10.19565





# ex) 중고차의 연령과 가격 사이의 관계를 알고자 함
# 작년에 판매된 중고차량 중 12대를 기반으로 산점도를 그리고
# 상관계수와 회귀방정식을 구해서 중고차 연령이 12일때 
# 중고차 가격은 얼마인가? (oldcars.txt)

setwd ('C:/Java/data/')
oc <- read.table('oldcars.txt', sep="\t", header=T)
View(oc)
Age <- oc$Age
Price <- oc$Price
plot(Age,Price)
abline(lm(Price~Age), col='red')

cor(Age, Price) # -0.5436463 강한 음의 상관

# a = 절편 = mean(종속변수)  - 기울기*mean(독립변수)
# b = 기울기 = cor(독립변수,종속변수) * (sd(종속변수)/sd(독립변수))
b(기울기) = cor(Age,Price) * (sd(Price)/sd(Age)) # -0.4787557
a(절편) = mean(Price)  - (-0.4787557)*mean(Age) # 11.17724
# 기울기, 절편을 구하는 함수사용
lm(Price ~ Age) # (Intercept) : 11.1772 / p : -0.4788
# 작성된 선형방정식
y = a+bx = 11.1772 + (-0.4788) * x
11.1772 + (-0.4788) * 12 = 5.4316






# 잔차residual와 최소제곱법MSE
# 편차 : 관측치가 평균으로부터 떨어진 정도
#        관측치 - 평균, x - xbar, y - ybar
# 오차 : 모집단의 관측치와 예측값 사이 차이
# 잔차 : 표본상의 관측치와 예측값 사이 차이

p <- c(96, 40, 104, 128, 164, 76, 72, 80, 36, 84, 180, 132, 120, 44, 84)
s <- c(41, 41, 51, 60, 61, 29, 39, 50, 28, 43, 70, 56, 45, 31, 30 )
plot(p,s)
abline(lm(s~p),col='red')
abline(v=mean(p), lty=3)
abline(h=mean(s), lty=3)
y = 19.9632 + 0.2608 * x
# 그래프를 보면 최소제곱법에 의한 회귀선은 각 데이터의 평균을 지남
# 회귀 직선 방정식에 각 데이터의 평균을 대입해보자
# p의 평균 : 96
# s의 평균 : 45
19.9632 + 0.2608 * 96 # = 45(s의 평균)
# 판매량 실제값s와 회귀방정식을 통해 추정된 값 사이에는 오차가 존재 -> 잔차

# lm함수를 통해 작성된 회귀직선방정식으로 그려진 회귀선을 통해 더 이상
# 오차제곱합을 줄일 수 있는 직선은 없음
# => 오차제곱합은 기울기에 영향을 받음
# 잔차 = 종속변수(관측치) - 예측값
# 오차제곱합 = sum(잔차^2)

# 예측값은 predict 함수를 이용해서 구할 수 있음
predict(lm(s~p)) # 예측값 : p변수값을 방정식에 넣어 계산된 출력 값
s - predict(lm(s~p)) # 오차 = s - 예측값 
sum((s - predict(lm(s~p)))^2) # 오차제곱합 : 587.11

# 회귀식의 예측력 평가
# 예측력 : 추정치의 표준오차

# 전화횟수 대비 판매량에 대한 회기식
y = 19.17 + 0.261 * x
# 전화횟수가 84일때 판매량은 41.8704로 예측 하지만, 실제값은 43, 30 으로 나옴
# => 과연 이 방정식이 믿을 만 한가??
# 정확한 예측이란? 정확한 결과를 도출하는 것
# 경제학과 경영학을 포함한 모든 분야에서는 불가능한 것으로 알려져 있음

# 추정에 있어 추정치 x에 근거해서 얼마나 정확/부정확하게 예측했나 등의
# 척도가 필요 -> 추정치의 표준오차

# sqrt(오차제곱합/표본수 -2)
# 추정치의 표준오차가 작으면 - 추정치가 잘 맞음
# 추정치의 표준오차가 크면 - 추정치가 잘 안맞음

# 전화횟수 대비 판매량에 대한 추정치 표준오차는?
# sqrt(오차제곱합/표본수 -2)
# sum((s - predict(lm(s~p)))^2) # 오차제곱합 : 587.11
sqrt(587.11/(length(p) -2)) # 6.720291

model <- lm(s~p)
summary(model)# => Residual standard error: 6.72 on 13 degrees of freedom

# 결정계수 = R^2 #=> Multiple R-squared:  0.7476,	Adjusted R-squared:  0.7282 
# 결정계수를 통해 회귀식이 얼마나 정확한지 알수 있다
# 0이상 1이하 실수로 표현
# 0에 가까울시 : 회귀식 정확도(설명력) 낮음
# 1에 가까울시 : 회귀식 정확도(설명력) 높음
# 결정계수 : 종변수y의 변동이 독립변수x의 변동에 의해 설명될 수 있는 비율(정확도)


# 결정계수를 구하는 방법
# 1) 상관계수를 이용
R2 <- cor(p,s)^2 # => Multiple R-squared:  0.7476
# 조정된 결정계수 => Adjusted R-squared:  0.7282 
# 표본의 수가 많아질수록 회귀모형의 정확도가 올라가는 부분을 제약하기 위해
# 조정된 결정계수를 사용함

# 2) 분산분석을 이용



# 예측구간 추정
# 추정치의 표준오차와 결정계수를 통해 회귀식의 
# 종속변수 예측력에 대한 전반적인 평가를 내렸었음

# 회귀식의 예측력을 표현하는 또 다른 방식은 
# 독립변수의 특정값을 신뢰구간으로 계산하여 제시

# 신뢰구간 계산을 위한 선형회귀의 가정
# 1) x값은 y값에 각각 대응 - y값은 정규분포
# 2) x값, y값의 평균은 회귀직선 위에 있어야 함 - 선형성
# 3) 추정치의 표준오차는 동일(분산이 동일) - 등분산성
# 4) y값은 확률적으로 독립적이어야 함 - 독립성
#    (각각의 x에 의해 y가 변함)

# ex) 전화횟수 대비 판매량에 대한 회귀식을 토대로 
# 50회를 걸었을때 판매량의 95% 신뢰구간과 예측구간을 구하시오

# 전화횟수 50회일때 판매량 추정
19.17 + 0.261 * 50 # = 32.22 = y

# 신뢰구간 : t * e * sqrt((1/DF) + 편차제곱/편차제곱합)
# 예측구간 : t * e * sqrt(1 + (1/DF) + 편차제곱/편차제곱합)
# e = 추정치의 표준오차 = 6.720291
# t : 95%신뢰수준, 자유도df : 13 => 2.160
# 편차제곱 : (50 - mean(p))^2
# 편차제곱합 : sum((p - mean(p))^2)
# 편차제곱/편차제곱합) : 2116/25600 = 0.08265625
# 신뢰구간 : 2.160 * 6.720291 * sqrt((1/13) + 0.08265625) = 5.798693
# 32.22 +- 5.798693
# 예측구간 : 2.160 * 6.720291 * sqrt(1 + (1/13) + 0.08265625) = 15.63119
# 32.22 +- 15.63119


# r에서 제공하는 함수를 이용해서 신뢰/예측구간 알아보기 
model <- lm(s~p)
coef(model) # 회귀계수 (절편, 기울기)
residuals(model) # 추정치 대비 잔차
deviance(model) # 잔차제곱합
confint(model) # 회귀계수 신뢰구간
predict(model, interval='confidence', newdata=data.frame(p=50)) 
# 신뢰구간 : fit(실제추정치), lwr, upr
predict(model, interval='prediction', newdata=data.frame(p=50)) # 예측구간

# 신뢰구간/예측구간 그래프로 그려보기
# 매끈한 선으로 그래프를 그리기 위해 독립/종속변수를 재생성
phone <- seq(min(p),max(p),1)
csales <- predict(model, interval='confidence', newdata=data.frame(p=phone))
psales <- predict(model, interval='prediction', newdata=data.frame(p=phone))

plot(p,s)
abline(model, col='red')
lines(phone, csales[,2], col='blue', lty=3) # 신뢰구간 하한
lines(phone, csales[,3], col='blue', lty=3) # 신뢰구간 상한
lines(phone, psales[,2], col='purple', lty=3) # 예측구간 하한
lines(phone, psales[,3], col='purple', lty=3) # 예측구간 상한




# ex) 식이요법을 적용한 닭에 대한 데이터 '1'번 닭을 대상으로 
# 시간대비 몸무게에 대한 회귀분석을 실시하시오.(MASS패키지의 ChickWeight)
library(MASS)
str(ChickWeight)
length(ChickWeight$weight)
# weight : 닭 몸무게
# Time   : 몸무게 측정시 병아리 나이(일수)
# Chick  : 닭 번호
# Diet   : 닭 모이 종류


weights <- ChickWeight[ChickWeight$Chick == 1, 1]
times <- ChickWeight[ChickWeight$Chick == 1, 2]


# 산점도
plot(times, weights)

# 상관계수
cor(weights, times)   # 0.9791822

model <- lm(weights ~ times)
abline(model, col='red')


# 회귀계수 및 방정식
coef(model)
y = 24.47 + 7.99 * x


# 유의성 검정
options(scipen=100)
summary(model)
# => 회귀모델의 설명력 : R^2 0.9588
#    회귀계수들 유의성 : F분포 0.00000002974
#    각 회귀계수 유의성 : times 변수 0.0000000297 





# ex) cars 데이터셋을 이용해서 자동차 속도와 제동거리 간의 회귀분석을 실시하시오
# 자동차 속도가 3/21일때 제동거리는?

cars

speed <- cars$speed
dist <- cars$dist

# 산점도 및 회귀직선
plot(speed, dist)

m <- lm(dist ~ speed)
abline(m, col='red')


# 상관계수
cor(speed, dist)   # 0.8068949


# 회귀계수 및 방정식
coef(m)
y = -17.58 + 3.93 * x


# 유의성 검정
options(scipen = 100)
summary(m)
# 결정계수 R^2 : 0.6511
# 유의성 1 : F분포 0.00000000000149
# 유의성 2 : speed 0.00000000000149


# speed가 3, 21일때 제동거리는?
predict(m, newdata=data.frame(speed=c(3, 21)))
=> -5.78, 65.00


