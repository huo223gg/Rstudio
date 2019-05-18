[04] 제어문과 함수
1. 제어문
(1) 연산자
산술연산자 : +, -, *, /, %%, ^, ** - 사칙연산, 나머지계산, 거듭제곱
관계연산자 : ==,!=,>,>=,<,<= - 동등비교, 크기비교
논리연산자 : &,|,!,xor() - 논리곱, 논리합, 부정, 배타적 논리합

#- 산술연산에서 %%는 나머지 계산이며, ^와 **는 거듭제곱을 나타낸다.
######### R 실습 -산술연산자 ############
num1 <- 100 # 피연산자1
num2 <- 20  # 피연산자2
result <- num1 + num2 # 덧셈
result # 120
result <- num1 - num2 # 뺄셈
result # 80
result <- num1 * num2 # 곱셈
result # 2000
result <- num1 / num2 # 나눗셈
result # 5

result <- num1 %% num2 # 나머지 계산
result # 0

result <- num1^2 # 제곱 계산(num1 ** 2)
result # 10000

result <- num1^num2 # 100의 20승
result # 1e+40 -> 1 * 10의 40승과 동일한 결과



#- 관계연산의 결과는 TRUE, FALSE값을 반환한다.
######### R 실습 - 관계연산자 ##############
# (1) 동등비교 
boolean <- num1 == num2 # 두 변수의 값이 같은지 비교
boolean # FALSE
boolean <- num1 != num2 # 두 변수의 값이 다른지 비교
boolean # TRUE

# (2) 크기비교 
boolean <- num1 > num2 # num1값이 큰지 비교
boolean # TRUE
boolean <- num1 >= num2 # num1값이 크거나 같은지 비교 
boolean # TRUE
boolean <- num1 < num2 # num2 이 큰지 비교
boolean # FALSE
boolean <- num1 <= num2 # num2 이 크거나 같은지 비교
boolean # FALSE



#- 논리연산의 배타적 논리합은 두논리값이 상반되는 경우는 TRUE, 같으면 FALSE값을
#  반환한다. 
######### R 실습 - 논리연산자###############
logical <- num1 >= 50 & num2 <=10 # 두 관계식이 같은지 판단 
logical # FALSE
logical <- num1 >= 50 | num2 <=10 # 두 관계식 중 하나라도 같은지 판단
logical # TRUE

logical <- num1 >= 50 # 관계식 판단
logical # TRUE
logical <- !(num1 >= 50) # 괄호 안의 관계식 판단 결과에 대한 부정
logical # FALSE

x <- TRUE; y <- FALSE
xor(x,y) # [1] TRUE
x <- TRUE; y <- TRUE
xor(x,y) # FALSE



(2) 조건문

- R에서는 if(), ifelse(), switch(), which() 함수를 이용하여 조건문을 작성할 수 있다.

1) if() 함수

########### R실습 ###################
x <- 10
y <- 5
z <- x * y
z

#if(조건식){ # 산술,관계,논리연산자
#   실행문1  <- 참
#}else{
#   실행문2  <- 거짓 
#}


if(x*y > 40){ # 산술 > 관계 > 논리 
  cat("x*y의 결과는 40 이상입니다.\n")  # \n 줄바꿈
  cat("x*y =", z, '\n')
  print(z)
}else{
  cat("x*y의 결과는 40 미만입니다. x*y =", z,"\n")
}


# 학점 구하기
score <- scan() #콘솔에서 값을 입력하고 Enter
score # 85

if(score >= 90){  # 조건식1
  result="A학점"  # 조건식1 참
}else if(score >=80){ # 조건식2
  result="B학점"  # 조건식1 거짓, 조건식2 참 
}else if(score >=70){
  result="C학점"
}else if(score >=60){
  result="D학점"
}else{
  result="F학점"
}  
cat("당신의 학점은 ",result)  # 당신의 학점은  B학점
print(result) 


# 2의 배수 연산 
10 / 2 # 5
10 %% 2 # 0



2)  ifelse() 함수
- ifelse(조건식,참인경우 처리문, 거짓인 경우 처리문)

# ifelse(조건, 참, 거짓) - 3항 연산자 기능

############# R 실습 #####################
score <- c(78, 95, 85, 65)
score
ifelse(score>=80, "우수","노력") #우수
# [1] "노력" "우수" "우수" "노력"


#ifelse() 응용
excel <- read.csv("data/04/excel.csv", header = T)
q1 <- excel$q1             # q1 변수값 추출
q1
ifelse(q1>=3, sqrt(q1), q1)  # 3보다 큰 경우 sqrt() 함수 적용

excel <- read.csv("data/04/excel.csv", header = T)
q1 <- excel$q1             # q1 변수값 추출
q1
ifelse(q1>=2 & q1<=4, q1^2, q1)   #1과 5만 출력, 나머지(2~4) 지수승



3) switch() 함수
- 비교문장의 내용에 따라서 여러개의 실행문장 중 하나를 선택할 수 있는 프로그램을 작성할 수 있다.
- switch(비교변수, 실행문1, 실행문2, 실행문3)
- 비교변수의 값이 실행문에 있는 변수와 일치할 때 해당 변수에 할당된 값을 출력한다.


switch("name", id="hong", pwd="1234",age=105, name="홍길동") 



4) which() 함수
- which()의 괄호내의 조건에 해당하는 위치(인덱스)를 출력한다.

##########  R 실습 #################
# 벡터에서 사용-> index값 리턴
name <- c("kim","lee","choi","park")
which(name=="choi") # 3

# 데이터프레임에서 사용 -> 행번호 리턴
no <- c(1:5)
name <-c("홍길동","이순신","강감찬","유관순","김유신")
score <- c(85,78,89,90,74)

