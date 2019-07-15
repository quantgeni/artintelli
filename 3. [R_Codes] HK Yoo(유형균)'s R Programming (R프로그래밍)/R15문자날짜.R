## 문자열 처리

# 기본 문자열 처리함수
# nchar : 문자의수

nchar('Hello, World!!')
nchar('가나다라마바')


length('Hello, World!!')  # 요소 갯수
length('가나다라마바')



# tolower, toupper : 대/소문자 변환

tolower('HELLO, WORLD!!')
toupper('hello, world!!')



# chartr : 문자 바꾸기
# chartr(찾을문자, 바꿀문자, 대상)
# 글자단위로 변경, 찾을문자와 바꿀문자 길이가 동일해야 함

chartr('you', 'him', 'I Like you')

chartr('World', 'Python', 'Hello, World!!')
# => "Hehhy, Pytho!!"
#   월드와 파이썬의 글자수가 맞지 않아 오류 발생함!!



# substr : 문자열 추출
# substr(대상, 시작, 끝)

substr('Hello, World!!', 8, 12)

# substr('123456-1234567', 8)   # 오류발생!!
substr('123456-1234567', 8, 8)



# sub : 문자열 바꾸기
# sub(찾을문자, 바꿀문자, 대상)

sub('you', 'her', 'I Like you')

sub('World', 'Python', 'Hello, World!!')




# car : 문자열 합치기
# cat(문자1, 문자2,..., 구분자)

cat(1,2,3,4,5, sep='/')
cat(1:5, sep=',')


# paste : 문자열 합치기
# paste(문자1, 문자2,..., 구분자)

paste(1, 2, 3, 4, 5)   # sep 구분자 생략
paste(1,2,3,4,5, sep=' ')   
paste(1,2,3,4,5, sep='-')   
paste(1,2,3,4,5, collapse='-')
paste(1:5, sep='-')
paste(1:5, collapse='-')

paste('Hello', 'World', sep=', ')
paste('Hello', 'World', sep='')

persons <- c('지현', '혜교', '수지')
paste(persons, '는 ~를', '좋아한다')
paste(persons, '는 ~를', '좋아한다', sep='그리고')
paste(persons, '는 ~를', '좋아한다', collapse='그리고')



# strsplit : 구분자로 문자열 분리
# strsplit(문자객체, 구분자)

path <- '/home/centos/py36/titanic.csv'
strsplit(path, '/')

emp <- '1	10	200	Jennifer	Whalen	JWHALEN	515.123.4444	
2003-09-17 00:00:00	AD_ASST	4400	NA	101	Administration	200	1700'
strsplit(emp, ',')





# grep : 정규표현식을 이용한 문자 검색
# grep(정규표현식, 대상)
samples <- c('BU1','BU2','BM1','BD1','BU3','ABU1','XY3','ZZ9','XX3','AB0')
samples
grep('BU', samples)
grep('^BU', samples)
grep('3', samples)



# stringr : 하들리 위컴이 제작한 문자 처리 패키지
install.packages('stringr')
library(stringr)



# 문자열 길이 : str_length
str_ <- c('hello','world','like','you',NA)
str_
nchar(str_)
str_length(str_)




# 문자열 추출 : str_sub
str_ <- '123456-1234567'
str_
substr(str_, 8,8)
str_sub(str_,8,8)




# substr(str_, 8)
str_sub(str_,8)  # 왼쪽 기준
str_sub(str_,-8) # 오른쪽 기준
substr(str_,8) #이건 오류 // 끝이 어디인지 말해주는 argument 필요!


# 문자열 합치기 : str_c
str_c(1:5)
str_c(1:5,2)
paste(1:5,2)


# 문자열 구분하기 : str_split
path <- '/home/centos/py36/titanic.csv'
str_split(path, '/')
str_split(path, '/', n=3)
str_split(path, '/', n=2)
str_split(path, '/', n=1)


# 문자열 바꾸기 : str_replace , str_replace_all
fruits <- c('one apple', 'two pears', 'three bananas', 'four oranges')

sub('[aeiou]','-',fruits)
str_replace(fruits, '[aeiou]', '-')

gsub('[aeiou]','-',fruits)
str_replace_all(fruits, '[aeiou]', '-')


# 공백제거 : str_trim
str_ <- '     Hello       '
str_trim(str_)


# 단어 추출 : word
str_ <- c('Hello, World!!', 'I like him and her')
word(str_)      # 첫 번째 단어 출력
word(str_, 2)   # 두 번째 단어 출력
word(str_, start=3,end=5) # 3 ~ 5 번째 단어 출력



# 날짜 다루기
setwd('c:/Java/data')
load('leadership.rdata')
leadership
str(leadership) # 날짜가 범주형으로 작성됨
# stringsASfactors=F 를 사용하면 날짜 문자형으로 작성됨 
leadership

# 문자형식을 날짜로 변환 : as.Date()
# 변환 시 기본 형식은 시스템의 locale을 따름
# 한국 : yyyy-mm-dd
dates <- c('2019-05-21','2019-12-31')
class(dates) # 데이터 유형 확인

as.Date(dates)
newdates <- as.Date(dates)
class(newdates)

leadership
# 만일, leadership의 date를 날짜형식으로 바꾼다면
class(leadership$date)
leadership <- as.Date(leadership$date) # 오류

# 다른 형식의 날짜 데이터는 
# 시스템 locale의 날짜형식으로 변환 불가
# 월/일/년 => 년-월-일 변경 불가
# 적절한 형식 지정자를 이용해야만 변경 가능
# 형식지정자 : strptime 도움말 참조
?strptime
fmt <- '%m/%d/%y'
dates
as.Date(dates,fmt)
dates
# strptime() <--------------------- 이건 추가 필기 필요

# 숫자를 날짜형식으로 변환 : ISOdate
ISOdate(2019,5,21)
as.Date


# 오늘 날짜/시간 출력
Sys.Date()
Sys.time()


# 날짜 출력형식 지정 : format 함수
today <- Sys.time()

format(today, format='%B %b') # 월
format(today, format='%A %a') # 요일



format(today, format='%Y년 %m월 %d일 %A %P %I시 %M분 %S초')
today



# 날짜계산 
# 생년월일 기준 지금까지 몇 일이 지났는가
startdate <- as.Date('2004-04-01')
enddate <- as.Date('2004-12-31')
enddate - startdate

format(enddate, format='%A')


# 고급날짜 계산 : difftime
difftime(enddate,startdate, units='weeks')
difftime(enddate,startdate, units='hours')
difftime(enddate,startdate, units='days')


# 날짜로 된 수열 생성
startdate <- as.Date('2019-05-01')
enddate <- as.Date('2019-06-01')
seq(from=startdate, to=enddate, by=1)


# ex27) 현재 날짜/시간을 
# '2019년 5월 21일 화요일 오후 3시 33분 50초' 형식으로 출력
Sys.Date()
Sys.time()















