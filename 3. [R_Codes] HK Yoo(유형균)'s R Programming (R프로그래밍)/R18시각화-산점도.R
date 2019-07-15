## 시각화(그래프) 기초

# 숫자와 텍스트만으로 작성된 통계 결과는 지루/따분
# 그래프와 그림형태로 제시(시각적묘사)
# 열정적인 반응이 동반
# 또한, 데이터의 관계 구분 용이

# R 그래프 함수 : plot, barplot, hist, stem, boxplot, pie

x <- rnorm(15)
summary(x)
# rnorm(n) : 정규분포를 따르는 난수 15개 생성
# 정규분포 : 수집된 자료가 나타날 분포의 유형이 
#            보통 평균 0, 표준편차 1 인 분포

plot(rnorm(x))   # 산점도

barplot(rnorm(x))   # 막대그래프

hist(x)   # 히스토그램

stem(x)   # 줄기 잎 그래프

boxplot(x)   # 상자수염 그래프

x2 <- x
x2[x <= -3 & x  > -4] <- '-3_'
x2[x <= -2 & x <= -3] <- '-2_'
x2[x <= -1 & x <= -2] <- '-1_'
x2[x  > -1  & x <  0] <- '-0_'
x2[x >=  0 & x  <  1] <- '0_'
x2[x >=  1 & x  <  2] <- '1_'
y <- round(prop.table(table(x2))*100, 1)
pie(y)   # 파이 그래프






# 데이터 : 두 약물에 따른 환자 반응

does <- c(20,30,40,45,60)   # 나이
drugA <- c(16,20,27,40,60)  # 효과정도
drugB <- c(15,18,25,31,40)


# 데이터 : 학생 10명의 키

heights <- c(170,165,182,153,142,165,159,147,175,172)


# 점으로 그래프를 표현
# 점그래프 : 막대 그래프의 막대를 점으로 표현
# dotchart(x축값, label=y축라벨)

dotchart(drugA, label=does)


# 산점도
# n개의 짝으로 이루어진 자료를 x,y 평면에 점으로 나타낸것
# 자료의 분포(흩어짐)정도를 파악 - 상관분석에 사용
# plot(x축값, y축값, 그래프 옵션)
# plot(y축값) => x축은 자동으로 지정

plot(heights)   # y 축만 지정, x 축은 자동생성


plot(drugA)
plot(does, drugA)
plot(drugB)
plot(does, drugB)



# 그래프 다양한 설정 보기
# main, sub, xlab/ylab, axes, col, pch  

# 제목지정

plot(heights, main='학생10명 키', sub='부제목', col.main='red', col.sub='blue')

plot(does, drugA, main='환자/약물그래프', sub='약물A 반응', 
     col.main='yellow', col.sub='purple')


# 산점도 유형 지정 : type
# point / line / both / horizontal / step

plot(heights, type='p')
plot(heights, type='l')
plot(heights, type='b')
plot(heights, type='h')
plot(heights, type='s')



# 점/선 유형, 색깔, 굵기, 배경색 지정
# col, pch(0-25), lty(1-6), cex(1, 0.5, 1.5), lwd(1), bg, fg

plot(heights, pch=10, lty=3)
plot(heights, pch='0', lty=6)
plot(heights, type='b', pch=2, lty=3)
# 점종류, 선종류

plot(heights, type='b', pch=22, lty=3, cex=0.5)
plot(heights, type='b', pch=22, lty=3, cex=1.5)
# 기호 크기

plot(heights, type='b', pch=22, lty=3, lwd=2)
# 선두께

plot(heights, type='b', pch=22, lty=3, bg='red', fg='blue', col='green')
# 배경/전경색, 선색


# 모눈표시 : grid
plot(heights)
grid()


# x / y축 범위 지정 : xlim, ylim
# 눈금이 뜨문뜨문 나옴

plot(heights)
plot(heights, xlim=c(0,12), ylim=c(145, 185))


# x / y축 사용자 지정 : aixs
# axis(x축/y축, 범위)

plot(heights, axes=F)

# axis(1, at=c(1,2,3,4,5,6,7,8,9,10))
axis(side=1, at=1:10, cex.axis=0.75)
# axis(side=2, at=seq(140, 185, by=5), cex.axis=0.75)
axis(side=2, at=heights, cex.axis=0.75, las=2)


box()




# 특정 축만 표시 안함
# xaxt, yaxt

plot(heights, yaxt='n')

axis(2, at=seq(140,185,5), las=2)   # 레이블 표시 각도 조절



# 각 점에 수치 표시 : text
# text(값, 굵기, 표시문자, 위치)

