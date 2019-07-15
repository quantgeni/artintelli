### R 패키지 

## 패키지 : 함수, 데이터, 코드, 문서 등을 묶어놓은 것
# R 은 수많은 패키지로 구성

# 기본적으로 stats, graphics, datasets, base 등의 
# 7개의 패키지가 미리 설치되어 있음

# R 기본 설치 가능 패키지 수 확인
available.packages()

dim(available.packages())   # 14145

nrow(available.packages())   # 14145


# 설치된 패키지 확인
sessionInfo()
# => 현재 R 실행환경, 언어집합, 설치된 패키지


# https://cran.r-project.org/ 
# => software => package 에서 주제별로 분류
# => Table of available packages, sorted by name





## 새로운 패키지 설치

# 패키지 설치시 반드시 인터넷연결 필요!!!

# 인터넷 사용 불가인 경우 관련 패키지를 
# 미리 다운로드 한 후 설치할 수 있음

# 패키지 설치시 의존성도 자동적으로 해결 
# install.packages('패키지명')
# 설치한 패키지의 저장위치는 ‘C:/Users/TJ/Documents/R/win-library/3.5’
# 경로 찾아들어가서 직접 삭제 하는 방법 또는 명령어로 삭제하는 방법

# Tools => Install Packages 메뉴를 이용해서 패키지 설치가능 

# packages 레이아웃창을 이용해서도 패키지 설치 가능

# stringr/ggplot2 패키지 설치하기
install.packages('stringr')   # 문자처리 패키지

install.packages('ggplot2')


# 설치한 패키지 확인
installed.packages()


# 패키지 제거하기
remove.packages('stringr')


# 패키지 업데이트하기
update.packages('ggplot2')
update.packages('stringr')


# 패키지 설치경로 확인
.libPaths()


# 패키지를 설치하고 난 후 사용하려는 패키지는 
# 반드시 메모리에 적재 load 해두어야 함

# library('패키지명') / library(패키지명)

library('stringr') 
library(stringr)
# => Error in library("stringr") : ‘stringr’이라고 불리는 패키지가 없습니다
# 패키지를 설치하지 않고 사용하려고 시도하면 오류 출력!!


require('stringr')
# => Warning message:
# In library(package, lib.loc = lib.loc, 
# character.only = TRUE, logical.return = TRUE,  
# : ‘stringr’이라고 불리는 패키지가 없습니다
# 패키지를 설치하지 않고 사용하려고 시도하면 경고 출력!!


library()   # 설치된 패키지 확인


# 패키지/명령어/데이터셋 도움말 확인
# help('패키지명')
# ?패키지명
help('stringr')
?stats
?stringr


# 명령어/데이터셋 사용예 확인
# example(명령어)
# example(데이터셋명)
example(head)
example(Nile)






# ex10) 'RSADBE' 패키지를 설치하고 이 패키지의 도움말을 확인하고 
#       데이터셋을 사용해 보세요

install.packages('RSADBE')
library('RSADBE')
?RSADBE
help(RSADBE)
data()   # 데이터셋 확인
example("RSADBE")   # 예제 확인
head(GC)   # 독일인 신용평가 데이터
?GC


data(Severity_Counts)
head(Severity_Counts)
?Severity_Counts
example(Severity_Counts)



# ex11) 'vcd' 패키지를 설치하고 이 패키지에서 사용가능한 
#       함수와 데이터셋을 확인해 보세요

install.packages('vcd')
library('vcd')
help(vcd)
??vcd   # (인터넷을이용한)외부 참조(도움말)

data()
example('vcd')

data(Arthritis)
head(Arthritis)
?Arthritis

