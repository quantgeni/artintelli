## 산술 연산자

# 더하기, 빼기, 곱하기, 나누기, 거듭제곱, 몫, 나머지등을 구함

# 참고 => 연산자 우선순위 

3 + 4
3 - 4
3 * 4
3 / 4

3 ** 4    # 거듭제곱
3 ^ 4

13 %/% 4  # 몫
13 %% 4   # 나머지




## 할당 연산자

# 객체(변수)에 어떤 값을 저장할때 사용

x <- 3    # 되도록이면 R 에서는 화살표를 쓴다
y <- 4

x + y
x - y
x * y
x / y


a = 3     # 파이썬에서 사용
b = 4

a + b 
a - b
a * b
a / b


3 -> l    # 가독성이 떨어지고 키보드 움직임이 불편함
4 -> m

l + m
l - m
l * m
l / m



# 비교 연산자

# 두 닶을 비교할 때 사용
# 서같으면 TRUE, 다르면 FALSE

x == y
x != y
!(x == y)   # 부정
!(x != y)

x > y
x >= y
x < y
x <= y



# 논리 연산자

# 2개 이상의 조건을 비교하여 결과 출력

# && : 모든 조건이 참 일때 결과가 참, AND
# || : 모든 조건중 하나가 참 일때 결과가 참, OR
# &&, || 은 &, | 에 비해 short-circuit 가 지원

# short-circuit : 단축 평가
# 첫번째 조건 평가만으로 결과가 확실할 때 
# 나머지 조건 평가는 생략하는 방식


TRUE && TRUE
TRUE && FALSE
FALSE && TRUE
FALSE && FALSE


TRUE || TRUE
TRUE || FALSE
FALSE || TRUE
FALSE || FALSE


0 && 0    # 0 은 FALSE, 1은 TRUE
0 && 1
1 && 0
1 && 1

0 || 0
0 || 1
1 || 0
1 || 1


# ex) a, b, c, d 가 각각 20, 10, 30, 15 일 때,
#     다음에 대한 논리연산을 구행하세요
# a > b and c > d
# a > b and c < d
# a > b or c > d
# a > b or c < d
# not (a > b)
# not (b < d)

a <- 20
b <- 10
c <- 30
d <- 15

a > b && c > d
a > b && c < d
a > b || c > d
a > b || c < d
!(a > b)
!(b < d)





























