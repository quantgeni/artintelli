### dplyr

# 해들리 위컴이 만든 패키지
# 데이터프레임을 대상으로 데이터먼징 작업에 
# 빠른 속도와 많은 유용한 기능을 제공
# 데이터먼징의 사실상 표준(de facto) 패키지로 자리잡음

# data munging / data wrangling / data preprocessing
# 원자료를 수작업을 통해 또 다른 형태로 전환하거나 매핑하는 것을 의미
# 데이터 조작의 split - apply - combine 방법을 구체화시킨데 의의가 있음

# 먼징의 각 작업은 동사로 정의된 각 함수를 통해서 이뤄짐

# select : 열 선택
# filter : 조건 검색
# group_by : 데이터 그룹화 
# mutate : 행/열 추가
# summrise : 데이터 집계
# arrange : 데이터 정열

# 이러한 함수들은 magrittr 패키지에 의해 구현된 
# 파이프 패러다임을 이용해서 체인형식으로 연산을 수행할 수 있음
# 즉, 먼저 실행한 함수의 결과를 다음 실행할 함수의 입력으로 보낼 수 있음

sum(examdata, na.rm=T)      # 기존방식
examdata %>% sum(na.rm=T)   # 파이프

# 파이프 기호 입력시 단축키 ctrl + shift + M 을 사용하면 편리

# 참고 : plyr 과 dplyr 를 같이 사용하는 경우
# 먼저 plyr 패키지를 로딩해야 함

# 해들리 위컴이 만든 모든 패키지를 설치
# => tidyverse

install.packages("tidyverse")
library(tidyverse)

setwd('c:/Java/data')
load('examdata.rdata')

examdata



## select : 열선택

# 국어 성적 선택

examdata %>% select(kor)


# 번호, 클래스 선택

examdata %>% select(id, class)


# 국어, 영어, 수학 성적 추출

examdata %>% select(kor, eng, mat)


# 번호, 클래스 제외 하고 나머지 선택

examdata %>% select(-id, -class)






## filter : 조건검색
# class 가 1인 학생들의 성적 추출

examdata %>% filter(class == 1)


# class 가 3인 학생들의 성적 추출

examdata %>% filter(class == 3)


# class 가 1이 아닌 학생들의 성적 추출

examdata %>% filter(class != 1)


# 국어 점수가 50점이상 학생 추출

examdata %>% filter(kor >= 50)


# class 가 2 또는 4인 학생들의 성적 추출

examdata %>% filter(class == 2 | class == 4)


# 영어 점수가 70점이상, 수학점수가 85점 이상인 학생 추출

examdata %>% filter(eng >= 70 & mat >= 85)






## dplyr 함수 조합하기

# class 가 3인 학생들의 국어 점수 추출

examdata %>% 
  filter(class == 3) %>% 
  select('kor')


# class가 1, 5인 학생들의 국어/영어/수학 점수를 상위 5행만 출력

examdata %>% 
  filter(class == 1 | class == 5) %>% 
  select('kor', 'eng', 'mat') %>% 
  head(5)



examdata %>% 
  filter(class == 1 | class == 5) %>% 
  select(3:5) %>% 
  head(5)





## mutate : 행/열 추가

# 국어 / 영어 / 수학 성적에 대한 총점/평균 을 구해서 
# tot, avg 라는 이름의 컬럼을 생성

examdata %>% 
  mutate(tot = kor + eng + mat) %>% 
  head(5)


examdata %>% 
  mutate(tot = kor + eng + mat, avg = round(tot / 3, 1)) %>% 
  head(5)


# 새로 추가한 컬럼은 메모리상에만 존재
# 이것을 실제 데이터프레임에 반영할려면 
# 관련 변수에 다시 저장해야 함

examdata <- examdata %>% 
  mutate(tot = kor + eng + mat, avg = round(tot / 3, 1))



# 국어 / 영어 / 수학 성적에 대한 총점/평균 을 기준으로 
# 학점grd이라는 이름의 컬럼을 생성
# 학점은 '수/우/미/양/가' 로 평가함

examdata1 <- examdata %>% 
  filter(avg < 60) %>%
  mutate(grd = '가')
# 조건에 맞는 행만을 추출해서 학점을 계산
# => 전체 20행 중 4행만 출력


examdata2 <- examdata %>% 
  filter(avg >= 60 & avg < 70) %>%
  mutate(grd = '양')


examdata3 <- examdata %>% 
  filter(avg >= 70 & avg < 80) %>%
  mutate(grd = '미')


examdata4 <- examdata %>% 
  filter(avg >= 80 & avg < 90) %>%
  mutate(grd = '우')


