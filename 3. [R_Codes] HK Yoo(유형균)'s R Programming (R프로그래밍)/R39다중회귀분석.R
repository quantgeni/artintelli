## 다중 회귀분석(multiple regression analysis)

# 단일 회귀분석에 비해 변수가 2개이상 증가
# 기술통계학이나 추론통계학 상의 주요 기법

# 종속변수y를 보다 더 잘 설명학고 예측하기 위해
# 여러 독립변수x를 사용함

# 다중회귀방정식
y = a + bx1 + cx2 + dx3 + ...

# 하지만, 독립변수가 3개 이상인 경우 
# 그래프로 표현하기 어려워지므로 
# 보통 a + bx1 + cx2 정도로만 고려하는 것이 좋음



# ex) 부동산회사에서 소유하고 있는 주택에 대해 
# 고객들의 많은 문의사항 중 하나는 난방비가 얼마나 드냐임
# 난방비 가이드라인 작성을 위해 임의로 선별한 20채의 주택에 대해
# 다중회귀분석을 실시하시오 (house.txt)

setwd('c:/Java/data')
house <- read.csv('houses.txt', header = T, sep = '\t')

head(house)


# 산점도 및 상관계수
plot(house)

library(corrplot)
cp <- cor(house)
corrplot(cp, method='ellipse')
corrplot(cp, method='number')


# 회귀계수 
# lm(종속변수 ~ 독립변수1 + 독립변수2 + ...)
# lm(종속변수 ~ .)
model <- with(house, lm(난방비 ~ 평균외부기온 + 단열재 + 난방사용연수))

coef(model)
# (Intercept) 평균외부기온       단열재     난방사용연수 
# 427.193803     -4.582663   -14.830863         6.101032 


# 회귀방정식
y = 427.19 - (4.58 * x1) + (-14.83 * x2) + (6.10 * x3)


# 1) 외부기온 1도 증가 => 난방비는 4.58 감소
# 2) 단열재 두께가 1cm증가 => 난방비는 14.83 감소
# 3) 난방기 년수가 1년 증가 => 난방비는 6.10 증가
# 4) 주택자체 기본 난방비 => 난방비는 427.19


# 만일, 기온이 30도, 단열재 두께가 5cm, 난방기가 10년이 된
# 주택의 예상 난방비는?
=> y = 427.19 - (4.58 * x1) + (-14.83 * x2) + (6.10 * x3)
     = 427.19 - (4.58 * 30) + (-14.83 * 5) + (6.10 * 10)
     = 131.64



# ex) 주택가격은 방의 갯수와 거주연수와 관련있음
# 다음의 회귀방정식을 보고 각 독립변수의 의미를 설명하시오. 
# 만일, 방이 7개, 거주년수 30년일 때, 주택가격은?

y = 21.2 + (18.7 * x1) - (0.25 * x2)

# 1) 방의 갯수가 1증가 => 주택가격은 18.7 증가
# 2) 거주연수가 1증가 => 주택각격은 0.25 감소
# 3) 주택대지 : 기본가격 21.2

y = 21.2 + (18.7 * x1) - (0.25 * x2)
  = 21.2 + 18.7 * 7 - 0.25 * 30
  = 144.6



# ex) 놀이동산 만족도 데이터를 이용해서 
# 놀이기구 rides, 게임만족도 games, 청결만족도 clean 와 
# 전체만족도 overall 에 대한 관계를 분석해보고 
# 회귀방정식을 작성하시오 (parks.csv)

setwd('c:/Java/data')
parks <- read.csv('parks.csv', header = T, sep=',')

parks <- parks[, c(4,5,7,8)]

# 산점도 및 상관계수
library(corrplot)

cp <- cor(parks)
corrplot(cp, method = 'ellipse')
corrplot(cp, method = 'number')