plot(heights, col='red')
grid(lty=4, lwd=2, col='navy')
text(heights, cex=0.8, lab=heights, adj=c(0.1, -0.1))
# adj : 음수 - 오른쪽 / 위쪽, 
#       양수 - 왼쪽 / 아래쪽



# 현재 그래프 매개변수 설정

.opar <- par(no.readonly = F)








# ex30) cars 데이터셋을 이용해서 속도대비 제동거리에 대한산점도를 작성하시오


# 변수 하나만 사용

plot(cars$speed)
plot(cars$dist)

# 변수 2개 사용

plot(cars$speed, cars$dist, 
     xlab='차량속도', 
     ylab='제동거리',
     main='속도대비 제동거리 현황')

abline(lm(cars$dist~cars$speed), col='red')
# 포물러식 : 종속변수 ~ 독립변수

plot(cars$dist~cars$speed, xlab='속도', ylab='제동거리')




# ex31) iris 데이터셋을 이용해서 붓꽃 꽃잎 길이/너비 와
# 붓꽃받침 길이/너비에 대한 산점도를 작성하시오

plot(iris$Sepal.Length, iris$Sepal.Width,
     xlab='붓꽃받침 길이', ylab='붓꽃받침 너비')

plot(iris$Sepal.Length, iris$Petal.Length,
     xlab='붓꽃받침 길이', ylab='붓꽃 꽃잎길이')

plot(iris$Sepal.Width, iris$Petal.Length.Width,
     xlab='붓꽃받침 너비', ylab='붓꽃 꽃잎너비')


# 산점도 행렬

# 여러 변수 쌍의 관계를 동시에 평가

plot(iris[,-5])
pairs(iris[,-5])





# 고급 산점도 그래프 그리기

setwd('c:/Java/data')
load('leadership.rdata')

# 매니저별 나이에 대한 산점도 작성

within(leadership, { 
  plot(manager, age, xlab='매니저', ylab='나이', yaxt='n'); 
  axis(side=2, at=age, las=2 ) })


# 매니저별 나이에 대한 산점도 작성
# 성별/국적도 함께 표시

str(leadership)

within(leadership, { 
  plot(manager, age, xlab='매니저', ylab='나이', 
       pch=as.integer(gender)) })
# gender 는 범주형 변수이므로 숫자형으로 변환시
# levels 와 유사하게 출력
# 따라서, levels에 따라 점모양이 다르게 출력


within(leadership, { 
  plot(manager, age, xlab='매니저', ylab='국적', 
       pch=as.integer(country)) })

# country 변수가 문자형이라면 다음처럼 작성
# pch=as.integer(as.factor(country)) 




# 범례 지정하기 : legend
# legend(위치, 값, 기호, 색상)
# 위치 : top, bottom, right, left, center

within(leadership, { plot(manager, age, xlab='매니저', ylab='국적', 
       pch=as.integer(gender), col=as.integer(gender)) 
legend('topleft', c('남', '여'), pch=as.integer(gender), col=as.integer(gender))
legend('topright', c('남', '여'), pch=as.integer(gender), col=as.integer(gender))
legend('bottomright', c('남', '여'), pch=as.integer(gender), col=as.integer(gender))
legend('center', c('남', '여'), pch=as.integer(gender), col=as.integer(gender))
})




within(leadership, { 
  plot(manager, age, xlab='매니저', ylab='나이', 
       pch=as.integer(country), col=as.integer(country)) 
legend('topleft', c('UK', 'US'), pch=c(1,2), col=c(1,2)) 
})




within(leadership, { 
  plot(manager, age, xlab='매니저', ylab='나이', 
       pch=as.integer(country), col=as.integer(country)) 
legend(locator(1), c('UK', 'US'), pch=c(1,2), col=c(1,2)) 
})
# locator(1) : 마우스로 지정한 위치에 범례를 표시 할 수 있도록 해 줌




# 지정한 위치(x, y)에 범례 표시

within(leadership, { plot(manager, age, typr='n'); 
  legend(x=4.4, y=100, 
         c('UK', 'US'), 
         pch=c(1,2), col=c(1,2)) })
# x 는 x 값의 범위내,
# y 는 y 값의 범위내로 지정해야 함





# 산점도의 점 다루기 

# points(x, y, 점유형, 색상)

# 학생 10명의 키를 범주로 나눠 표시
# 140~159 : 작음(1), 160~170 : 보통(6), 170 : 큼(13)

plot(heights, type='n')

points(1:4, heights[heights >= 140 & heights < 160], pch=1, col='blue')
points(5:6, heights[heights >= 160 & heights < 170], pch=6, col='red')
points(7:10, heights[heights >= 170], pch=13, col='purple')

legend('topleft', c('small', 'normal', 'high'), 
       pch=c(1,6,13), col=c('blue','red','purple'))




