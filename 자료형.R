##### R에서 범주형 실습#######
#
# - 아래 gender의 값은 f이고 범주는 m,f  2개이다.
# - m,f는 범주형 변수이다.

gender = factor("f",c("m","f"))
gender

levels(gender)[2]

levels(gender) = c("male","female")
levels(gender)
gender

##### R에서 범주형 실습#######
#
# - ordered()함수를 이용하여 명목형 변수의 level에 순서를 적용할 수 있다.
# - factor()에서는 ordered=TRUE라고 지정한다.

ordered(c("a",'b','c','d'))
factor(c('a','b','c','d'),ordered = T)


var1 <- c(1,2,3,1,2) #numeric 변수 생성

var2 <- factor(c(1,2,3,1,2)) #factor변수 생성

var1 # #numeric 변수 출

#  [1] 1 2 3 1 2

var2 # factor 변수 출력

#  [1] 1 2 3 1 2
#  Levels: 1 2 3

var1 + 2
var2 + 2

class(var1)
class(var2)

#- factor 변수의 구성 범주 확인하기

levels(var1)

# NULL

levels(var2)

# [1] "1" "2" "3"

# - 문자로 구성된 factor 변수

var3 <- c("a","b","b","c")   #문자변수 생성

var4 <- factor(c("a","b","b","c")) #문자로 된 factor 변수 생성

var3

#[1] "a" "b" "b" "c"

var4

#[1] a b b c
#Levels: a b c

class(var3)  #var3변수 타입확인

#[1] "character"

class(var4) #var4변수 타입확인

#[1] "factor"

mean(var1)

mean(var2)

var2 = as.numeric(var2)

mean(var2)

mode(1)
mode(1L)
mode(3.24)
mode(TRUE)
mode('홍길동')
mode(3+4i)
typeof(1)
typeof(2.3)
typeof(1L)
typeof(1)
typeof(TRUE)
typeof('홍길동')
typeof(3+4i)

one = 100
two = 90
three = 80
four = 70
five = NA
is.na(five)


x=NULL
y=10
is.null(x)
is.null(y)
is.na(NULL)

##### R에서 실습#######
#
x<- c(1,2,3,4,5,6,7,8,9,10)
x
c('1','2','3','4',c('1','2','3','4','5'))

x<-1:10
x
x<-2:9
x
seq(1,10,2)
seq(5,8)

seq_along(c('a','b','c','d')) #1,2,3,4
seq_len(5) #1,2,3,4,5

rep(1:3,5) #rep(1:3,time=5) 1:3형식을 5번 반복하여 벡터 생성
rep(1:5, each=3) #1~5까지 각각의 수를 3번씩 반복하여 벡터를 생성

x = c(1,3,5,7)
x
names(x)=c("noh",'kim','park','baek')
x

x<- c('a','b','c','d')
x[1]
x[4]

x[c(1,3)] #1,3인덱스의 값이 추출된다.
x[c(2,4)] #2,3인덱스이 값

x[c(1:3)] #1~3까지 모든인덱스의 값이 추출된다.
x[c(2:4)]

#- [- ] 음수의 인덱스를 사용하여 특정한 요소를 제거하고 가져온다.
x[-3] #'c'만빼고 x를 가져온다.
x[-1] #'a'만빼고 x를 가져온다.

length(x)
NROW(x) #대문자 사

'c' %in% c('a','b','c','d')
'e' %in% c('a','b','c','d')

##### R에서 범주형 실습#######
#
array(1:20,dim=c(4,5))
array(1:20,dim=c(4,4,3))
array(1:6) 
array(1:6, c(2,3)) 

arr <- c(1:24)                       #1~24의 자료 생성
dim(arr) <- c(3,4,2)                #dim() 함수를 이용하여 3행 4열의 행렬 2개 생성
arr                   

ary1 = array(1:8, dim=c(2,2,2))
ary2 = array(8:1, dim=c(2,2,2))
ary1;ary2
ary1 + ary2
ary1 * ary2
ary1 %*% ary2
sum(ary1*ary2)

?sum