# 회귀계수
# lm(종속변수 ~ . , data=parks)
model <- lm(overall~. , data=parks)
coef(model)
# (Intercept)        rides        games        clean 
#-131.6787679    0.5779797    0.2602822    1.2838081 


# 회귀직선
.opar <- par(no.readonly = T)
par(mfrow=c(2, 2))
termplot(model)
# => 데이터 분포없이 선만 표시

par(.opar)

.opar <- par(no.readonly = F)


# car 패키지의 avPlots 함수 이용
install.packages('car')
library(car)
avPlots(model)





## 다중회귀분석 평가
# 다중회귀식의 통계적 분석은 회귀모형과 잔차를 이용

options(scipen = 100)
m <- lm(난방비~. , data=house)
summary(m)

# 다중표준오차 : 추정치의 표준오차와 표준편차 비교
# Residual standard error: 51.05


# 기온 35도, 단열재 3, 난방기연수 6 일 때, 난방비는?  
=> y = 427.19 - (4.58 * x1) + (-14.83 * x2) + (6.10 * x3)
= 427.19 - (4.58 * 35) + (-14.83 * 3) + (6.10 * 6)
= 259
# 하지만, 실제값은? => 250
# 따라서, 오차는 9 : 다른 관측치에 대해 오차계산
# => 추정치의 다중 표준오차는 잔차의평균제곱MSE의 제곱근 = 평균제곱오차


# 다중 결정계수
# Multiple R-squared:  0.8042
# 독립변수등이 난방비 변동의 80%를 설명
# 또는 도출한다고 판단할 수 있음

# 나머지 19.6%의 오차는 다른원인(오차나 다른 보이지 않는 변수)으로
# 인한 것이라고 추정가능

with(house, cor(난방비, 평균외부기온 + 단열재 + 난방사용연수)^2)
=> 0.6572343
=> 값이 다름 => 분산분석을 이용해서 계산해야 함


# 수정된 결정계수
# Adjusted R-squared:  0.7675

# 독립변수의 수가 증가할수록 예측력이 좋아져서
# 결정계수의 수치가 증가하는 경향이 있음
# 이러한 효과를 상쇄시킨 수정 된 결정계수를 사용


# 다중선형회귀 추론
# 모든 회귀계수들의 유의성을 판단
# F-statistic:  21.9 on 3 and 16 DF, p-value: 0.000006562

# 다중회귀계수가 모두 0인지 검정함 - F분포 이용

# 귀무가설 : 각 계수 a, b, c 가 0이다
# 대립가설 : 각 계수 a, b, c 가 0이 아니다
# 유의수준 0.05로 정함

# 분자의 자유도 : 3
# 분모의 자유도 : 16
# F분포의 임계값 : 3.24
# 검정값이 21.9 이므로 귀무가설 기각!!
# => 각 계수는 0이 아니다!!



# 개별회귀계수에 대한 평가

Coefficients:
  Estimate Std. Error t value   Pr(>|t|)    
(Intercept)     0.00000224 ***
  평균외부기온  0.00002100 ***
  단열재        0.00661 ** 
  난방사용연수  0.14786    

# 특정 독립변수를 개별적으로 검정하여 해당하는
# 회귀계수가 0이 아닌지 검정
# 어떤 회귀계수가 0이라면 독립변수는 종속변수의 변동을
# 설명하는데 쓸모 없음

# 각 회귀계수가 모두 0인지 검정함 - t분포 이용
# 귀무가설 : 계수 x 가 0이다
# 대립가설 : 계수 x 가 0이 아니다
# 유의수준 0.05로 정함, 양측검정
# 자유도 16이므로 임계값은 2.120, -2.120

# => '난방사용연수' 변수는 검정값이 1.521,
#    유의 확률이 0.14786 이므로 귀무가설 채택




