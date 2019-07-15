# 미국 zipcode 컬렉션 데이터를 이용한 실습

# http://media.mongodb.org/zips.json


from pymongo import MongoClient
from pymongo import ASCENDING
from pymongo import DESCENDING


client = MongoClient('mongodb://192.168.180.133:27017')

db = client.bigdata
zips = db.zipcode


# 1. 우편번호 데이터 수를 조회하세요

# print(zips.count())
#
# cnt= zips.count()
# print(cnt)



# 2. 'MA' 주state 를 조회하세요

# cursor = zips.find({ 'state': 'MA' })
# for r in cursor:
#     print(r)


# 3. 'NY' 주state, New York 시city를 조회하세요

# cursor = zips.find({ 'state': 'NY', 'city': 'NEW YORK' })
# for r in cursor:
#     print(r)


# 3-1. NY state 또는 NEW YORK city를 조회

# cursor = zips.find({ '$or': [{ 'state': 'NY' }, { 'city': 'NEW YORK' }] })
# for r in cursor:
#     print(r)



# 4. 인구수pop가 100,000 이상인 지역을 조회하세요

# cursor = zips.find({ 'pop': { '$gte': 100000 } })
# for r in cursor:
#     print(r)


# 5. 전 지역의 총 인구수를 조회하세요
#    (aggregate 이용 - $sum)

# cursor = zips.aggregate([{ '$group': { '_id': '총인구', 'total': { '$sum':'$pop' } } }])
# for r in cursor:
#     print(r)


# 6. 각 지역state별 인구수를 조회하세요
#    (aggregate 이용 - $group, $sum)

# cursor = zips.aggregate([{ '$group': { '_id': '$state', '주별인구수': { '$sum':'$pop' } } }])
# for r in cursor:
#     print(r)

# 6-1.

# ursor = zips.aggregate([{ '$group': { '_id': '$state', '주별인구수': { '$sum':'$pop' } } }]).sort({ '주별인구수', DESCENDING })
# for r in cursor:
#     print(r)
# 위 방법으로는 오류!!!

# cursor = zips.aggregate([{ '$group': { '_id': '$state', '주별인구수': { '$sum':'$pop' } } },
#                         { '$sort' : { '주별인구수' : DESCENDING } }])
# for r in cursor:
#     print(r)



# 7. 각 도시city별 인구수를 조회하세요
#    (aggregate 이용 - $group, $sum)

# cursor = zips.aggregate([{ '$group': { '_id': '$city', '도시별인구수': { '$sum':'$pop' } } },
#                           { '$sort': { '도시별인구수': ASCENDING } }])
# for r in cursor:
#     print(r)


# 8. 인구수가 50,000이상인 도시를 조회하세요
#    (aggregate 이용 - $match)

# cursor = zips.find({ 'pop': { '$gte': 50000 } })
# for r in cursor:
#     print(r)

# cursor = zips.aggregate([{ '$match': { 'pop': { '$gte': 50000 } } }])
# for r in cursor:
#     print(r)


# 9. 인구가 1000만이상인 지역을 조회하세요
#    (aggregate 이용 - $group, $sum)

# cursor = zips.aggregate([{ '$group': { '_id': '$state', '주별인구수': { '$sum': '$pop' } } },
#                                 { '$match': { '주별인구수': { '$gte': 10000000 } } }])
# for r in cursor:
#     print(r)


# 10. 'NY' 지역의 인구수를 조회하세요
#   (aggregate 이용 - $group, $match, $sum)

cursor = zips.aggregate([{ '$match': { 'state': 'NY'} },
        { '$group': { '_id': '$state', '주별인구수': { '$sum': '$pop' } } }])
for r in cursor:
    print(r)

# cursor = zips.aggregate([{ '$group': { '_id': '$state', '주별인구수': { '$sum': '$pop' } } },
#                           { '$match': { 'state': 'NY'} }])
# for r in cursor:
#     print(r)



client.close()