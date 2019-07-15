## 데이터프레임에서 행과 열 쉽게 선택하기
# => subset(객체, 열이름, 조건)


library(ggplot2)


# carat 과 price 변수 출력

diamonds[,c('carat', 'price')]

subset(diamonds, select=carat)
subset(diamonds, select=c(carat, price))



# 변수들 중 carat, price 제외하고 모두 출력

diamonds[,c(-1, -7)]


subset(diamonds, select=-c(carat, price))
subset(diamonds, select=c(-carat, -price))
subset(diamonds, select=c(-1, -7))



# cut 변수 값 중 'Ideal' 인 데이터 조회

diamonds[diamonds$cut == 'Ideal',]


subset(diamonds, subset=(cut == 'Ideal'))
subset(diamonds, (cut == 'Ideal'))



# price 가 100 이상인 데이터 조회

diamonds[diamonds$price >= 1000,]


subset(diamonds, (price >= 1000))



# price 가 1000 이상인 데이터들 중
# cut, carat, price 등을 조회

diamonds[diamonds$price >= 1000, c('cut', 'carat', 'price')]


subset(diamonds, select=c(cut, carat, price), subset=(price >= 1000))







# MASS 패키지의 Cars93 데이터셋을 이용해서 
# 다음 질의를 풀어보시오


library(MASS)
data()
Cars93
str(Cars93)

# 도시 연비 MPG.city 가 30초과인 자동차 모델은?

Cars93[Cars93$MPG.city > 30, 'Model']


subset(Cars93, select=Model, subset=(MPG.city > 30))



# 실린더Cylinders가 4이고 공장 Origin 이 USA인 차종들의 모델, 최소/최대 가격은?

Cars93[Cars93$Cylinders == 4 & Cars93$Origin == 'USA', 
       c('Model', 'Max.Price', 'Min.Price')]


subset(Cars93, select=c(Model, Min.Price, Max.Price), 
        (Cylinders == 4 & Origin == 'USA'))



# 고속도로연비MPG.highway가 
# 평균고속도로연비MPG.city 보다 높은 차종들의 제조사와 모델은?

Cars93[Cars93$MPG.highway > mean(Cars93$MPG.city), 
       c('Manufacturer', 'Model')]


subset(Cars93, select=c(Manufacturer, Model), 
       subset=(MPG.highway > mean(MPG.city)))





## dataframe을 GUI하게 생성 및 수정하기
# edit(), fix()

dia <- diamonds

edit(dia)



newOne <- data.frame()

edit(newOne)   # 수정한 사항은 반영되지 않음

newOne <- edit(newOne)   # 수정사항이 반영



newTwo <- data.frame()

fix(newTwo)   # 수정사항이 즉시 반영

View(newOne)
View(newTwo)   # 읽기전용으로 데이터 조회








## apply 패밀리
# R 에는 tapply, lapply, sapply 등을 포함하는 apply 함수가 존재
# 어떤 객체의 각 요소에 함수를 적용


# apply : 행렬의 행/열 단위에 함수 적용

# lapply : 벡터 / 리스트의 각 요소에 함수 적용

# sapply : 벡터 / 리스트의 각 요소에 함수 적용



# 행열에 함수 적용 : apply
# 결과는 벡터로 출력
# apply(행렬객체, 행/열, 함수)

a <- matrix(1:12, nrow=3, byrow=T)
a

apply(a, 1, sum)   # 행 기준
apply(a, 2, sum)   # 열 기준



# 리스트/벡터에 함수 적용 : lapply, sapply
# lapply : list + apply => 결과는 리스트
# lapply(객체, 함수)
# 데이터프레임과는 달리 리스트는 
# 각 요소의 길이가 달라도 아무런 문제 없음


scores <- list(S1 = c(89,85,85,86,88,89,86,82,96,85,93,91,98,87,94,77,87,98,85,89,95,85,93,93,97,71,97,93,75,68,98,95,79,94,98,95),
               S2 = c(60,98,94,95,99,97,100,73,93,91,98,86,66,83,77,97,91,93,71,91,95,100,72,96,91,76,100,97,99,95,97,77,94,99,88,100,94,93,86),
               S3 = c(95,86,90,90,75,83,96,85,83,84,81,98,77,94,84,89,93,99,91,77,95,90,91,87,85,76,99,99,97,97,97,77,93,96,90,87,97,88),
               S4 = c(67,93,63,83,87,97,96,92,93,96,87,90,94,90,82,91,85,93,83,90,87,99,94,88,90,72,81,93,93,94,97,89,96,95,82,97))

setwd('c:/Java/data')
save(scores, file='scores.rdata')

scores



# 리스트의 각 요소의 길이 출력

lapply(scores, length)   # 결과 리스트

sapply(scores, length)   # 결과 벡터



# 리스트의 각 요소의 평균, 총합 출력

lapply(scores, mean)   
lapply(scores, sum)   

sapply(scores, sum)   
sapply(scores, mean)   



# 리스트의 각 요소의 범위 출력

lapply(scores, range)

sapply(scores, range)   # 행렬처럼 출력


x <- sapply(scores, range)

rownames(x) <- c('min', 'max')

x





## 데이터프레임에 함수 적용

# tapply(데이터, 기준, 함수)


setwd('c:/Java/data')
load('examdata.rdata')

examdata


# 반별 학생수 출력

tapply(examdata$class, examdata$class, length)


# 반별 평균 국어 점수 출력

tapply(examdata$kor, examdata$class, mean)


# 반별 평균 점수 출력

tapply(examdata[,3], examdata$class, mean)
tapply(examdata[,4], examdata$class, mean)
tapply(examdata[,5], examdata$class, mean)



# 반별 최고 점수 출력

tapply(examdata[,3], examdata$class, max)
tapply(examdata[,4], examdata$class, max)
tapply(examdata[,5], examdata$class, max)


# 반별 점수 범위 출력

tapply(examdata[,3], examdata$class, range)
tapply(examdata[,4], examdata$class, range)
tapply(examdata[,5], examdata$class, range)






## 특정열 집단에 함수 적용 - by

# by(대상열, 기준, 그룹함수)  


# 반별 평균 점수 출력

by(examdata[, 3:5], examdata$class, colMeans)


# 반별 점수 총합 출력

by(examdata[, 3:5], examdata$class, colSums)


# 반별 점수 요약 출력

by(examdata[, 3:5], examdata$class, summary)





# ex24) iris 데이터셋을 이용해서 종별, 꾳받침길이의 총합/평균을 구하시오

iris

by(iris[,1:3], iris$Species, colSums)

by(iris[,1:3], iris$Species, colMeans)



tapply(iris$Sepal.Length, iris$Species, sum)
tapply(iris$Sepal.Length, iris$Species, mean)


# ex25) Cars93 데이터셋을 이용해서 제조지역Origin별, 
# 도시/고속도로 연비의 평균을 구하시오

Cars93

by(Cars93[,7:8], Cars93$Origin, colMeans)

by(Cars93[,c('MPG.city', 'MPG.highway')], Cars93$Origin, colMeans)