# ex) 일반적으로 심박수는 몸무게 weight와 강제호기량 FEV, 잔기량 RV 에
# 영향을 받음. 심박수 BMP 와 몸무게 weight, 심박수와 몸무게,
# 강제호기량 FEV, 잔기량 RV 에 대비 심박수에 대한 
# 회귀식을 작성하고 결정계수와 다중/개별 회귀계수에 대해 평가하시오
# (medical.csv)

setwd('c:/Java/data')
medical <- read.csv('medical.csv', header = T)

head(medical)


# 단일회귀분석 : 심박수/체중
weight <- medical$weight 
bmp <- medical$BMP


# 시각화, 상관계수
plot(weight, bmp)
cp <- cor(medical[, c(4, 5)])

library(corrplot)
corrplot(cp, method = 'ellipse')
corrplot(cp, method = 'number')

corrplot.mixed(cp)
corrplot.mixed(cp, upper='ellipse', lower = 'number')


# 회귀계수/회귀직선
m <- lm(bmp ~ weight)
coef(m)

y = 60.96 + 0.45 * x
# 체중이 증가하면 심박수는 0.45만큼 증가

abline(m, col='red', lty=2)


# 회귀분석
summary(m)
Multiple R-squared:  0.4523
p-value: 0.0002305
weight   0.00023 ***


# 다중회귀분석 : 심박수/체중, 강제호기량, 잔기량
med <- medical[, c(5,4,6,7)]


# 시각화, 상관계수
plot(med)

cp <- cor(med)
corrplot.mixed(cp, upper = 'ellipse', lower = 'number')


# 회귀계수
m <- lm(BMP ~., data=med)
coef(m)
(Intercept)      weight         FEV          RV 
60.0872218    0.3297987   0.2706874  -0.0151688 

y = 60.09 + 0.33*x1 + 0.27*x2 - 0.02*x3


# 다중회귀분석
summary(m)
Multiple R-squared:  0.5317
p-value: 0.0009937

weight  0.01766 * 
FEV     0.22181   
RV      0.63957


# 회귀직선
library('car')
avPlots(m)


# 회귀모형의 적합성 검정

# 주택회사가 보유한 주택에 대한 난방비 가이드라인 작성을 위해
# 다중회귀분석을 실시했었음. 한편, 이러한 회귀모형이 과연 적합한 것일까?

# 회귀모형 작성시 적절한 조건을 만족하는지 알아봄
 
setwd('c:/Java/data')
house <- read.csv('houses.txt', header = T, sep='\t')

m <- lm(난방비 ~ ., data=house)

par(mfrow=c(2,2))

.opar <- par(no.readonly=T)
plot(m)

plot(.opar)

# 시계방향으로 각 그래프가 의미하는 내용
# => 선형성/정규성/분산성/독립성

# 1) 선형성 : 잔차 예측비교도
#             잔차를 표준화시켜 정규분포를 따르는지 확인
#             => 점선은 직선에 가깝게, 분포의 모양이 균등하게 배치

# 2) 정규성 : 독립변수가 정규성을 띄며 잔차도 정규분포를 띄는가?
#             => 45도 점선에 점들이 가깝게 배치
#             단, 양 끝점들은 점선에서 벗어나도 무난

# 3) 분산성 : 잔차 분산비교도
#             독립변수의 분산이 일정하면? 잔차도 비슷한 양상을 띄는가?
#             => 점선은 직선에 가깝게, 분포의 모양이 위 아래 균등하게 배치

# 4) 독립성 : 잔차의 영향력 파악
#             cook's distance
#             회귀 방정식의 계수 결정에 불균형한 영향을 미치는
#             독립변수 존재 파악 .회귀 분석에서 잔차의 크기가 큰 데이터는 
#             보통 이상치료 취급
#             cook's distance 를 통해 잔차와 레버리지를 동시에 볼 수 있음
#             => 빨간선은 직선에 가깝게, 점들분포는 되도록 빨간선에 가깝게,
#                단, 빨간점선 밖은 벗어나지 않게



