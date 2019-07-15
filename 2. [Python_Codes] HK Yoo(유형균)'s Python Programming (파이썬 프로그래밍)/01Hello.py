print('Hello, World!!')




# ex 8) 구구단의 단을 입력 받으면 해당 단을 출력하세요
# 7 X 1 = 7
# ... ...
# 7 X 9 = 63

for i in range(1, 9 + 1):
    print('7 x %d = %d' % (i, 7 * 1))


dan = int(input('출력할 단을 입력하세요 : '))

for i in range(1, 9 + 1):
    print('%d x %d = %d' % (dan, i, dan * i))


## 중첩 반복문

# 여러개 반복문을 겹쳐서 작성하는 방식
# 일차원 리스트를 사용하는 경우 반복문은 하나만 사용해서 각 리스트의 원소를 조회

# 한편, 2차원 리스트의 경우 반복문은 2개를 사용해야 각 리스트의 원소를 조회가능
# 즉, 각 행과 열을 변화시키기 위해 반복문 2개를 사용함

for i in range(1,5):
    for j in range(1,5):
        print(i, j, end = '')
    print()



# ex 9) 중첩for문을 이용해서 구구단을 출력하세요

# 2 x 1 = 2  3 x 1 = 1  ... ... 8 x 1 = 8   9 x 1 = 9
# 2 x 2 = 4  3 x 2 = 6  ... ... 8 x 2 = 16  9 x 2 = 18
# ... ...
# 2 x 8 = 16  3 x 8 = 24  ... ... 8 x 8 = 64   9 x 8 = 72
# 2 x 9 = 18  3 x 9 = 27  ... ... 8 x 9 = 72   9 x 9 = 81

# 먼저 구구단의 1행을 출력

for i in range(2, 9+1):
    print('%d x %d = %d' % (i, 1, i*1), end = '\t')
print()


# 구구단의 나머지 행을 출력

for j in range(1, 9+1):
    for i in range(2, 9+1):
        print('%d x %d = %d' % (i, j, i*j), end = '\t')
    print()



# 구구단 출력시 각 자리 여백 지정

for j in range(1, 9+1):
    for i in range(2, 9+1):
        print('%d x %d = %2d' % (i, j, i*j), end = '\t')
    print()



# ex 10) 중첩for문을 이용해서 12단을 출력하세요

for i in range(1, 12+1):
    for j in range(2, 12):
        print('%d x %2d = %3d' % (j, i, i*j), end = '\t')
    print()
