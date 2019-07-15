setwd('c:/Java/data')
phones <- read.csv('c:/Java/data/phone02.csv', header=T, sep=',')

save(phones, file='c:/Java/data/phones.rdata')
rm(phones)
load('c:/Java/data/phones.rdata')
phones
str(phones)

library(tidyverse)

phones %>% summarise(연령=mean(age), median(age), 
                       키=mean(height), median(height), 
                       몸무게=mean(weight), median(weight))


# 기술통계
summary(phones)


buyyear <- phones$buyyear
dispsize <- phones$dispsize

as.integer(dispsize)

plot(buyyear, type='b', pch=1, col='red', 
     main='구매시기 및 화면크기에 대한 분석',
     xlab='화면크기', ylab='구매시기', xast='n', xlim=c(0,6))
lines(dispsize, type='b', pch=2, col='blue')

axis(side=1, at=seq(0.5, 6))







age <- phones$age
ptime <- phones$phonetime
lte <- phones$lteamount

plot(age, type='b', pch=1, col='red', 
     ylim=c(0,1000), xlim=c(0,50), xast='n', 
     xlab='연령', ylab='폰사용시간/데이터사용랑')
lines(ptime, type='b', pch=2, col='blue')
lines(lte, type='b', pch=3, col='green')

axis(side=1, at=seq(5, 50, 5))