# ex) 어떤 은행에서 담보주택관련 분석을 위해 관련자료를 분석하고 있음
# 주택가격, 세대주 교육수준, 세대주 연령, 월상환액, 세대주 성별 등이
# 가계소득 수준과 어떤 관련이 있는지 회귀분석을 실시하시오 (banks.txt)

setwd('c:/Java/data')
bank <- read.csv('banks.txt', header = T, sep='\t')


# 시각화, 상관계수
plot(bank)

cp <- cor(bank)
corrplot.mixed(cp, upper='ellipse', lower='number')


# 회귀계수
m <- lm(Income~., data=bank)
coef(m)

u = 7.65 + 0.07x1 * 1 + 1.62x2 * 2 + -0.00x3 * + 1.82x4 * 4


# 다중회귀분석
options(scipen=100)
summary(m)

Multiple R-squared:  0.7491
Adjusted R-squared:  0.6831
vp-value: 0.00003556


Value             0.0000152289 ***
Education         0.01526 *  
Age               0.13646    
Mortgage          0.77575    
Gender            0.00913 **
  
  
# 회귀직선
avPlots(m)
  

# 회귀모델 적합성 여부
par(mfrow=c(2,2))
plot(m)

par(mfrow=c(1,1))
plot(m)

# 산출된 회귀방정식은 가계소득변수의 변동성을 0.68% 정도로
# 설명하고 있고, 회귀모형은 몇몇 이상치 때문에 선형관계, 잔차 정규분포,
# 등분산성에 문제가 있는 것으로 보여짐




# ex) 미술품 수집가는 그림의 낙찰가격과 입찰자수, 보존연수와의 
# 관계를 알아보고자 함. 독립변수와 종속변수간에 어떤 관련이 있는지
# 회귀분석을 실시하시오 (artsbuyer.txt)

setwd('c:/Java/data')
art <- read.csv('artsbuyer.txt', header = T, sep='\t')

art <- art[, -1]


# 시각화, 상관계수
plot(art)

cp <- cor(art)
corrplot.mixed(cp, upper = 'ellipse', lower = 'number')


# 회귀계수
m <- lm(Price ~ ., data=art)
coef(m)

y = 3080.05 - 54.19 * x1 + 16.29 * x2


# 다중회귀분석
summary(m)


# 회귀직선
avPlots(m)


# 회귀모델 적합성 여부
par(mfrow=c(2,2))
plot(m)

par(mfrow=c(1,1))
plot(m)

# 산출된 회귀방정식은 낙찰격의 변동성을 0.6158% 정도로 설명하고 있고, 
# 회귀모형은 몇몇 이상치 때문에 선형관계, 잔차 정규분포, 등분산성에 
# 다소 문제가 있는 것으로 보여짐 




## 다중공선성

# 독립변수들이 서로  상관되었을때 발생


# ex) 대학교 합격여부를 예측하기 위해 고등학교 성적과 석차를 사용하는 경우


# 예기치 못하게 독립변수의 하나가 음의 상관을 나타낼 수 있음
# - 설명하기 어려움
# 독립변수 가설 검정시 결과가 잘못 나올 수 있음

# 두 독립변수간의 상관계수가 -0.7 ~ 0.7 사이면 사용해도 좋음

# 팽창계수 VIF를 사용하기도 함
# 수치가 10이상이면 해당 독립변수는 제외시킴

# R 에서는 car 패캐지의 vif 함수를 이용하면 
# 각 변수간의 다중공선성을 검사할 수 있음



# ex) 다중공선성 문제 풀기
# 시멘트가 굳어지며 발생하는 열의 양을 결정짓는 
# 4가지 성분의 회귀분석

x1 <- c(7, 1, 11, 11, 7, 11, 3, 1, 2, 21, 1, 11, 10)
x2 <- c(26, 29, 56, 31, 52, 55, 71, 31, 54, 47, 40, 66, 68)
x3 <- c(6, 15, 8, 8, 6, 9, 17, 22, 18, 4, 23, 9, 8)
x4 <- c(60, 52, 20, 47, 33, 22, 6, 44, 22, 26, 34, 12, 12)

