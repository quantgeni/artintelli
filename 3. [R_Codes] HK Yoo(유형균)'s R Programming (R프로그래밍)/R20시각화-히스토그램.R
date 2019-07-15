## 히스토그램

# 범주형 데이터를 빈도표를 이용해서 막대그래프로 표현하는 것과 
# 비슷하게 연속형 데이터를 도수분포표를 이용해서 막대그래프로 표현한 것
# x 축은 변수들의 구간을 의미하는 계급
# y 축은 구간의 빈도를 의미하는 도수
# hist(대상, 구간정보)

# 도수분포표 : 특정구간에 속하는 자료의 갯수를 나타낸 표



# 데이터 : 학생10명의 키
heights <- c(170,165,182,153,142,165,159,147,175,172)

sort(heights)

hist(heights)
# 각 구간은 다음과 같음
# 141~150, 151~160, 161~170, 171~180, 181~190

h <- hist(heights)
h   # => 히스토그램의 상세정보 확인. 구간, 도수, 밀도 등등

hist(heights, breaks=10) 
# 변수의 구간을 재설정

cuts <- c(141,151,161,171,181,191) 
hist(heights, breaks=cuts, col=rainbow(6)) 
# 변수의 구간을 사용자 임의로 사용


# 도수분포표 만드는 법

# 1) 자료의 갯수를 센다

# 2) 자료의 범위 파악
range(heights)

# 3) 구간의 수를 정함 -> 짝수/홀수/5의 배수
#    1 + log(최대 - 최소) / log(2)
1 + log(40) / log(2) = 6.32 # => 7

# 4) 구간의 폭을 구함
# (최대 - 최소) / 구간갯수
(182 - 142) / 7 = 5.71 # => 6 / 5

# 5) 구간의 경계값 계산
# 140~145, 146~150, 150~155, 
# 156~160, 161~165, 166~170
# 171~175, 176~180, 181~185

# 6) 구간별 도수 계산
```



```{r}

library(rmarkdown)
library(knitr)


# mtcars 데이터셋에서 연비/마력을 히스토그램으로 나타내시오

mpgs <- mtcars$mpg

hps <- mtcars$hp


hist(mpgs)
hist(hps)





# money 데이터를 이용해서 적당한 구간을 계산하고
# 히스토그램을 작성하시오

money <-c(33,8,11,22,12,9,8,33,32,30,
          22,12,24,21,26,12,15,37,30,16,
          18,9,28,18,25,37,16,25,28,25,
          16,24,31,25,28,28,15,12,35,38)

# 1) 데이터 갯수를 이용해서 구간수 파악
# => 2승수 법칙 이용
length(money)   # 2^5 ~ 40 ~ 2^6 => k = 6


# 2) 구간 범위 지정 : (max - min) / k
# 일반적으로 10배수 / 100배수로 지정

(max(money) - min(money)) / 6   # => 5


# 3) 구간의 한계값 지정
# 일반적으로 5배수/ 10배수 / 100배수로 지정
# 최소 : 8  => 5
# 최대 : 38 => 40
seq(5, 40, 5)

hist(money, breaks=seq(5, 40, 5), col=rainbow(7), ylim=c(0, 10))

h <- hist(money, breaks=seq(5, 40, 5), col=rainbow(7), ylim=c(0, 10))

text(h$mids, h$counts+0.5, labels=h$counts)
# text(x 좌표, y 좌표, 표시할값)






# ex) 국가별 연도별 출생률 데이터를 이용해서
# 2008년 출생수를 히스토그램으로 나타내시오

setwd('c:/Java/data')
load('birth.rdata')


# 2008년 출생률 데이터 추출 (NA 제외)

y2008 <- birth$X2008

y2008 <- y2008[!is.na(y2008)]

summary(y2008)

hist(y2008, col=rainbow(10), xlab='출생률 구간', ylab='출생률 빈도',
     main='2008년 출생률')


# 기본 계급은 0~5, 5~10, ...

hist(y2008, breaks=5, col=rainbow(6), xlab='출생률 구간', ylab='출생률 빈도',
     main='2008년 출생률')



# 수정된 계급은 0~10, 10~20, ...

brk <- c(0,10,20,30,40,50,60)

hist(y2008, breaks=brk, col=rainbow(6), xlab='출생률 구간', ylab='출생률 빈도',
     main='2008년 출생률')




# 구간의 범위를 벡터로 지정

brk <- c(5,10,15,20,25,30,35,40,45,50,55)

hist(y2008, breaks=brk, col=rainbow(10), xlab='출생률 구간', ylab='출생률 빈도',
     main='2008년 출생률')




# 구간의 범위를 seq 함수로 지정

# 구간 직접 나누기

# 1. 구간 갯수 - 2승수 법칙
length(y2008)   # 219
# 2^7 ~ 219 ~ 2^8 => k= 8

# 구간범위 : 5, 10, 50, 100 배수
(max(y2008) - min(y2008)) / 8
# => 5.665 => 5 또는 10

# 구간 한계값
min(y2008) # => 최소값 8.204 => 5 , 0
max(y2008) # => 최대값 53.536 => 55, 60





hist(y2008, breaks=seq(5,55,5), col=rainbow(10), xlab='출생률 구간', ylab='출생률 빈도',
     main='2008년 출생률')

