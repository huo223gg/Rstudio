[02] R 자료형, 자료구조
1. R 자료형 

(1) 자료형과  특수한 형태값

1) 통계 자료형


① 이산형 (수치형)
- 셀 수 있으며 정수를 나타낸다.  
- 값들이 서로 이어져 있지 않다.
- 예) 1명, 2명, 3명 등 서로 독립적이고 이어져 있지 않다.

② 연속형 (수치형)
- 데이터가 연속적인 수치값이다.  주로 실수값이다.
- 예) 175.2cm, 180.12cm 등 키를 나타내는 데이터는 연속형 데이터이다.
- 175~176사이에는 많은수가 존재한다. 떼어낼 수 없는 독립적이지 않은 값으므로
연속형이라 한다.
- 숫자가 크기를 지니고 있기 때문에 더하기, 빼기, 평균 구하기 등 산술이 가능하다.
- 연속 변수는 '양적 변수' 라고도 하며 R 에서 연속변수는 numeric으로 표현한다.

③ 명목형 (범주형)
- 값이 대상을 분류하는 의미를 지니는 변수 이다.
예) 성별변수 남자는 1, 여자는 2로 각 범주를 분류한다.
숫자가 크기를 의미하지 않기 때문에 더하기, 빼기, 평균을 구하는 산술을 할 수 없다.

- 범주 변수는 숫자가 대상을 지칭하는 이름과 같은 역할을 하기 때문에 '명목변수' 라고도 하며,
R에서  범주 변수는 factor로 표현한다.
- 문자형태 이며, 카테고리(범주)를 정해 분류한다고 생각할 수 있다.
예) 성별 카테고리, 종교 카테고리, 혈액형 카테고리 등 

- 카테고리는 level이라 부르며, level이 '남', '여' 로 정해졌다면 데이터에  ['남', '남','여','소녀']
'소녀'가 들어가면 안된다.
- level은 데이터 생성시 명시할 수 있다.
- 예)성별(남,여), 종교(기독교, 불교등), 혈액형(O, AB, B, A)
- 때로는 남,여를 1,2의 숫자로 대신 사용하여 통계분석을 하는경우가 있다.


##### R에서 범주형 실습#######
#
# - 아래 gender의 값은 f이고 범주는 m,f  2개이다.
# - m,f는 범주형 변수이다.

gender = factor("f", c("m","f"))
gender


# - 범주의 값을 확인
# - levels() 함수로 범주의 값을 변경할 수 있다.

levels(gender)
levels(gender)[1]
levels(gender)[2]

gender

levels(gender)<- c("male", "female")
gender

#############################

④ 순서형 (범주형)
- 명목형과 비슷하다, 단지 순서가 있다.
- 예) A+, A-, B+,B-,C+,C-, D+,D-,F 


##### R에서 범주형 실습#######
#
# - ordered()함수를 이용하여 명목형 변수의 level에 순서를 적용할 수 있다.
# - factor()에서는 ordered=TRUE라고 지정한다.

ordered(c("a","b","c","d"))

factor(c('a','b','c','d'), ordered=TRUE)

#-----------------------------------------------------------------
var1 <- c(1,2,3,1,2) #numeric 변수 생성

var2 <- factor(c(1,2,3,1,2)) #factor변수 생성

var1 # #numeric 변수 출

#  [1] 1 2 3 1 2

var2 # factor 변수 출력

#  [1] 1 2 3 1 2
#  Levels: 1 2 3


#- factor는 Levels라는 범주에 해당하는 1, 2, 3의 정보를 지닌다.
#- numeric 변수는 연산이 가능하지만, factor 변수로는 연산이 불가능하다.

var1 + 2 #numeric 변수 연산

# [1] 3 4 5 3 4

var2 + 2 #factor 변수 연산

# 1] NA NA NA NA NA
# Warning message:
# In Ops.factor(var2, 2) : 요인(factors)에 대하여 의미있는 ‘+’가 아닙니다.



#- class()를 이용하여 변수의 타입이 무엇인지 확인할 수 있다.

class(var1)

#[1] "numeric"

class(var2)

#[1] "factor"


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




2) 변수 타입 바꾸기

##### R에서 실습#######
#
mean(var1) #var1 변수 데이터 평균 구하기

#  [1] 1.8

mean(var2) #var2 변수 데이터 평균 구하기 -> factor 타입은 평균을 구할 수 없다

