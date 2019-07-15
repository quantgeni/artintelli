# ex) 온라인 도서 쇼핑몰의 도서 정보를 스크래핑

# hanbit.co.kr > store > bestseller > 도서목록의 제목, 작가 추출
# 웹 문서 저장시 파일명은 02bestseller.html
# http://www.hanbit.co.kr/store/books/bestseller_list.html


from urllib.request import urlopen

url = 'http://www.hanbit.co.kr/store/books/bestseller_list.html'
docs = urlopen(url)

encode = docs.info().get_content_charset()
text = docs.read().decode(encode)


with open('data/02bestseller.html','w', encoding='utf-8') as out:
    out.write(text)

print(text)











