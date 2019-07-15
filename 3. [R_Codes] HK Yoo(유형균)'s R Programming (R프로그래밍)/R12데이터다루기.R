
library(tidyverse)

## arrange : 데이터 정열

setwd('c:/Java/data')
load('examdata.rdata')
examdata


# class 를 내림차순으로 정렬해서 출력

examdata %>% arrange(-class)

examdata %>% arrange(desc(class))


# 국어, 영어, 수학을 내림차순으로 정렬해서 출력

examdata %>% arrange(kor, eng, mat)

examdata %>% arrange(desc(kor, eng, mat))

examdata %>% arrange(-kor, -eng, -mat)




## summrise : 데이터 집계

# 평균 국어 점수 출력

examdata %>% summarise(평균국어점수=mean(kor))


# 평균/최고/최소 성적 점수 출력

examdata %>% summarise(평균국어점수=mean(kor),
                       최고국어점수=max(kor),
                       최저국어점수=min(kor),
                       평균영어점수=mean(eng),
                       최고영어점수=max(eng),
                       최저영어점수=min(eng),
                       평균수학점수=mean(mat),
                       최고수학점수=max(mat),
                       최저수학점수=min(mat),
                       학생수=n())



## group_by : 데이터 그룹화

# class 별 최고/최소 평균 점수 추출

examdata %>% 
  group_by(class) %>% 
  summarise(최고점수 = max(kor), 최저점수 = min(kor))






# R 의 formula 인자식 사용하기


# 함수의 인자식을 간편하게 작성하기 위해 '~' 연산자를 사용함

# 집계연산시 : a ~ b + c
# a : 계산하고자 하는 대상
# b : 그룹으로 나눌 기준 1
# c : 그룹으로 나눌 기준 2


# 회귀분석시 : a ~ b + c
# a : 종속변수  (결과)
# b : 독립변수1 (원인)
# c : 독립변수2 (원인)


# 회귀분석시 : a ~ b+c+d+e+f = a ~ .
# . : 전부의 의미, 종속변수를 제외한 나머지 독립변수 의미


# 회귀분석시 : a ~ . - d
# - : 제외를 의미


# 회귀분석시 : a ~ b + c + d:c


# 회귀분석시 : a ~ b * c * d





# class 별 국어,영어,수학 최고/최소 점수 추출
# aggregate(인자식, 객체, 집계함수)

library(plyr)

aggregate(kor ~ class, examdata, max)

aggregate(cbind(kor,eng,mat) ~ class, examdata, each(max, min))









# ex23) diamonds 데이터셋으로 문제 풀기

# carat과 price 변수 출력 
# 변수들 중 carat, price 제외하고 모두 출력
library(ggplot2)
library(dplyr)
View(diamonds)


diamonds

# diamonds 데이터셋을 이용해서 carat과 price 변수 출력 

diamonds %>% select(carat, price)

select(diamonds, carat, price)
select(diamonds, 1,7)

diamonds[,c('carat','price')]
diamonds[,c(1,7)]



#변수들 중 carat, price 제외하고 모두 출력

diamonds %>% select(-carat, -price)

diamonds %>% select(carat,price)
diamonds %>% select(-carat,-price)

findCol <- c('carat','price')
diamonds %>% select(findCol)
diamonds %>% select(.dots=findCol)



#변수명중 c로 시작하는 것만 출력 

diamonds %>% select(starts_with('c'))



#변수명중 e로 끝나는 것만 출력 

diamonds %>% select(ends_with('e'))



#변수명중 l을 포함하는 것만 출력 

diamonds %>% select(contains('l'))



#변수명중 r과 t를 포함한 것만 출력 

diamonds %>% select(matches('r.+t'))
diamonds %>% select(matches('ca'))



# cut 변수 값 중 'Ideal' 인 데이터 조회

diamonds %>% filter(cut == 'Ideal')

