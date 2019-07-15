# 파이썬을 이용한 몽고디비 조회

from pymongo import MongoClient

client = MongoClient('mongodb://192.168.180.133:27017')

db = client.bigdata
rest = db.restaurants


# 데이터 조회 - doc 하나 출력

# print( rest.find_one({}) )
#
#
# # 데이터 조회 - 모든 doc 출력
#
# for item in rest.find({}):
#     print(item)
#
#
# cursor = rest.find({})
# for item in cursor:
#     print(item)



# # cursor 형식으로 조회
#
# cursor = rest.find({})
# print(cursor.next())
# print(cursor.next())
# print(cursor.next())


# cnt = cursor.count()
# for _ in range(cnt):
#     print(cursor.next())



# 데이터 조회
# 음식점 정보 중 id, borough, name, cuisine 만 출력

# cursor = rest.find( {  }, { 'id', 'borough', 'name', 'cuisine' } )
# for r in cursor:
#     print(r)



# 데이터 조회
# id, borough, name, cuisine 만 출력
# 단, 상위 10건만 출력

# cursor = rest.find( {}, { 'borough', 'name', 'cuisine' } ).limit(10)
# for r in cursor:
#     print(r)



# 데이터 조회
# id, borough, name, cuisine 만 출력
# 단, 26 ~ 40 사이의 데이터만 출력

# cursor = rest.find( {}, { 'borough', 'name', 'cuisine' } ).skip(25).limit(15)
# for r in cursor:
#     print(r)



# 데이터 조회
# id, borough, name, cuisine 만 출력
# 단, borough 순으로 정렬해서 출력

# from pymongo import ASCENDING       # 오름차순
# from pymongo import DESCENDING      # 내림차순
#
# cursor = rest.find( {}, { 'borough', 'name', 'cuisine' } ).limit(15).sort('borough', ASCENDING)
# for r in cursor:
#     print(r)



# 데이터 조회 - 자치구별 음식점 갯수는?

cursor = rest.aggregate([ { '$group': { '_id': '$borough', 'count': { '$sum': 1 } } } ])

for c in cursor:
    print(c)







client.close()
