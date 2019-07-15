import re

with open('data/02bestseller.html', 'r', encoding='utf-8') as f:
    html = f.read()

print(html)


css1 = r'<p class="book_tit"><a.*?</p>'
css2 = r'<p class="book_writer">.*?</p>'    # 작가

for part_html in re.findall(css1, html, re.DOTALL):
    title = re.sub(r'<.*?>', '', part_html)

    print(title)

for part_html in re.findall(css2, html, re.DOTALL):
    writer = re.sub(r'<.*?>', '', part_html)

    print(writer)