y <- c(78.5, 74.3, 104.3, 87.6, 95.9, 109.2, 102.7, 
       72.5, 93.1, 115.9, 83.8, 113.3, 109.4)

cement <- data.frame(y, x1, x2, x3, x4)


# 시각화, 상관계수
plot(cement)

cp <- cor(cement)
corrplot.mixed(cp, upper = 'ellipse', lower = 'number')


# 회귀계수
m <- lm(y ~ ., data=cement)
coef(m)


# 다중회귀분석
summary(m)

Adjusted R-squared:  0.9736
p-value: 0.0000004756

# 결정계수는 높지만(심지어 조정된 결정 계수 조차도!)
# 각 계수별 유의성은 거의 없음!
# => 다중공선성 때문에 발생

# 따라서 팽창계수를 확인해 봄
library(car)

vif(m)
x1        x2         x3        x4 
38.49621  254.42317  46.86839  282.51286

# x1, x3 에 비해 x2, x4 의 팽창계수가 높으므로 
# x2, x4 는 제외하고 다시 회귀모형 생성


# 회귀모형 적합성 검정
plot(m)


# x1, x3 를 이용한 회귀분석
m2 <- lm(y ~ x1 + x3, data = cement)
coef(m2)

vif(m2)
x1       x3 
3.117173 3.117173 

summary(m2)
Adjusted R-squared:  0.4578


# x1, x2 를 이용한 회귀분석
m2 <- lm(y ~ x1 + x2, data = cement)
coef(m2)

vif(m2)
x1       x2 
1.055129 1.055129 

summary(m2)
Adjusted R-squared:  0.9744


# x3, x4 를 이용한 회귀분석
m2 <- lm(y ~ x3 + x4, data = cement)
coef(m2)

vif(m2)
x3       x4 
1.000873 1.000873 

summary(m2)
Adjusted R-squared:  0.9223






## 독립변수 최적화

# 독립변수가 많을 때 유의한 계수를 포함시키고
# 유의하지 않은 계수를 제외시켜 구한 회귀방정식은 
# 간단해지고 이해하기 쉬워짐
# => 가능하다면 적은수의 독립변수를 포함하는 것이 좋음

# 다중회귀식에 포함할 수 있는 독립변수들을 효과적으로
# 선별할 수 있는 분석방법
# => 단계적 회귀법, 단계적 변수선택법

# 전진소거법 : 변수를 하나씩 추가함 => 중요도가 높은 변수부터 추가
# 후진소거법 : 모든 변수를 추가해둔 상태에서 p값이 높은 변수부터 제거
# 최적선택법 : 전진 / 후진 소거법을 적절히 조합

# => 이렇게 변수를 하나씩 빼거나 추가해가며 
# 유의한 독립변수를 찾는 것은 다소 불편함
# 더구나 변수의 갯수가 많아지면 시간도 많이 걸림
# => step 함수를 사용하면 간편하게 해결
# ==> step(회귀모델, 변수범위, 소거종류)



# 회귀모형 성능 평가
# 서로 다른 회귀모형에 대한 성능을 측정하는 경우
# AIC 를 기준으로 시행함

# AIC : akaike information criterion
# 주어진 데이터 셋트에 대한 통계모델의 품질측정
# 소거법에 의해 생성된 각 모델간의 품질 평가
# 모델의 적합성 및 필요한 인수의 수를 설명
# => AIC 값이 적을 수 록 적절한 모형임을 의미




# ex) 부동산회사에서 소유하고 있는 주택에 대해 
# 예상 난방비를 예측하려함. 모든 독립 변수들의
# 전진/후진/단계별 소거법을 이용해서 적절한
# 회귀방정식을 작성하세요 (house.txt)

