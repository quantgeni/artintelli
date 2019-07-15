# ex1) 나이에 따른 신생아 몸무게 추이에 대한 표
# 각 변수(나이/몸무게)들을 벡터로 선언 => 이변량 분석

baby.ages<-c(01,03,05,02,11,09,09,09,12,03)
baby.weight<-c(4.4,5.3,7.2,5.2,8.5,7.3,6.0,10.4,10.2,6.1)

mean(baby.weight) # 평균

plot(baby.ages,baby.weight)
cor(baby.ages,baby.weight) # 상관계수
abline(lm(baby.weight~baby.ages), col='red') # 상관계수에 따른 선형회귀직선





# ex2) 환자별 약물 투여 후 상태추이에 대한 표
# 각 변수(환자번호/투여일/나이/약물유형/상태)들을 벡터로 선언

hospital.pid<-c(1,2,3,4)
hospital.date<-c('2014.10.15','2014.11.01','2014.10.21','2014.10.28')
hospital.age<-c('type1','type2','type1','type1')






# ex3) 매니저별 설문조사 결과에 대한 표 
# 각 변수(매니저번호/입사일자/국가/성별/나이/질문1/질문2/질문3/질문4/질문5)들을 벡터로 선언 

manager.id<-c(1,2,3,4,5)
manager.date<-c('2014.10.24','2014.10.28','2014.10.01','2014.10.12','2014.05.01')
manager.country<-c('US','US','UK','UK','UK')
manager.gender<-c('M','F','F','M','F')
manager.age<-c(32,45,25,39,99)
manager.q1<-c(5,3,3,3,2)
manager.q2<-c(4,5,5,3,2)
manager.q3<-c(5,2,5,4,1)
manager.q4<-c(5,5,5,,2)
manager.q5<-c(5,5,2,,1)








# ex4) ex1~3에서 생성한 벡터를 이용해서 행렬을 각각 작성하세요.


ages<-c(01,03,05,02,11,09,09,09,12,03)
weight<-c(4.4,5.3,7.2,5.2,8.5,7.3,6.0,10.4,10.2,6.1)

baby<-cbind(ages,weight)
baby




pid<-c(1,2,3,4)
pdate<-c('2014.10.15','2014.11.01','2014.10.21','2014.10.28')
pages<-c('type1','type2','type1','type1')
diabetes<-c('Type1','Type2','Type1','Type1')
status<-c('Poor','Improved','Excellent','Poor')

hospital<-cbind(pid,pdate,pages,diabetes,status)
hospital




mid<-c(1,2,3,4,5)
mdate<-c('2014.10.24','2014.10.28','2014.10.01','2014.10.12','2014.05.01')
country<-c('US','US','UK','UK','UK')
gender<-c('M','F','F','M','F')
age<-c(32,45,25,39,99)
q1<-c(5,3,3,3,2)
q2<-c(4,5,5,3,2)
q3<-c(5,2,5,4,1)
q4<-c(5,5,5,0,2)
q5<-c(5,5,2,0,1)


manager<-cbind(mid,mdate,country,gender,age,q1,q2,q3,q4,q5)
manager




# ex5) ex1~4를 이용해서 데이터프레임으로 각각 작성하세요.

f_baby<-data.frame(나이=ages,몸무게=weight)
f_baby
summary(f_baby)


f_hospital<-data.frame(아이디=pid,등록일=pdate,나이=pages,당뇨=diabetes,상태=status)
f_hospital
f_hospital$등록일<-as.character(f_hospital$등록일)
summary(f_hospital)


f_manager<-data.frame(아이디=mid,날짜=mdate,국가=country,성별=gender,나이=age,q1,q2,q3,q4,q5)
f_manager
f_manager$아이디<-as.character(f_manager$아이디)
f_manager$날짜<-as.character(f_manager$날짜)
summary(f_manager)




# ex6) 서울시/경기도 우편번호 데이터를 읽어와서 데이터프레임으로 만드는 R코드를 작성하세요.

summermedals <- read_excel('c:/Java/summermedals.xlsx', col_names=T)
summermedals

# ex7) summermedal 데이터를 읽어와서 데이터프레임으로 만드는 R코드를 작성하세요.

seoul_zip <- read_excel('c:/Java/seoul_zip.xlsx', col_names=T)
seoul_zip


# ex8) 인구주택총조사2015 데이터를 읽어와서 데이터프레임으로 만드는 R코드를 작성하세요.

pop <- read_excel('c:/Java/인구주택총조사2015.xlsx', col_names=T)
pop