# [1] NA
# Warning message:
# In mean.default(var2) :
#  인자가 수치형 또는 논리형이 아니므로 NA를 반환합니다


# factor 타입을 numeric타입으로 변환
var2 <- as.numeric(var2)

mean(var2) #평균구하기
# [1] 1.8


- 변환함수
as.numeric()      :  numeric으로 변환
as.factor()         :  factor으로 변환
as.character()     :  character으로 변환
as.Date()           :  Date으로 변환
as.data.frame()   :  data.frame 으로 변환



3) 기본 자료형
- 문자형(character) :문자, 문자열
- 범주형(factor) : 범주
- 실수형(numeric, double) - 1, 20, 3.14, 2.1
- 정수형(integer) - 1L, 20L (L부호는 정수형으로 데이터를 저장하도록 R에게 일러준다)  
- 복소수형(complex) : 실수 + 허수
- 논리형 (logical) : TRUE(T), FALSE(F)
- 날짜형(date) : "2017-04-16", "17/04/15"


4) 특수한 형태의 값
- NULL : 데이터의 값이 존재하지 않는다는 의미이다.
- NA : missing value, 결측값, 손실된값으로 값이 없음을 의미한다.
하나의 요소의 의미
- NaN(not a number) :수학적으로 정의되지 않은 값
- Inf, -Inf :무한대


- mode(), typeof() : 자료형 확인

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

-------------------------------------
  > mode(1)
[1] "numeric"
> mode(1L)
[1] "numeric"
> mode(3.24)
[1] "numeric"
> mode(1L)
[1] "numeric"
> mode(TRUE)
[1] "logical"
> mode('홍길동')
[1] "character"
> mode(3+4i)
[1] "complex"
> typeof(1)
[1] "double"
> typeof(2.3)
[1] "double"
> typeof(1L)
[1] "integer"
> typeof(1)
[1] "double"
> typeof(TRUE)
[1] "logical"
> typeof('홍길동')
[1] "character"
> typeof(3+4i)
[1] "complex"
> 
  
  참고) RStudio console 지우기: CRT + L

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
--------------------------------------------------
  
  
  (2) 자료구조  

- 벡터(vector)
- 배열(array)
- 행렬(matrix)
- 리스트(list)
- 데이터프레임(data frame)

1) 벡터(Vectors)
- 벡터가 R에서 가장 일반적이고 기본이 되는 자료구조다. 
- 벡터는 character, logical, integer, numeric을 요소로 갖는 집합(collection)이다.
- 한 벡터 내의 타입은 항상 같아야 한다.
- 벡터를 만드는 가장 간단한 방법이 c()함수 이다.
- 숫자형 데이터인 경우 시작값:끝값 형태와 seq(from,to,by)로 사용이 가능하다.

- seq_along() : 주어진 인자데이터 길이 만큼 1,2,3,...길이까지 벡터로 변환된다.
- seq_len() : 주어진 인자값까지 1,2,3, ... 인자값까지 벡터로 변환한다.
- rep() :  일정한 패턴들을 반복적으로 사용하여 벡터를 만든다.

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

# - names()함수로 이름을 부여할 수 있다.
x<-c(1,3,5,7)
names(x)<-c("noh","kim","park","baek")
x 


# - 벡터의 데이터는 [인덱스]로 요소를 가져온다. 인덱스는 1부터 시작
# - 벡터의 여러개의 데이터를 가져오기 위해 벡터의 형식을 사용한다.

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

#- 벡터의 길이를 알아내는 함수로는 length(), NROW()이다.
NROW()는 행렬에서 사용하는 함수이므로 N행 1열로 취급한다.

length(x)
NROW(x) #대문자 사용

#- %in%을 사용하여 벡터에 포함된 값을 확인할 수 있다.
'c' %in% c('a','b','c','d') #TRUE
'e' %in% c('a','b','c','d') #FALSE


2) 배열(Array)
- 벡터와 행렬의 값을 나타낸다.
- 한가지 형태의 자료형의 값으로 구성되어 있다.
- 문자와 숫자를 혼합에서 사용하면 에러가 발생한다.
- 1차원 배열은 벡터,  2차원 배열은 행렬이라 한다.
- 3차원 이상의 차원 구조도 가능하다.
- dim은 dimension의 약자로 차원이란 뜻이다.
- length로 배열의 크기를 알 수 있다.
- 배열의 생성은 dim(), array()를 사용한다.  