diamonds[diamonds$cut == 'Ideal',]
diamonds %>% filter(cut=='Ideal')

diamonds %>% filter(cut == 'Ideal' | cut == 'Good')

# price 가 1000 이상인 데이터 조회

diamonds %>% filter(price >= 1000)

diamonds[diamonds$price >= 1000,]
diamonds %>% filter(price >= 1000)
filter(diamonds, price >= 1000)


# carat이 2이상, price 가 14000 이하인 데이터 조회

diamonds %>% filter(carat >= 2 & price <= 14000)


# carat이 1초과, 5 미만인 데이터 조회

diamonds %>% filter(carat > 1 , carat < 5)


# carat이 1미만이거나, 5초과인 데이터 조회

diamonds %>% filter(carat < 1 , carat > 5)


# price를 carat으로 나눈 것을 Ratio라는 컬럼으로
# Ratio 컬럼을 제곱한것을 Double이라는 컬럼으로 생성

diamonds %>% mutate(Ratio=price/carat, Double=Ratio*Ratio)

diamonds %>% summarise(평균가격=mean(price),
                       가격중앙값=median(price),
                       평균carat=mean(carat))

# 평균 가격price와 price의 중앙값, 평균 carat을 집계

mean(diamonds$price)
median(diamonds$price)
mean(diamonds$carat)


summarise(diamonds, mean(price))
summarise(diamonds, median(price))
summarise(diamonds, mean(carat))


summarise(diamonds, 
          avgcarat=mean(carat),  
          avgPrice=mean(price), 
          mdnprice=median(price))


diamonds %>% summarise(avgcarat=mean(carat),  
                       avgPrice=mean(price), 
                       mdnprice=median(price))




# cut 기준으로 평균 가격을 집계

aggregate(price ~ cut, diamonds, mean)


diamonds %>% 
  group_by(cut) %>% 
  summarise(avgPrice=mean(price))



# cut 기준으로 평균 가격, 총 carat을 집계

aggregate(cbind(price, carat) ~ cut, diamonds, each(mean, sum))


# 선생님 풀이
aggregate(price~cut, diamonds, mean)
aggregate(carat~cut, diamonds, sum)


library(plyr)

aggregate(carat~cut, diamonds, each(mean, sum))
# carat 에 한해서 mean, sum 구함


library(dplyr)

diamonds %>% 
  group_by(cut) %>% 
  dplyr::summarise(avgPreice=mean(price), sumCarat=sum(carat))



# cut, color 기준으로 평균 가격을 avgPrice로, 총 carat을 sumCarat이라는 이름으로 집계

aggregate(cbind(price, carat) ~ cut + color, diamonds, 
          each(avgPrice=mean, sumCarat=sum))


# 선생님 풀이

aggregate(price~cut+color, diamonds, mean)
aggregate(carat~cut+color, diamonds, sum)


diamonds %>% 
  group_by(cut, color) %>% 
  dplyr::summarise(avgPrice=mean(price), sumCarat=sum(carat))



# color 기준으로 평균 가격을 avgPrice로, 
# 총 carat을 sumCarat이라는 이름으로 집계하고
# 평균가격으로 내림차순 정렬


diamonds %>% 
  group_by(color) %>% 
  dplyr::summarise(avgPrice=mean(price), sumCarat=sum(carat)) %>% 
  arrange(avgPrice)



# color 기준으로 평균 가격을 avgPrice로, 
# 총 carat을 sumCarat이라는 이름으로 집계하고
# 평균가격은 내림차순 정렬, 총 carat은 오름차순으로 정렬


diamonds %>% 
  group_by(color) %>% 
  dplyr::summarise(avgPrice=mean(price), sumCarat=sum(carat)) %>% 
  arrange(desc(avgPrice), sumCarat) 



 
# 패키지 메모리 해제

detach('package:ggplot2', unload=T)

diamonds   # 오류 출력!!








