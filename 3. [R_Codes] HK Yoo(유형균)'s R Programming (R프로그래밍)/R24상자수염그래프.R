## 상자수염 그래프(box and whiskers plot)

# 연속형 변수에 대해 이상치와
# 최대/1사분위(25%)/중위/3사분위(75%)/최소값 등을
# 시작적으로 표현하는 그래프

# 기술통계에는 중심화경향과 분산도로 구분
# boxplot은 데이터의 분산도를 시각적으로 나타낸 그래프


# mtcars 데이터 중 자동차 연비에 대한 수치 분포 확인

summary(mtcars$mpg)

boxplot(mtcars$mpg, ylim=c(10,35), col=rainbow(1))

# 그래프에 평균 표시

mavg <- mean(mtcars$mpg)

points(mavg, col='white', pch=18)




# mtcars 데이터 중 실린더별  자동차 연비에 대한 수치 분포 확인

mtcars$cyl

boxplot(data=mtcars, mpg~cyl, ylim=c(10,35), col=rainbow(3))

# 평균 계산 후 그래프에 표시
# tapply(집계항목, 기준항목, 함수명)

means <- tapply(mtcars$mpg, mtcars$cyl, mean)

points(means, col='white', pch=18)



# mtcars 데이터 중 기어별  자동차 연비에 대한 수치 분포 확인

means <- tapply(mtcars$mpg, mtcars$gear, mean)

boxplot(data=mtcars, mpg~gear, ylim=c(10,35), col=rainbow(3))

points(means, col='white', pch=18)




# 인사정보 employees 데이터를 이용해서 
# 직책별/부서별 급여 현황을 상자수염그래프로 나타내시오

setwd('c:/Java/data')
load('emp.rdata')


# 급여에 대해 상자수염 그래프 작성

sal <- emp$SALARY

boxplot(sal, ylim=c(0,25000), col='red')

means <- mean(sal)   # 6461

points(means, col=0, pch=18)


# 이상치(24000) 제외후 급여에 대해 상자수염 그래프 재작성

sal <- emp$SALARY[emp$SALARY != 24000]

boxplot(sal, col='red', ylim=c(0,20000))

means <- mean(sal)   # 6296

points(means, col=0, pch=18)





# 직책별 급여 현황

boxplot(data=emp, SALARY~JOB_ID, las=3, ylim=c(0, 25000), col=rainbow(19))

summary(emp$SALARY[emp$JOB_ID == 'AC_ACCOUNT'])

means <- tapply(emp$SALARY, emp$JOB_ID, mean)

points(means, col=2, pch=18)



# 부서별 급여 현황

boxplot(data=emp, SALARY~DEPARTMENT_ID, las=3, ylim=c(0, 25000), col=rainbow(11))

means <- tapply(emp$SALARY, emp$DEPARTMENT_ID, mean)

points(means, col=2, pch=18)