setwd('c:/Java/data')
house <- read.csv('houses.txt', sep = '\t', header = T)

m <- lm(난방비 ~ ., data=house)


# 전진소거법 : 절편에서 변수를 하나씩 추가
step(lm(난방비 ~ 1, data=house), 
     scope=list(lower = ~1, upper = ~평균외부기온 + 단열재 + 난방사용연수),
     diretion='forward')

# 소거법 진행시 각 회귀모델별로 독립변수 추가 여부에 따라 
# AIC가 낮은 모델을 선택함
# => AIC = 160.85 
# 난방비 ~ 평균외부기온 + 단열재 + 난방사용연수


# 후진소거법 : 모든 변수에서 변수를 하나씩 제거
step(lm(난방비 ~ ., data=house), diretion='backward')
# => AIC = 160.85
# 난방비 ~ 평균외부기온 + 단열재 + 난방사용연수


# 단계별소거법
step(lm(난방비 ~ 1, data=house), 
     scope=list(upper = ~평균외부기온 + 단열재 + 난방사용연수),
     diretion='both')
# => AIC = 160.85
# 난방비 ~ 평균외부기온 + 단열재 + 난방사용연수


# 독립변수 제거를 위한 또 다른 방법들
# regsubsets : n개의 변수가 있을 때 각변수를 더 하거나
# 빼서 2n개의 모델을 만들어 적절한 회귀모델을 생성해 줌
install.packages('leaps')
library(leaps)

m <- regsubsets(난방비 ~ .,data=house, method='exhaustive')

summary(m)
summary(m)$bic
# BIC : Bayesian information criterion
# AIC 에 비해 복잡한 모델에 페널티를 좀 더 부여

summary(m)$adjr2   # 회귀모델 비교 측정값

plot(m)

 

# ex) 보스턴 집값 예측
# 보스턴 외곽지역 집값과 그것들과 관련있는 
# 여러요소를 변수로 정의

# 범죄율, 단위면적당 거주주민수, 비상업지구 거주민,
# 강근처 주택여부, 오염도 비율, 공실비율, 노후주택 비율,
# 도로 접근성 비율, 재산세 비율, 학생/교사 비율,
# 유색인종 비율,하위계측 비율, 본인소유 주택가격

# 최종적으로 집값에 영향을 주는 요인은?
library(MASS)
library(corrplot)
library(car)
str(Boston)


# 시각화, 상관계수 

plot(Boston)

cp <- cor(Boston)
corrplot.mixed(cp, upper = 'ellipse', lower = 'number')


# 회귀계수

m <- lm(medv ~ ., data=Boston)
coef(m)


# 회귀직선

avPlots(m)


# 다중회귀분석

options(scipen = 100)
summary(m)


# 회귀모형 적합성 검정

par(mfrow=c(2, 2))
plot(m)
par(mfrow=c(1, 1))


# 다중공산성

vif(m)


# 변수소거법을 이용한 독립변수 최적화

m2 <- step(lm(medv ~., data = Boston), direction = 'backward')

m3 <- step(lm(medv ~., data = Boston), 
           scope=list(lower=~1, 
                      upper=~crim + zn + chas + nox + rm + dis + rad + tax + ptratio + black + lstat), 
           direction = 'forward')

m4 <- step(lm(medv ~., data = Boston), 
           scope=list(upper=~.), direction = 'both')

library(leaps)

m5 <- regsubsets(medv ~., data = Boston, method='exhaustive')
plot(m5)
summary(m5)$bic
plot(m5, scale = 'bic')
plot(m5, scale = 'adjr2')

m6 <- regsubsets(medv ~., data = Boston, method='backward')
m7 <- regsubsets(medv ~., data = Boston, method='forward')
m8 <- regsubsets(medv ~., data = Boston, method='both')

plot(m6)