##### R에서 실습#######
#
array(1:20,dim=c(4,5))
array(1:20,dim=c(4,4,3))
array(1:6) 
array(1:6, c(2,3)) 

arr <- c(1:24)                       #1~24의 자료 생성
dim(arr) <- c(3,4,2)                #dim() 함수를 이용하여 3행 4열의 행렬 2개 생성
arr                   


#- 같은 크기의 배열간의 사칙연산 및 같은 위치의 원소간의 연산을 수행할 수 있다. 
#- 숫자와 배열 또는 배열과 숫자간의 산술 연산도 가능하다.

ary1 <- array(1:8, dim = c(2,2,2))  
ary2 <- array(8:1, dim = c(2,2,2))
ary1
ary2
ary1 + ary2
ary1 * ary2
ary1 %*% ary2               #두 배열 원소들의 곱의 합
sum(ary1 * ary2)           #위의 결과와 같음
?sum                            #sum() 확인

#- 배열의 원소를 추출하는 방법은  “,”로 구분하여 차원의 인덱스를 기술하면 된다.
ary1                             #2행2열2면의 모든 값 출력
ary1[,,1]                        #1면의 값만 출력
ary1[1,1,]                      #1면1행1열,2면1행1열 값 출력
ary1[1,,-2]                     #2면을 제외한 1행의 값
ary1[,1,-1]                     #1면을 제외한 1열의 값



3) 행렬(matrix)
- 표형식의 데이터를 분석함수를 통해 사용하기 위해 행렬화 해서 사용한다.
- 행렬은 metrix()함수를 이용하여 생성한다.
- 벡터에 차원을 추가하여서도 행렬을 만들수 있다.

##### R에서 실습########
a<-1:9
a
dim(a) <- c(3,3)
a

mat1 <- matrix(1:10, nrow=2)      #1~10 2개의 행으로 만든다.
mat1

mat2 <- matrix(1:10, ncol = 2)     #1~10 2개의 열로 만든다.
mat2

# 행과 열 이름 주기
names <- list(c("1행", "2행"), c("1열", "2열", "3열"))

matrix(1:6, nrow=2, byrow=TRUE, dimnames=names) #행을 우선적으로 만든다.

# 벡터 결합에 의한 행렬 만들기
v1 <- c(1, 2, 3, 4)
v2 <- c(5, 6, 7, 8)
v3 <- c(9, 10, 11, 12)
x <- cbind(v1, v2, v3)   #열로 결합
x

# 행과 열 이름 주기
rownames(x) <- c("1행", "2행", "3행", "4행")
x

colnames(x) <- c("1열", "2열", "3열")
x

rbind(v1, v2, v3)       #행으로 결합





4) 리스트(list)
- 여러데이터 타입을 가지는 데이터 구조이다.
- C의 구조체,Python의 dict, Java Map구조와 유사하다.
- key를 통해서 value를 불러올수 있는데, value에 해당하는 자료는 Vector,Marix,Array,
List, DataFrame등 대부분 R 자료구조의 객체가 저장될 수 있다.
- 함수내에서 여러 값을 하나의 키로 묶어서 반환하는 경우 유용하다.
- list()함수로 리스트를 생성한다.
- list 자료 처리함수: unlist(),lapply(),sapply()

① 일차원 List 객체 생성
- List에 저장된 데이터를 출력하면 [[n]]과 [n]형식으로 출력하는데, 여기서[[n]]은
리스트를 구성하는 하나의 원소에서 key에 해당하고, [n]은 value에 해당한다.
또한[[n]]에서 n은 리스트 자료구조에 저장된 자료의 위치를 의미한다.

##### R에서 실습########
x <- list("홍길동",
          "2016001",
          20,
          c("IT융합", "데이터 관리"))
x
#[[1]]
#[1] "홍길동"

#[[2]]
#[1] "2016001"

#[[3]]
#[1] 20

#[[4]]
#[1] "IT융합"      "데이터 관리"


x[[1]]

x[1]


- 벡터 구조로 변경 : unlist()사용
리스트 자료구조에 다량의 데이터가 저장되는 경우 리스트 형태([[n]])로 출력 하면
여러줄로 콘솔에 출력되기 때문에 벡터형식으로 자료구조를 변경하면 자료 처리가
쉬워진다. 이때 벡터 자료구조의 특성 때문에 20은 문자열로 처리된다.

