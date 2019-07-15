## 막대그래프

# 비율척도상의 크기를 막대형태로 나타낸 것
# 한편, 등간척도를 이용한 돗수분포표를 
# 막대그래프로 나타내기도 함
# 주료 자료의 범주별 빈도를 요약해서 나타냄

# barplot(대상, 누적여부, 표시방향)


# 데이터 : 학생 10명의 키

heights <- c(170,165,182,153,142,165,159,147,175,172)

barplot(heights)

barplot(heights, col='red')

barplot(heights, col='red', main='학생 키', xlab='번호', ylab='키')

barplot(heights, col='red', main='학생 키', 
        xlab='번호', ylab='키', 
        names.arg=c(1:10))
# names.arg : 막대에 표시할 이름을 의미하는 문자열 벡터 정의 

barplot(heights, main='학생 키', 
        xlab='번호', ylab='키', 
        names.arg=c(1:10), 
        col=c('red','orange','yellow','green','blue',
              'navy','purple','red','orange','yellow'))

barplot(heights, col='orange', main='학생 키', 
        xlab='번호', ylab='키', 
        names.arg=c(1:10), horiz=T)
# horiz : 그래프 표시방향 지정



# 데이터 : 두 약물에 따른 환자 반응

does <- c(20,30,40,45,60)   # 나이
drugA <- c(16,20,27,40,60)  # 효과정도
drugB <- c(15,18,25,31,40)

barplot(does, col=c('red'), names.arg=c(1:5), ylab='나이')
barplot(drugA, col=c('blue'), names.arg=c(1:5), ylab='약물효과')
barplot(drugB, col=c('green'), names.arg=c(1:5), ylab='약물효과')



# 리더쉽 데이터를 이용한 막대그래프

# 매니저별 나이를 막대그래프로 표시
setwd('c:/Java/data')
load('leadership.rdata')

leadership
str(leadership)

barplot(leadership$age, col=seq(1,5), names.arg=c(1:5), 
        xlab='매니저ID', ylab='나이')



# 매니저별 국적현황을 막대그래프로 표시
# 명목척도(범주형) 시각화

leadership$country

x <- table(leadership$country)

barplot(x, col=c('red','blue'), ylab='국적수', names.arg=c('영국', '미국'))



# 매니저별 성별현황을 막대그래프로 표시

leadership$gender

x <- table(leadership$gender) 

barplot(x, col=c('yellow', 'blue'), ylab='성별수', names.arg=c('여성', '남성'))







# ex) mtcars 데이터셋을 이용해서 차량별 기어 현황에 대해 
# 그래프를 작성하시오
# 수직/수평 방향으로 작성하시오
# 단, x축 이름은 '3기어/4기어/5기어' 로 표시한다

str(mtcars)

# 차량별 기어 현황을 빈도표로 작성

x <- table(mtcars$gear)

barplot(x, horiz=T, 
        names.arg=c('3기어', '4기어', '5기어'), 
        las=3, col=c('red', 'blue', 'green'), main='차량별 기어 현황')


# 차량별 기어 현황을 엔진 유형별로 구분해서 막대그래프로 표시

x1 <- table(mtcars$gear, mtcars$vs)

x2 <- table(mtcars$vs, mtcars$gear)


# 기어별 엔진유형

barplot(x1)   # 누적막대그래프
barplot(x1, legen=row.names(x1),
        col=c('red', 'blue', 'green'),
        names.arg=c('v엔진', '직렬엔진'))
# legen : 막대그래프의 범주 표시
# 빈도표의 각 행 이름이 자동지정

barplot(x1, legen=row.names(x1),
        col=c('red', 'blue', 'green'),
        names.arg=c('v엔진', '직렬엔진'),
        beside=T)
# beside : 누적 막대그래프 표시형식 지정



# 엔진유형별 기어

barplot(x2, legen=row.names(x2),
        col=c('red', 'green'),
        names.arg=c('3기어', '4기어', '5기어'),
        beside=T, main='엔진유형별 기어')





# ex) 핫도그 컨테스트 우승자중 연도별 핫도그 먹은 갯수를 그래프로 작성

setwd('c:/Java/data')
hotdogs <- read.csv('hotdog-winners.csv', header=T)

eats <- hotdogs$Dogs.eaten
years <- hotdogs$Year

barplot(eats, names.arg=years, col=rainbow(length(wins)))



# 핫도그 컨테스트 데이터셋을 이용해서 최다 우승국순으로 그래프 작성

hotdogs$Country

unique(hotdogs$Country)   # 중복 제외

wins <- sort(table(hotdogs$Country))   # 오름차순
wins <- sort(table(hotdogs$Country), decreasing=T)   # 내림차순

barplot(wins, las=3, col=1:4)



# 핫도그 컨테스트 데이터셋을 이용해서 최다 우승자순으로 그래프 작성

wins <- sort(table(hotdogs$Country), decreasing=T)   # 내림차순

barplot(wins, las=1, col=rainbow(length(wins)), cex.names=1)
# rainbow : 색상 팔레트를 그래프의 색상표시





# ex) 타이타닉 데이터셋을 이용해서 
# 성별 생존자수를 막대그래프로 작성

setwd('c:/Java/data')
load('titanic.rdata')

g <- table(titanic$Sex)   # 성별

s <- table(titanic$Survived)   # 생존여부

gs <- table(titanic$Sex, titanic$Survived)


barplot(g, names.arg=c('여성', '남성'))
barplot(s, names.arg=c('사망', '생존'))

barplot(gs, 
        names.arg=row.names(gs), 
        legen=row.names(gs), 
        col=2:3, beside=T)

# 범례를 따로 표시
barplot(gs, names.arg=row.names(gs), col=2:3, beside=T)
# space : 그래프 막대 사이 간격 조절

legend('topright', legend=c('사망', '생존'), fill=2:3)  



# 그래프에 숫자 표시

bp <- barplot(gs, names.arg=row.names(gs), col=2:3, beside=T, ylim=c(0,500))

legend('topright', legend=c('사망', '생존'), fill=2:3)  

# text(대상그래프, 위치, 표시값)
text(bp, gs+10, labels=gs, cex=0.7, col='black')



# 승선권 유형별 생존자수를 막대그래프로 작성

ps <- table(titanic$Survived, titanic$Pclass)

barplot(ps, beside=T, col=1:3, ylim=c(0, 400), 
        names.arg=c('1등석', '2등석', '3등석'))



# 승선 지역별 성별 탑승자 수를 막대 그래프로 작성

ge <- table(titanic$Sex, titanic$Embarked)

barplot(ge, beside=T, col=rainbow(2), ylim=c(0, 500), 
        names.arg=c('셰르부르', '퀸즈', '사우샘프턴'))

legend('topleft', legend=c('여성', '남성'), fill=rainbow(2))  



# 승선 지역별 승선권 유형을 막대 그래프로 작성

pe <- table(titanic$Pclass, titanic$Embarked)

bp <- barplot(pe, beside=T, col=rainbow(3), ylim=c(0,400),
        names.arg=c('셰르부르', '퀸즈', '사우샘프턴'))

text(bp, pe+15, labels=pe, cex=1)

legend('topleft', legend=c('1등석', '2등석', '3등석'), fill=rainbow(3))  































