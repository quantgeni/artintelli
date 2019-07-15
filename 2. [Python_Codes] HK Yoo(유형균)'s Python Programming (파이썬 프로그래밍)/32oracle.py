# 파이썬으로 Oracle 다루기
# 파이썬에서 Oracle 데이터베이스를 사용하려면
# Python DB API 규약에 맞게
# 작성된 Oracle DB 모듈이 필요
# 일반적으로 cx_Oracle 모듈을 많이 사용
# pip install cx_Oracle
# pip install --user cx_Oracle   (putty)

# 파이썬용 오라클 라이브러리 cx_Oracle 설치
# https://github.com/oracle/python-cx_Oracle

# oracle instant client : 64bit Oracle Client library
# https://www.oracle.com/technetwork/topics/winx64soft-089540.html
# Basic Package, SQL*Plus Package 다운로드
# instant client 설치 경로를 윈도우 환경변수 PATH로 설정
# Oracle Client libraries require the presence of the correct Visual Studio redistributable.
# Oracle 18 and 12.2 need VS 2013
# Oracle 12.1 needs VS 2010
# Oracle 11.2 needs VS 2005 64-bit or VS 2005 32-bit
# pycharm 다시 시작 후 접속 테스트

# 리눅스에 instant client 설치하기
# 먼저, winscp를 이용해서 다음 파일을 업로드함
# oracle-instantclient18.5-basic-18.5.0.0.0-3.x86_64.rpm

# putty 로 접속한 뒤 다음 명령 실행
# sudo su
# yum localinstall -y oracle-instantclient18.5-basic-18.5.0.0.0-3.x86_64.rpm

# 라이브러리 환경변수에 instant client 파일들을 등록함
# vi  /etc/profile
# ORAclient=/usr/lib/oracle/18.5/client64
# export LD_LIBRARY_PATH=$ORAclient/lib:$LD_LIBRARY_PATH

# source /etc/profile
# exit
# source /etc/profile

# 주피터 노트북 다시 시작함

import cx_Oracle
import os

# 한글처리를 위해 NLS 환경변수 지정
os.putenv('NLS_LANG', '.UTF8')

# 오라클 connection 생성
conn = cx_Oracle.connect(
    'bigdata','bigdata0220','54.180.159.88/xe')

# cx_Oracle 버젼 확인
print(conn.version)
print(cx_Oracle.clientversion())

# 오라클 접속 종료
conn.close()


# ex) HR 데이터베이스의
# employees, departments 테이블을 
# join한 결과를 출력하세요 

import cx_Oracle
import os

os.putenv('NLS_LANG', '.UTF8')
sql = 'select * from Employees join ' \
    ' Departments using (department_id)'

conn = cx_Oracle.connect(
    'hr','hr','54.180.159.88/xe')

cursor = conn.cursor()
cursor.execute(sql)

for rs in cursor.fetchall():
    # print(rs)
    print(rs[0], rs[1], rs[2], rs[3], rs[4])
    # 출력할 컬럼을 리스트의 인덱스 형태로 사용
    # 해당컬럼이 무엇인지 파악 어려움

cursor.close()
conn.close()


# ex) HR 데이터베이스의
# employees, departments 테이블을 
# join한 결과를 출력하세요 (2)

import cx_Oracle
import os

os.putenv('NLS_LANG', '.UTF8')
sql = 'select * from Employees join ' \
    ' Departments using (department_id)'

conn = cx_Oracle.connect(
    'hr','hr','54.180.159.88/xe')

# cursor = conn.cursor(cx_Oracle.cursor.DictCursor)
# oracle 에서는 dict 커서를 지원하지 않음
cursor = conn.cursor()
cursor.execute(sql)

for rs in cursor.fetchall():
    # print(rs['department_id'], 
    #       rs['employee_id'], 
    #       rs['last_name'], 
    #       rs['job_id'], rs['salary'])
    print(rs)
    

cursor.close()
conn.close()


# ex) 1 ~ 100 까지 2배수, 3배수, 5배수 저장
# 테이블 이름은 numbers235
# 필드는 no, no2, no3, no5

conn = cx_Oracle.connect(
    'bigdata','bigdata0220','54.180.159.88/xe')

curs = conn.cursor()
sql1 = ' drop table numbers235'
sql2 = ' create table numbers235 ' \
       ' (no number, no2 number, no3 number, no4 number) '
sql3 = ' insert into numbers235 ' \
       ' values (:no1, :no2, :no3, :no5) '

# curs.execute(sql1)
curs.execute(sql2)

for i in range(1, 100+1):
    curs.execute(sql3, 
        no1=i, no2=i*2, no3=i*3, no5=i*5)

conn.commit()
conn.close()
