# 파이썬 dict 자료구조를 이용해서 JSON 형식으로 mongodb에 입력하기

from pymongo import MongoClient

client = MongoClient('mongodb://192.168.180.133:27017')


# 작업대상 디비/컬렉션 지정

db = client.bigdata
coll = db.students


# 입력할 문서 생성 - JSON

# stud = { 'name' : '혜교', 'kor' : 99, 'eng' : 98, 'mat': 99 }


# 생성한 문서를 mongodb에 입력
# 입력시 생성된 문서 id 확인

# std_id = coll.insert_one(stud).inserted_id
# print(std_id)


# 한번에 여러 문서 입력하기

# studs = [ { 'name' : '혜교', 'kor' : 99, 'eng' : 98, 'mat': 99 },
#           { 'name' : '수지', 'kor' : 90, 'eng' : 90, 'mat': 93 },
#           { 'name' : '사나', 'kor' : 98, 'eng' : 87, 'mat': 86 } ]
#
# coll.insert_many(studs)


# 문서 입력시 날짜정보도 지정
import datetime
# stud = { 'name' : '혜교', 'kor' : 99, 'eng' : 98, 'mat': 99, 'date' : 'datetime.datetime(2019,5,02, 12,33,35)' }

stud = { 'name' : '혜교', 'kor' : 99, 'eng' : 98, 'mat': 99, 'date' : datetime.datetime.now() }

coll.insert_one(stud)


# 입력한 문서 확인
for item in coll.find():
    print(item)





client.close()










