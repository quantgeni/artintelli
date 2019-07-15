# 파이썬으로 몽고디비 접속하기
# pip install pymongo

from pymongo import MongoClient


# mongodb 연결객체 생성
client = MongoClient('mongodb://192.168.180.132:27017')

# 데이터베이스 객체 가져오기
db = client.bigdata

# 컬렉션 객체 가져오기
coll = db.restaurants

# 전체조회
for item in coll.find():
    print(item)

# zipcode 컬렉션 조회
coll = db.zipcode

for item in coll.find():
    print(item)

# 접속해제
client.close()





