exam <- data.frame(학번=no,이름=name,성적=score)
exam
which(exam$이름=="유관순") 




(3) 반복문

- R에서는 for()와 while()함수를 이용하여 반복문을 작성할 수 있다.

1) for() 함수
- for(변수 in 변수){실행문}
- 형식에서 in 뒤쪽에 있는 값을 in 앞쪽에 있는 변수에 순서대로 값을 넘기면서 반복을
수행한다. 

############# R 실습 ####################

# 반복문 - for(변수 in 값) {표현식} 
i <- c(1:10)
i #  1  2  3  4  5  6  7  8  9 10
d <- numeric() # 빈 vector(숫자)
for(n in i){ # 10회 반복
  print(n * 10) # 계산식(numeric만 가능) 출력
  print(n)
  d[n] <- n * 2 # d[1] = 2, ..... d[10]=20
}
d # 2  4  6  8 10 12 14 16 18 20


for(n in i){
  if(n%%2 != 0) 
    print(n) # %% : 나머지값 - 짝수만 출력
} 

for(n in i){  # 10 
  if(n%%2==0){
    next # 짝수면 skip
  }else{
    print(n) # 홀수만 출력
  }    
} 

# 벡터 데이터 사용 예
score = c(85, 95, 98)
name = c('홍길동', '이순신', '강감찬')

i <- 1         # 첨자로 사용되는 변수
for (s in score) {
  cat(name[i], " -> ", s, "\n")
  i <- i + 1   
} 


2) while() 함수
- while(조건){실행문}
#  while(조건){표현식}
i = 0
while(i < 10){
  i <- i + 1  # 카운터 변수 
  print(i) # 1~10까지 출력됨
}



2. 함수
- 함수는 코드의 집합을 의미한다.

(1) 사용자 정의 함수 
- 함수명 <- function(매개변수) {실행문}
- 매개변수는 외부에서 값을 받아서 처리할때 이용한다.

############# R 실습 ####################

f1 <- function(){
  cat("매개변수가 없는 함수")
}

f1() # 함수 호출 

# 매개변수가 있는 함수 예
f2 <- function(x){ # 가인수 
  cat("x의 값 = ",x, "\n") # \n 줄바꿈
  print(x) # 변수만 사용
}

f2(10) # 실인수 


# 리턴값이 있는 함수 예
f3 <- function(x, y){
  add <- x + y # 덧셈 
  return(add) # 결과 반환 
}

add <- f3(10, 20)
add




(2) 기술통계량을 계산하는 함수 정의

- 추론통계의 기초 정보를 제공하는 요약 통계량, 빈도수 등의 기술 통계량을 계산하는 함수


############# R 실습 ####################
test <- read.csv("data/04/test.csv", header=TRUE)
head(test)

# A 칼럼 요약통계량, 빈도수 구하기 
summary(test) # 요약통계량
table(test$A) # A변수 대상 빈도수 
max(test$A) # 최고 빈도수 
min(test$A) # 최소 빈도수 

# 각 칼럼 단위 요약통계량과 빈도수 구하기
data_pro <- function(x){
  
  for (idx in 1 : length(x)){
    cat(idx,'번째 칼럼의 빈도분석 결과')
    print(table(x[idx]))
    cat('\n')
  }
  for (idx in 1 : length(x)){
    f <- table(x[idx])
    cat(idx,'번째 칼럼의 최댓값/최솟값\n')
    cat("max =", max(f), "min =", min(f), '\n')
  }
}

data_pro(test) #함수 호출

#- 표본분산 식 : var = sum((x-산술평균)^2) / (변량의 개수-1)
#- 표본 표준편차 식 : sqrt(var)  - 표본분산에 루트 적용

# 분산과 표준편차를 구하는 함수 정의
x <- c(7, 5, 12, 9, 15, 6) # x 변량 생성 
var_sd <- function(x) {
  var <-  sum( (x-mean(x))^2 ) / (length(x) - 1) # 표본분산 
  sd <- sqrt(var)  # 표본 표준편차 
  cat('표본분산 : ', var, '\n')
  cat('표본 표준편차 :', sd)
}

var_sd(x) 




(3) 결측치 자료 평균 계산 함수 정의

- 결측치 데이터를 대상으로 평균을 구하기 위해서는 먼저 결측치를 처리한후
평균과 관련함수를 이용하여 평균을 계산한다.


############# R 실습 ####################
#결측치 데이터 처리 함수
na <- function(x){
  #1차 : NA 제거 
  print(x)
  print( mean(x, na.rm = T) )
  
  #2차 : NA를 0으로 대체  
  data = ifelse(!is.na(x), x, 0) # NA이면 0으로 대체
  print(data)
  print(mean(data))
  
  # 3차 : NA를 평균으로 대체 
  data2 = ifelse(!is.na(x), x, round(mean(x, na.rm=TRUE), 2) ) # 평균으로 대체 
  print(data2)
  print(mean(data2))
}
na(data) #함수 호출

-------------------------------------------------------------------------------------
  ※ 혼자 해보기 ※
Q1. 다음 조건에 맞게 client 데이터프레임을 생성하고, 조건에 맞게 처리하시오.
<vector 준비>
  name <-c("유관순","홍길동","이순신","신사임당")
gender <- c("F","M","M","F")
price <-c(50,65,45,75)

조건1) 다음 3개 벡터 객체를 이용하여 client 데이터프레임을 생성하시오.


조건2) price 변수의 값이 65만원 이상이면 문자열 "Best", 65만원 미만이면 문자열
"Normal"을 변수 result에 추가하시오. 힌트) ifelse() 함수 이용


조건3) result 변수를 대상으로 빈도수를 구하시오. 

--------------------------------------------------------------------------------------------------