# 직선 다루기 : abline
# 선형방적식에 의한 직선이나 수평선/수직선을 그을때 사용
# 학생 10명의 키에 대한 평균을 직선으로 표시
# abline(절편, 기울기, 수직평행, 수평평행)

plot(heights, type='n')
abline(h=mean(heights), col='red', lty=2)
abline(v=5, col='red', lty=2)


plot(does, drugA, type='n')
lm <- lm(drugA~does)
abline(lm,lty=2, col='red')


plot(cars, type='n')
abline(a=-5, b=3.5, lty=2, col='red')
# y = a + bx 형태로 직선 그음



# 제목 다루기 2 : title, ann
# 찾아보기!!!



# 2개이상 산점도 그리기 : plot + lines

plot(does, drugA, type='b', col='red', ylab='drugs')

lines(does, drugB, type='b', col='blue')

grid()

text <- c('drugA', 'drugB')
legend('topleft', legend=text, 
       pch=c(1,1), col=c('red', 'blue'), text.width = strwidth(text)[1]/2) 






# ex) hotdog winners 데이터셋을 이용해서 산점도로 표현하시오

# 푸드파이터/competitive eater/프로식신
# 음식을 빨리/많이 먹는 것을 직업으로 삼는 사람


setwd('c:/Java/data')
hotdogs <- read.csv('hotdog-winners.csv', header=T)
save(hotdogs,file='c:/Java/data/hotdog-winners.rdata')
rm(hotdogs)
load('c:/Java/data/hotdog-winners.rdata')
hotdogs
str(hotdogs)

head(hotdogs)


# 기술통계
summary(hotdogs)


# 표
table(hotdogs$Winner)
x <- sort(table(hotdogs$Winner))   # 빈도

x2 <- round(prop.table(x) * 100, 1)   # 빈도대비 비율


table(hotdogs$Country)
y <- sort(table(hotdogs$Country))

y2 <- round(prop.table(y) * 100, 1)


# 등간척도 : 구간별 분석
hotdogs$Dogs.eaten


# 그림
year <- hotdogs$Year
eat <- hotdogs$Dogs.eaten
winner <- hotdogs$Winner
nation <- hotdogs$Country

plot(year, eat, las=3)

barplot(x, las=3)
barplot(y, las=3)

pie(x2)
pie(y2)


# 산점도에 우승자 국적 표시
plot(year, eat, xlab='년도', ylab='먹은갯수', 
     pch=as.integer(nation), col=as.integer(nation))

legend('topleft', c('독일', '일본', '멕시코', '미국'),
       pch=c(1, 2, 3, 4), col=c(1, 2, 3, 4))



# 3관왕 이상 우승자만 표시
plot(year, eat, type='n', xaxt='n', yaxt='n')

axis(side=1, at=seq(1980, 2010, 2), cex.axis=0.8)

axis(side=2, at=seq(9, 70, 5), cex.axis=0.8, las=1)


points(hotdogs$Year[hotdogs$Winner == 'Mike DeVito '], 
        hotdogs$Dogs.eaten[hotdogs$Winner == 'Mike DeVito '], 
       pch=1, col='blue')

points(hotdogs$Year[hotdogs$Winner == 'Joey Chestnut '], 
       hotdogs$Dogs.eaten[hotdogs$Winner == 'Joey Chestnut '], 
       pch=2, col='pink')

points(hotdogs$Year[hotdogs$Winner == 'Takeru Kobayashi '], 
       hotdogs$Dogs.eaten[hotdogs$Winner == 'Takeru Kobayashi '], 
       pch=3, col='red')

points(hotdogs$Year[hotdogs$Winner == 'Takeru "Tsunami" Kobayashi '], 
       hotdogs$Dogs.eaten[hotdogs$Winner == 'Takeru "Tsunami" Kobayashi '], 
       pch=3, col='red')



legend('topleft', 
       legend=c('Mike DeVito(US)', 'Joey Chestnut(US)', 'Takeru Kobayashi (JP)'), 
       pch=1:3, col=c('blue','pink','red'))


# 우승자가 먹은 핫도그 수 표시
grid()

eats <- hotdogs$Dogs.eaten[
  hotdogs$Winner == 'Mike DeVito ' |
  hotdogs$Winner == 'Takeru Kobayashi ' |
  hotdogs$Winner == 'Takeru "Tsunami" Kobayashi ' |
  hotdogs$Winner == 'Joey Chestnut ']

years <- hotdogs$Year[
  hotdogs$Winner == 'Mike DeVito ' |
  hotdogs$Winner == 'Takeru Kobayashi ' |
  hotdogs$Winner == 'Takeru "Tsunami" Kobayashi ' |
  hotdogs$Winner == 'Joey Chestnut ']