# 최종적으로 걸러진 변수들 : adjR2 = 0.72
# zn + chas + nox + rm + dis + ptratio + black + lstat


# 직접 손으로 풀어봄 (backward)
hm <- lm(medv ~., data = Boston)
summary(hm) # => indus, age 제거
# 회귀계수들 중 유의확률이 낮은 변수 제거

hm <- lm(medv ~.-indus-age, data = Boston)
summary(hm) # => chas, crim 제거  

hm <- lm(medv ~.-indus-age-chas-crim, data = Boston)
summary(hm) # => chas, crim 제거  

hm <- lm(medv ~.-indus-age-chas-crim-zn, data = Boston)
summary(hm) # => zn 제거

hm <- lm(medv ~.-indus-age-chas-crim-zn-tax, data = Boston)
summary(hm) # => tax 제거

hm <- lm(medv ~.-indus-age-chas-crim-zn-tax-rad, data = Boston)
summary(hm) # => rad 제거

# 최종적으로 걸러진 변수들 : adjR2 = 0.71
# nox + rm + dis + ptratio + black + lstat




# 위 변수들로 구성된 데이터프레임 생성
semiBoston <- Boston[, c(5, 6, 8 , 11, 12, 13)]

# 시각화, 상관계수
# 회귀계수
# 회귀직선
# 다중회귀분석
# 회귀모형 적합성 검정
# 다중공선성





# ex) 


setwd('c:/Java/data')
carparts <- read.csv('carparts.txt', header = T, sep = '\t')

carparts$outlet <- gsub(',', '', carparts$outlet)

carparts$outlet <- as.integer(carparts$outlet)


# 시각화 , 상관계수

plot(carparts)

cp <- cor(carparts)
corrplot.mixed(cp, lower = 'number', upper = 'ellipse')


# 회귀계수

m <- lm(sales ~ ., data = carparts)
coef(m)


# 회귀직선

avPlots(m)


# 다중회귀분석

summary(m)


# 다중공선성

vif(m)


# 회귀모형 적합성 검정

par(mfrow=c(2,2))
plot(m)
par(mfrow=c(1,1))


# 변수 최적화

m2 <- regsubsets(sales ~ ., data = carparts, method = 'exhaustive')

plot(m2, scale = 'adjr2')

# 최종적으로 걸러진 변수들 : adjr2 = 0.99
# user + income + year

m3 <- lm(sales ~ .-outlet-manager, data = carparts)
summary(m3)

plot(m3) 
# => 회귀모형의 적합성은 여전히 만족못함
# => 이상치를 제거하는 등의 보완이 필요




# ex) 공매를 통해 차압된 주택을 전문적으로 판매하는 회사에서
# 주택대출잔고, 월납입액, 납입회자 대비 최종 경매가에 대해 
# 추정하라고 함. 이에 적절한 회귀 분석을 하세요 (auctions.txt)

setwd('c:/Java/data')
auc <- read.csv('auctions.txt', header = T, sep = '\t')

colnames(auc) <- c('loan', 'pay', 'paymade', 'auction')


# 시각화, 상관계수

plot(auc)

cp <- cor(auc)
corrplot.mixed(cp, upper = 'ellipse', lower = 'number')


# 회귀계수

m <- lm(auction ~ ., data=auc)
coef(m)


# 다중회귀분석

summary(m)


# 회귀모형 적합성 검정

plot(m)


# 다중공선성

vif(m)


# 변수소거법을 이용한 독립변수 최적화

m2 <- regsubsets(auction ~ ., data = auc, method = 'exhaustive')

plot(m2, scale='adjr2')

# 최종적으로 걸러진 변수들 : adjR2 = 0.86
# loan

auc2 <- auc[, c(1, 4)]
m3 <- lm(auction ~ ., data = auc2)
summary(m3)
plot(m3)

# => 회귀모형의 적합성은 여전히 만족못함
# => 이상치를 제거하는 등의 보완이 필요
