ary1                             #2행2열2면의 모든 값 출력
ary1[,,1]                        #1면의 값만 출력
ary1[1,1,]                      #1면1행1열,2면1행1열 값 출력
ary1[1,,-2]                     #2면을 제외한 1행의 값
ary1[,1,-1]                     #1면을 제외한 1열의 값

a<-1:9
a
dim(a) <- c(3,3)
a

mat1 <- matrix(1:10, nrow=2)      #1~10 2개의 행으로 만든다.
mat1

mat2 <- matrix(1:10, ncol = 2)     #1~10 2개의 열로 만든다.
mat2


names <- list(c("1행", "2행"), c("1열", "2열", "3열"))

matrix(1:6, nrow=2, byrow=TRUE, dimnames=names) #행을 우선적으로 만든다.


v1 <- c(1, 2, 3, 4)
v2 <- c(5, 6, 7, 8)
v3 <- c(9, 10, 11, 12)

x = cbind(v1,v2,v3)
x
rownames(x) = c('1행','2행','3행','4행')
colnames(x) = c('1열','2열','3열')
x
rbind(v1,v2,v3)

x <- list("홍길동",
          "2016001",
          20,
          c("IT융합", "데이터 관리"))
x

x = unlist(x)
x

y <- list(성명="홍길동",
            학번="2016001",
            나이=20,
            수강과목=c("IT융합", "데이터 관리"))


# 객체 값의 출력
y["성명"]
#$성명
#[1] "홍길동"

y$성명
#[1] "홍길동"

y[[2]]
#[1] "2016001"
y[2]
#$학번
#[1] "2016001"

y$수강과목
#[1] "IT융합"      "데이터 관리"

y$수강과목[1]
#[1] "IT융합"

y$수강과목[2]
#[1] "데이터 관리"

length(y)      #y리스트의 갯수
#[1] 4

mode(y); class(y)     #y리스트의 자료형과 자료구조
#[1] "list"
#[1] "list"

a = list(c(1:5))
b = list(6:10)
a;b

lapply(c(a,b), max)

c = sapply(c(a,b), max)

multi_list = list(c1=list(1,2,3),
                  c2=list(10,20,30),
                  c3=list(100,200,300))

multi_list$c1; multi_list$c2; multi_list$c3

multi = do.call(cbind,multi_list)

class(multi)

x = data.frame(성명=c('홍길동','손오공'),
              나이=c(20,30),
              주소=c('서울','부산')
                 )
x

x= cbind(x,학과=c('e-비즈','경영'))
x
x = rbind(x,data.frame(
            성명="장발장",
            나이=40,
            주소="파리",
            학과="행정"))
x
x["성명"]
x$성명


# ※ 혼자서 해보기 ※
# - 아래 네개의 분석 문제 해결해 보세요
# - 변수명 score , 점수: 90, 89, 77, 74, 98
   
# Q1 다섯명의 학생 시험점수를 담고 있는 변수를 만드시오.
score = c(90, 89, 77, 74, 98)
# Q2 전체 평균구하시오.(mean())
mean(score)
# Q3 전체 평균 변수 만들고 출력하시오.
 mean_score = mean(score) 
 mean_score
# Q4 다음과 같은 벡터 객체를 생성하시오. 
# 조건1) 벡터 변수 Vec1을 만들고, "R" 문자가 5회 반복되도록 하시오.(rep) 
 vec1 = rep('R',5)
# 조건2) 벡터 변수 Vec2에 1~10까지 3간격으로 연속된 정수를 만드시오.(seq)
 vec2= seq(1,10,3)
# 조건3) 벡터 변수 Vec3에 1~10까지 3간격으로 연속된 정수가 3회 반복되도록 만드시오.(rep)
 vec3 = rep(seq(1,10,3),3)
# 조건4) 벡터 변수 Vec4에는 Vec2~Vec3가 모두 포함되는 벡터를 만드시오.c() 
 vec4 = c(vec2,vec3)
# 조건5) 25 ~ -15까지 5를 간격으로 seq() 함수를 이용하여 벡터를 생성하시오. ()
# 
 seq(25,-15,-5)



