text(years, eats, cex=0.7, lab=eats, adj=c(0, -0.2))









# ex) birth rate 데이터셋을 이용해서 산점도로 표현하시오

# 출생률
# 합계출산율 vs 합계출산율 vs 출생률


# 합계출산율 : 가임기(15~49세) 여성 1명이 평생 낳을것으로 예상하는 평균 자녀수
# => 15~49세 산모 출생아 수 / 15~49세 여성수 

# 합계출산율 : 가임기 여성 1000명 당 낳은 출생아 수
# 각 연령별 산출된 출산율을 모두 합해서 계산

# 출생률 : 1년간 인구 1000명 당 태어난 출생아 수
# => (출생아 수 / 전체인구수) * 1000



setwd('c:/Java/data')
birth <- read.csv('birth-rate.csv', header=T, stringsAsFactors=F)
save(birth,file='c:/Java/data/birth.rdata')
rm(birth)
load('c:/Java/data/birth.rdata')
birth

# 국가별 연도별 출생률 데이터
# ourworldindata.org
# => birth-rate-vs-death-rate

str(birth)
head(birth)

# 기술통계
summary(birth)
View(birth)


# G7 국가별 : 경제대국
# => 미국, 캐나다, 독일, 영국, 프랑스, 이탈리아, 일본

# G20 국가별 : 경제대국 7, 유럽연합1, 주요경제국 12
# 대륙별 : 아시아, 유렵, 아메리카(남/북), 아프리카, 오세아니아


# 표/빈도비율 => 의미없음

# 그림

g7 <- birth[birth$Country == 'United States' |
            birth$Country == 'Canada' |
            birth$Country == 'Germany' |
            birth$Country == 'United Kingdom' |
            birth$Country == 'France' |
            birth$Country == 'Italy' |
            birth$Country == 'Japan',]

g7_1980s <- g7[,]
g7_1990s <- g7[,]
g7_2000s <- g7[,c(1, 42:50)]   # 국가명 / 2000년 출생률

plot(g7_2000s)   # 산점도 행렬 - 식별 불가

plot(g7_2000s[,2], ylab='출생률', xlab=' G7 국가',
     type='b', col='red', xaxt='n', yaxt='n', ylim=c(8,15), pch=1)           
lines(g7_2000s[,3], col='yellow', type='b', pch=2)    
lines(g7_2000s[,4], col='orange', type='b', pch=3)   
lines(g7_2000s[,5], col='green',  type='b', pch=4)   
lines(g7_2000s[,6], col='blue',   type='b', pch=5)   
lines(g7_2000s[,7], col='navy',   type='b', pch=6)   
lines(g7_2000s[,8], col='purple', type='b', pch=7)

axis(side=1, at=1:7, labels=g7_2000s[,1], las=3, cex.axis=0.7)


colors <- c('red', 'yellow', 'orange', 'green', 'blue', 'navy', 'purple')
legend('topleft', legend=c(2000:2006), pch=c(1:7), col=colors)




# ex) seoul car 2015 데이터셋을 이용해서 산점도로 표현하시오
# 서울시 월별 교통사고 현황 데이터 (2015)

setwd('c:/Java/data')
car2015 <- read.table('c:/Java/data/seoul_car_2015.txt', header=T, sep=',')  
save(car2015, file='c:/Java/data/car2015.rdata')
rm(car2015)
load('c:/Java/data/car2015.rdata')
car2015
str(car2015)



# 기술통계
summary(car2015)


# 표와 빈도비율


# 시각화
# 2015년 월 기준 교통사고 현황

car2015_1 <- car2015[car2015$연도 == 2015 & car2015$월 == 1,]

car2015_1

summary(car2015_1)

gu <- car2015_1$자치구명
happen <- car2015_1$발생건수
death <- car2015_1$사망자수
wounds <- car2015_1$부상자수

plot(happen, type='b', pch=1, col='red', 
     xlab='자치구', ylab='발생/사망/부상', xaxt='n', ylim=c(0, 460))

lines(wounds, type='b', pch=2, col='blue')
lines(death,  type='b', pch=3, col='green')

axis(side=1, at=1:25, labels=gu, las=1, cex.axis=0.7)




# 2015년 구별 교통사고 현황

secho2015 <- car2015[car2015$자치구명 == '서초구',]

happen <- secho2015$발생건수
death <- secho2015$사망자수
wounds <- secho2015$부상자수

plot(happen, type='b', pch=1, col='red', 
     ylim=c(0,450), xast='n', xlim=c(1,12), xlab='', ylab='',
     main='2015년 서초구 교통사고 현황')
lines(wounds, type='b', pch=2, col='blue')
lines(death, type='b', pch=3, col='green')

axis(side=1, at=seq(1, 12, 1))




