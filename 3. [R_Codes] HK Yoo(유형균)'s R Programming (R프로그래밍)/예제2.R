# ex6) 서울시/경기도 우편번호 데이터를 읽어와서 데이터프레임으로 만드는 R코드를 작성하세요.

summermedals <- read_excel('c:/Java/summermedals.xlsx', col_names=T)
summermedals

# ex7) summermedal 데이터를 읽어와서 데이터프레임으로 만드는 R코드를 작성하세요.

seoul_zip <- read_excel('c:/Java/seoul_zip.xlsx', col_names=T)
seoul_zip


# ex8) 인구주택총조사2015 데이터를 읽어와서 데이터프레임으로 만드는 R코드를 작성하세요.

pop <- read_excel('c:/Java/인구주택총조사2015.xlsx', col_names=T)
pop