hist(y2008, breaks=seq(0,60,10), col=rainbow(6), xlab='출생률 구간', ylab='출생률 빈도',
     main='2008년 출생률')




# 그래프 막대에 값 표시

h <- hist(y2008, xlim=c(5,60), ylim=c(0,70), 
          col=rainbow(10), 
          xlab='출생률 구간', ylab='출생률 빈도',
          main='2008년 출생률')

text(h$mids, h$counts+3, labels=h$counts, cex=0.7)




# 그래프 축의 축구간 재설정

hist(y2008, xaxt='n', yaxt='n', 
     col=rainbow(10), 
     xlab='출생률 구간', ylab='출생률 빈도',
     main='2008년 출생률')
axis(side=1, at=seq(5,55,5))
axis(side=2, at=seq(0,65,5), las=1)




# ex) 핫도그 컨테스트에서 핫도그 우승자의 핫도그 먹은 갯수를
# 히스토그램으로 나타내시오

setwd('c:/Java/data')
load('hotdog-winners.rdata')

hotdogs

eats <- hotdogs$Dogs.eaten


# 구간 직접 작성
max(eats)
min(eats)
# 9.1 ~ 68 : seq(5, 70, 5), seq(0, 70, 10)

hist(eats, breaks=seq(5, 70, 5), col=rainbow(15))

hist(eats, breaks=seq(0, 70, 10), col=rainbow(7))


# 막대에 값 표시

h <- hist(eats, breaks=seq(0, 70, 10), col=rainbow(7), ylim=c(0,15))

text(h$mids, h$counts+0.7, labels=h$counts)







# ex) 인사정보 HR 데이터를 이용해서 사원들의 급여현황을 
# 히스토그램으로 나타내시오

setwd('c:/Java/data')
emp <- read.csv('EMPLOYEES.csv', header=T)

save(emp, file='c:/Java/data/emp.rdata')

sal <- emp$SALARY


# 구간 지정하기
min(sal)   # 2100
max(sal)   # 24000

seq(0, 25000, 5000)
seq(0, 25000, 2500)

hist(sal, breaks=seq(0, 25000, 5000), col=rainbow(5), ylim=c(0,50))
hist(sal, breaks=seq(0, 25000, 2500), col=rainbow(10), ylim=c(0,40))
# 이상치 존재 부각 (사장이 받는 급여)






# ex) 타이타닉 데이터를 이용해서 탑승자의 나이현황을 
# 히스토그램으로 나타내시오

setwd('c:/Java/data')
load('titanic.rdata')

ages <- titanic$Age

max(ages)   # 80
min(ages)   # 0.42

seq(0,80,5)
seq(0,80,10)

h <- hist(ages, breaks=seq(0, 80, 10), col=rainbow(8), ylim=c(0,500))
h1 <- hist(ages, breaks=seq(0, 80, 5), col=rainbow(8), ylim=c(0,300))

text(h1$mids, h1$counts+15, h1$counts, cex=0.7)






# ex) 탑승자의 나이대별 생존/사망 현황을
# 히스토그램으로 나타내시오

as <- table(titanic$Survived, titanic$Age)

as
as[1,]   # 사망
as[2,]   # 생존 

hist(as) # 안나옴

barplot(as, beside=T)   # 식별 어려움


# 비율척도를 기반으로 등간척도 추출

life <- titanic$Age[titanic$Survived == 1]
dead <- titanic$Age[titanic$Survived == 0]


# 구간 나누기

max(dead); min(dead)   # 74 , 1
max(life); min(life)   # 80, 0.42

seq(0, 80, 10)
seq(0, 80, 5)

# 사망자
hist(dead, breaks=seq(0,80,5), col=rainbow(16), ylim=c(0, 200))

# 생존자
hist(life, breaks=seq(0,80,5), col=rainbow(16), ylim=c(0, 100))






# applewood 데이터셋을 이용해서 
# 나이별 구매현황, 판매금액별 구매 현황을
# 히스토그램으로 작성하시오

setwd('c:/Java/data')
read.table('c:/Java/data/applewood.txt', header=T, sep=' ')

apwd <- read.table('c:/Java/data/applewood.txt', header=T, sep=' ')  # 공백

save(apwd, file='c:/Java/data/applewood.rdata')


# 나이별 구매현황

ages <- apwd$Age

summary(ages)   # 21, 73

seq(20, 80, 5)


h1 <- hist(ages, breaks=seq(20, 80, 5), col=rainbow(14), ylim=c(0,40))
h <- hist(ages, breaks=seq(20, 80, 10), col=rainbow(6), ylim=c(0,80))

text(h$mids, h$counts+3, h$counts)
text(h1$mids, h1$counts+2, h1$counts)



# 판매금액별 구매현황
# 주의) $ 기호 제거 필요!!

profit <- apwd$Profit

profit <- gsub('\\$', '', profit)
profit <- gsub(',', '', profit)
profit <- as.numeric(profit)

summary(profit)
# 294, 3292

seq(0, 3500, 500)

h <- hist(profit, breaks=seq(0, 3500, 500), col=rainbow(7), ylim=c(0, 60))

text(h$mids, h$counts+2, h$counts)