examdata5 <- examdata %>% 
  filter(avg >= 90) %>%
  mutate(grd = '수')


# examdata1 ~ examdata5 를 합쳐야 제대로 된 결과 출력

examdata6 <- rbind(examdata1, examdata2, examdata3, examdata4, examdata5)

examdata6



# ifelse 함수를 사용하면 이런 불편함이 어느정도 해소
# ifelse(조건, 참 일때 값, 거짓일때 값)

examdata <- examdata %>% mutate(grd = ifelse(avg <  60, '가', ''))

examdata <- examdata %>% mutate(grd = ifelse(avg >= 60, '양', ''))

examdata <- examdata %>% mutate(grd = ifelse(avg >= 70, '미', ''))

examdata <- examdata %>% mutate(grd = ifelse(avg >= 80, '우', ''))

examdata <- examdata %>% mutate(grd = ifelse(avg >= 90, '수', ''))

examdata




# ifelse(조건, 참 일때 값, 
#        ifelse(조건, 참 일때 값, 
#        ifelse(조건, 참 일때 값, 거짓일때 값)))

examdata <- examdata %>% 
mutate(grd = ifelse(avg >= 90, '수',
             ifelse(avg >= 80, '우',
             ifelse(avg >= 70, '미',
             ifelse(avg >= 60, '양', '가')))))
examdata




# case_when 함수를 이용하면 조금이나마 간편하게 작성가능
# case_when(조건~참 일때값,...)

?case_when

examdata %>% mutate(grd = case_when(avg <= 60 ~ '가',
                                    avg >= 90 ~ '수',
                                    avg >= 80 ~ '우',
                                    avg >= 70 ~ '미',
                                    avg >= 60 ~ '양'))





# ex22) mpg 데이터셋을 이용해서 다음 문제를 풀어보시오

library(ggplot2)

mpg
View(mpg)

# a. 차종class 와 도시연비cty 변수를 조회하시오

mpg %>% select('class', 'cty')



# b. class가 'suv' 와 'compact' 인 차량 중 
# 어떤 차량이 도시연비 cty 가 높은가?

suv <- mpg %>% select(class, cty) %>% filter(class == 'suv')
mean(suv$cty)   # suv 평균 연비 계산
  
  
compact <-mpg %>% select(class, cty) %>% filter(class == 'compact')
mean(compact$cty)


# c. 배기량displ 에 따라(4/5) 어느차량이 
# 고속도로연비(hwy)가 높은가?

dis4 <- mpg %>% filter(displ  == 4) %>% select('displ', 'hwy')

dis5 <- mpg %>% filter(displ  == 5) %>% select('hwy')

mean(dis4$hwy)

mean(dis5$hwy)



# d. 제조사 manufacturer 에 따라 (audi/toyota) 
# 어느차량이 도시연비 cty 가 높은가?

audi <- mpg %>% 
  select(manufacturer, cty) %>% 
  filter(manufacturer == 'audi') 
  
round(mean(audi$cty))   # 18


toyota <- mpg %>% 
  select(manufacturer, cty) %>% 
  filter(manufacturer == 'toyota') 

round(mean(toyota$cty))   # 19




# e. chvolet, ford, honda 차량의 
# 평균 고속도로연비 hwy를 조회 하시오

car3 <- mpg %>% select(manufacturer, hwy) %>% 
  filter(manufacturer == 'chvolet' | 
         manufacturer == 'ford' | 
         manufacturer == 'honda')

mean(car3$hwy)


car3 <- mpg %>% 
  select(manufacturer, hwy) %>% 
  filter(manufacturer %in% c('chvolet', 'ford', 'honda'))

mean(car3$hwy)



# f. 고속도로 연비와 도시 연비를 합산해서 
# allmpg 라는 컬럼을, allmpg 를 2로 나눠 
# avgmpg 하는 컬럼을 각각 생성하시오

mpg2 <- mpg %>% 
  mutate(allmpg = hwy + cty, avgmpg = allmpg / 2) %>% 
  select('model', 'displ', 'class', 'allmpg', 'avgmpg')

mpg2



# g. cyldesc라는 컬럼을 생성하고 
# 차량의 실린더가 4이면 4기통, 6이면 6기통
# 그 외에는 8기통이라고 출력하시오

mpg3 <- mpg %>% 
  mutate(cyldesc = case_when(cyl == 4 ~ '4기통', cyl == 6 ~ '6기통', TRUE ~ '8기통')) %>% 
  select('model', 'trans', 'cyldesc')

mpg3

