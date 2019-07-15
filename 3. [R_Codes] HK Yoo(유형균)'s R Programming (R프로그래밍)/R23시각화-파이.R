## 파이그래프

# 도수분포표를 원 모양으로 시각화한 것
# 자료의 범주별 빈도 비율을 요약해서 나타낸 그래프
# pie(데이터, 각종옵션)

val <- c(10,20,30,40,50)

pie(val)   # 기본 작성 : 3시, 반시계

pie(val, init.angle = 90)   # 12시, 반시계 방향

pie(val, init.angle = 90, clockwise = T)   # 12시, 시계 방향

pie(val, init.angle = 90, clockwise = T, col=viridis(5))

pie(val, init.angle = 90, clockwise = T, 
    col=rainbow(5), 
    labels=c('가', '나', '다', '라', '마'))   # 색상과 레이블 표시





# leadership 데이터셋에서 매니저별 국적/성별 비율을 파이그래프로 작성

setwd('c:/Java/data')
load('leadership.rdata')


# 국적비율
nation <- table(leadership$country)
# 비율 : (부분/전체) * 100

npct <- round(nation/sum(nation) * 100)

pie(npct, clockwise = T, col = rainbow(2), labels=paste(npct,'%'))

legend('topleft', c('UK', 'US'), fill=rainbow(2))

text(0.4,0.1, nation[1], col=1)
text(-0.4,0.2, nation[2], col=6)



# 성별 비율

gender <- table(leadership$gender)

gpct <- (gender / sum(gender)) * 100

pie(gpct, clockwise = T, labels=c('여성', '남성'), col=c('red','green'))

text(0.4, 0.3, col=0, paste(gpct[1], '%'))
text(-0.4, 0, paste(gpct[2], '%'))









# 핫도그 우승대회에서 국가별/우승자별 우승 비율을 파이그래프로 작성

setwd('c:/Java/data')
load('hotdog-winners.rdata')


str(hotdogs)

country <- table(hotdogs$Country)

# npct <- round(prop.table(country) * 100)
npct <- sort(round(country / sum(country) * 100), decreasing = T)

pie(npct, labels=c('미국', '일본', '독일', '멕시코'), 
    clockwise = T, col=rainbow(4), cex=0.7)

text(0.4, -0.1, paste(npct[1],'%'))
text(-0.4, 0.1, paste(npct[2],'%'), cex=0.7)



# 범례유형으로 그래프 작성

pie(npct, clockwise = T, col=rainbow(4), labels='')

legend('topleft', c('미국', '일본', '독일', '멕시코'), fill=rainbow(4))

text(0.4, -0.1, paste(npct[1],'%'))
text(-0.4, 0.1, paste(npct[2],'%'), cex=0.7)






# 우승자별 우승비율

wins <- table(hotdogs$Winner)

wpct <- sort(round(wins / sum(wins) * 100), decreasing = T)

pie(wpct, clockwise = T, labels='', col=rainbow(18))

legend('topright', legend=names(wpct), fill=rainbow(18), cex=0.7)

text(0.2, 0.3, paste(wpct[1],'%'), cex=0.7)
text(0.4, 0.05, paste(wpct[2],'%'), cex=0.7)







# applewood 데이터를 이용해서 지역별/차종별 
# 판매대수 비율을 파이그래프로 나타내시오
library(RColorBrewer)
library(viridis)

setwd('c:/Java/data')
load('applewood.rdata')



# 지역별 판매대수 비율

location <- table(apwd$Location)

apct <- sort(round(location / sum(location) * 100), decreasing = T)

pie(apct, clockwise = T, col=rainbow(4))

text(0.4,0.2, paste(apct[1], '%'), cex=0.8)
text(0.3,-0.3, paste(apct[2], '%'), cex=0.8)
text(-0.3,-0.2, paste(apct[3], '%'), cex=0.8)
text(-0.3,0.3, paste(apct[4], '%'), cex=0.8)


legend('topright', names(apct), fill=rainbow(4))




# 차종별 판매대수 비율

type <- table(apwd$Vehicle.Type)

tpct <- sort(round(type / sum(type) * 100), decreasing = T)

pie(tpct, init.angle = 90, col=rainbow(5))

legend('topleft', 
       c('sedan  38%', 'suv  32%', 'compact  16%', 'truck  11%', 'hybrid  4%'), 
       fill=rainbow(5))


legend('topleft', names(tpct), 
       fill=rainbow(5))

text(-0.4, 0.1, paste(tpct[1], '%'))



