##### R에서 실습########   
x = unlist(x)
x
#[1] "홍길동"      "2016001"     "20"          "IT융합"     
#[5] "데이터 관리"


#- key와 value형식으로 리스트 생성

y <- list("성명"="홍길동",
          "학번"="2016001",
          "나이"=20,
          "수강과목"=c("IT융합","데이터 관리"))

y

# 동일한 결과
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


② List 객체의 자료처리 함수
- lapply(c(a,b),max) : a,b를 대상으로 max함수를 적용해서 리스트형으로 반환한다.
- sapply(c(a,b),max) : a,b를 대상으로 max함수를 적용해서 벡터형으로 반환한다.
- max는 처리할 함수는 어떤한 것이라도 가능하다.

a = list(c(1:5))
b = list(6:10)
a;b

> lapply(c(a,b),max)
[[1]]
[1] 5

[[2]]
[1] 10

> sapply(c(a,b),max)
[1]  5 10


③ 다차원 리스트 객체 생성
- 리스트자료구조에 리스트가 중첩된 자료구조를 다차원(중첩)리스트라고 한다.

multi_list = list(c1=list(1,2,3),
                  c2=list(10,20,30),
                  c3=list(100,200,300))

> multi_list$c1; multi_list$c2; multi_list$c3
[[1]]
[1] 1

[[2]]
[1] 2

[[3]]
[1] 3

[[1]]
[1] 10

[[2]]
[1] 20

[[3]]
[1] 30

[[1]]
[1] 100

[[2]]
[1] 200

[[3]]
[1] 300

- 다차원 리스트를 열단위로 바인딩 : do.call()
다차원 리스트를 대상으로  do.call()를 적용하면 3개의 키와 3개의 value로 구성하는 리스트 자료가
열단위로 묶여서 matrix객체가 생성된다. 
특히, 다차원 리스트를 구성하는 리스트를 각각 분해 후 지정한 함수(cbind)를 호출하여 리스트
자료를 처리하는데 효과적이다.

> do.call(cbind,multi_list)
c1 c2 c3 
[1,] 1  10 100
[2,] 2  20 200
[3,] 3  30 300
> multi = do.call(cbind,multi_list)
> class(multi)
[1] "matrix"




5) 데이터프레임(data frame)
- 동일한 속성들을 가지는 여러개체들로 구성되며, 각 속성들의 데이터 유형은 서로
다를 수 있다.
- 데이터 프레임은 data.frame() 함수로 생성한다.

# 두 명의 고객 정보에 대한 데이터 프레임 만들기
x <- data.frame(성명=c("홍길동", "손오공"),
                  나이=c(20, 30),
                  주소=c("서울", "부산"))
x

# 동일한 결과
x <- data.frame("성명"=c("홍길동", "손오공"),
                "나이"=c(20, 30),
                "주소"=c("서울", "부산"))

# 열과 행 단위 추가
x<- cbind(x, 학과=c("e-비즈", "경영"))
x

x<- rbind(x, data.frame(성명="장발장",
                          나이=40,
                          주소="파리",
                          학과="행정"))
x

# 요소 값 보기

x["성명"]

x$성명



--------------------------------------------------------------------
  ※ 혼자서 해보기 ※
- 아래 네개의 분석 문제 해결해 보세요
- 변수명 score , 점수: 90, 89, 77, 74, 98

Q1 다섯명의 학생 시험점수를 담고 있는 변수를 만드시오.

Q2 전체 평균구하시오.(mean())

Q3 전체 평균 변수 만들고 출력하시오.

Q4 다음과 같은 벡터 객체를 생성하시오. 
조건1) 벡터 변수 Vec1을 만들고, "R" 문자가 5회 반복되도록 하시오. 
조건2) 벡터 변수 Vec2에 1~10까지 3간격으로 연속된 정수를 만드시오.
조건3) 벡터 변수 Vec3에 1~10까지 3간격으로 연속된 정수가 3회 반복되도록 만드시오.
조건4) 벡터 변수 Vec4에는 Vec2~Vec3가 모두 포함되는 벡터를 만드시오. 
조건5) 25 ~ -15까지 5를 간격으로 seq() 함수를 이용하여 벡터를 생성하시오. (첨자이용)


---------------------------------------------------------------------