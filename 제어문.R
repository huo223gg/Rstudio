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

#ifelse() 응용
excel <- read.csv("data/04/excel.csv", header = T)
q1 <- excel$q1             # q1 변수값 추출
q1
ifelse(q1>=3, sqrt(q1), q1)  # 3보다 큰 경우 sqrt() 함수 적용

excel <- read.csv("data/04/excel.csv", header = T)
q1 <- excel$q1             # q1 변수값 추출
q1
ifelse(q1>=2 & q1<=4, q1^2, q1)   #1과 5만 출력, 나머지(2~4) 지수승
switch("name", id="hong", pwd="1234",age=105, name="홍길동") 

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

############# R 실습 ####################

f1 <- function(){
  cat("매개변수가 없는 함수입니다.111111")
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


test <- read.csv("data/04/test.csv", header=TRUE)
head(test)

# A 칼럼 요약통계량, 빈도수 구하기 
summary(test) # 요약통계량
table(test$A) # A변수 대상 빈도수 
max(test$A) #  
min(test$A) # 


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


test[1]

x <- c(7, 5, 12, 9, 15, 6) # x 변량 생성 
var_sd <- function(x) {
  var <-  sum( (x-mean(x))^2 ) / (length(x) - 1) # 표본분산 
  sd <- sqrt(var)  # 표본 표준편차 
  cat('표본분산 : ', var, '\n')
  cat('표본 표준편차 :', sd)
}

var_sd(x) 





