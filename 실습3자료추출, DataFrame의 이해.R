[03] 자료추출, DataFrame의 이해
1. 자료 추출
- 패키지를 사용하지 않고 R에 기본적으로 제공되는 기능을 사용하여 데이터를 추출한다.

(1) 행번호로 행 추출하기
- csv_exam.csv 파일을 활용해 내장 된 기능으로 데이터 추출한다.
- []를 붙여 조건을 입력한다.
- []안의 숫자는 index를 나타내며 이것은 데이터의 위치 또는 순서를 위미한다.
- [1,] : 첫 번째 행을 가리키게 된다.
- 인덱스를 이용해 데이터를 추출하는 작업을 인덱싱(indexing) 이라 한다.


exam <- read.csv("data/csv_exam.csv")

exam[] # 조건없이 전체 데이터 출력

exam[1,] # 1행 추출

exam[2,] # 2행 추출



(2) 조건을 충족하는 행 추출하기
- 쉼표 왼쪽에 조건을 입력하면 조건에 맞는 행을 추출한다.
- []안에 &와 | 를 사용해 여러 조건을 충족하는 행을 추출할 수 있다.


# 1반 이면서 수학 점수가 50점 이상
exam[exam$class == 1 & exam$math >= 50, ]

# 영어점수가 90점 미만이거나 과학점수가 50점 미만
exam[exam$english < 90 | exam$science <50, ]



(3) 열 번호로 변수 추출하기  
- 대괄호 안 쉼표 오른쪽에 조건을 입력해 원하는 변수를 추출할 수 있다.
- exam의 변수들은 id, class, math, english, science의 순서로 구성되므로 열 인덱스가 1이면 id가된다.


exam[ ,1] # 첫 번째 열 추출 

exam[,2] #두번째 열 추출

exam[,3] #세번째 열 추



(4) 변수명으로 변수 추출하기  
- 데이터에 변수가 많으면 각각의 변수가 몇 번째에 열에 위치하는지 파악하는게 쉽지 않다.
- 변수를 추출할 때는 인덱스보다는 변수명을 활용하는게 편리한다.
- 쉼표 오른쪽에 따옴표와 함께 변수명을 입력한다.


exam[, "class"] #class 변수 추출

exam[, "math"] #math 변수 추출

#c()를 이용하면 여러변수를 동시에 추출할 수 있다.
exam[, c("class","math","english")]



(5) 행, 변수 동시 추출하기  
- 쉼표 왼쪽,오른쪽에 동시에 조건을 입려하면 행과 변수 조건이 모두 충족되는 데이터를 추출한다.


exam[1,3] # 행,변수 모두 인덱스

exam[5, "english"] #행 인덱스, 열 변수명

#행 부등호 조건, 열 변수명
exam[exam$math >= 50, "english"]

#행 부등호 조건, 열 변수명
exam[exam$math >= 50, c("english","science")]


2. DataFrame 자료구조의 이해
- DataFrame은 가장 많이 사용하는 데이터 형태로, 행과열로 구성된 표모양 이다.
- List 자료구조보다 자료 처리가 효과적이기 때문에 DataFrame을 더 많이 사용되다.
- List와 Vector의 혼합형으로 컬럼은 List, 컬럼내의 데이터는 Vector자료구조를 갖는다.
- DataFrame 생성함수 : data.frame(), read.table(), read.csv()
- DataFrame 자료처리 함수 : str(), ncol(), nrow(), apply(), summary(), subset()등
- DataFrame 생성방법 : Vector, matrix, 파일(txt, excel, csv)이용



(1) data.frame 객체 생성

##### R에서 실습 #######
#
#- 벡터로 data.frame 생성
english <- c(90, 80, 60, 70)  # 영어 점수 변수 생성
english

math <- c(50, 60, 100, 20)    # 수학 점수 변수 생성
math

class <- c(1, 1, 2, 2)
class


df_midterm <- data.frame(english, math, class)
df_midterm

df_midterm$english  #df_midterm의 english컬럼 조회

mean(df_midterm$english)  # df_midterm의 english로 평균 산출
mean(df_midterm$math)     # df_midterm의 math로 평균 산출


#- data.frame()안에 변수와 값을 나열해서 한번에 만드는 방법도 있다.

df_midterm <- data.frame(english = c(90, 80, 60, 70),
                         math = c(50, 60, 100, 20),
                         class = c(1, 1, 2, 2))


df_midterm

mean(df_midterm$english)  # df_midterm의 english로 평균 산출
mean(df_midterm$math)     # df_midterm의 math로 평균 산술


#- matrix 이용 data.frame 생성
m <- matrix( c(1,"hong",150,
               2, "lee", 250,
               3, "kim", 300) ,
             3 ,by=T)  #3행, 행우선
m
#     [,1] [,2]   [,3] 
#[1,] "1"  "hong" "150"
#[2,] "2"  "lee"  "250"
#[3,] "3"  "kim"  "300"

memp <- data.frame(m)   

memp
#  X1   X2  X3
#1  1 hong 150
#2  2  lee 250
#3  3  kim 300



(2) 외부데이터 파일를 불러와 DataFrame 객체 생성

1) 엑세파일 불러오기

- excel_exam.xlsx 파일을  mywork/testR/data/03/ 경로에 가져놓는다.
- 엑셀파일을 R작업공간에 불러오기 위해 엑셀 파일을 불러오는 기능을 제공하는 패키지를 설치한다.
- readxl 패키지에서 제공하는 read_excel()를 이용해 엑셀파일을 데이터 프레임 구조로 R에 가져온다.
- R에서는 파일명을 지정할 때 항상 앞뒤에 따옴표를 넣는다.




############## R 실습 #################
install.packages("readxl")
library(readxl)

df_exam <- read_excel("./data/03/excel_exam.xlsx")  # 엑셀 파일을 불러와서 df_exam에 할당
df_exam                                            # 출력

mean(df_exam$english)
mean(df_exam$science)



#- 프로젝트 폴더가 아닌곳에서 엑셀파일을 불러오려면 파일 경로를 지정하면 됩니다.

df_exam <- read_excel("d:/ezenac/R/mywork/excel_exam.xlsx")  # 엑셀 파일을 불러와서 df_exam에 할당
df_exam 


#- read_excel()은 기본적으로 엑셀의 첫행을 변수명로 인식해서 불러온다.
#  만약 첫행에 변수명이 없는경우에는 첫행의 데이타가 손실되어 읽어온다.





df_exam_novar <- read_excel("./data/03/excel_exam_novar.xlsx")
df_exam_novar



#- 엑셀파일의 첫행이 변수명이 없는경우 read_excel()함수에 col_names=F 라는 파라메터를 추가한다.
#- F는 논리형 FALSE를 나타내며 대문자로 입력해야 하며 F, T로 입력해도 됩니다.

df_exam_novar <- read_excel("./data/03/excel_exam_novar.xlsx", col_names = F)
df_exam_novar



#- 엑셀 파일에 시트가 여러개인경우 불러올 sheet는 sheet파라메터를 이용해서
#  몇번째 시트의 데이터인지 지정한다.


# 엑셀 파일의 세 번째 시트에 있는 데이터 불러오기
df_exam_sheet <- read_excel("./data/03/excel_exam_sheet.xlsx", sheet = 3)
df_exam_sheet



2) CSV파일 불러오기
- CSV(Comma-separated Values)라는 파일은 값들이 쉽표로 구분되어 있는 형태 이다.
- 다양한 프로그램에서 지원하고 엑셀 파일에 비해 용량이 작기 때문에 데이터를 주고받을 때 많이 사용된다.
- 프로젝트/data폴더에 csv_exam.csv파일을 넣는다.
- 별도의 패키지를 설치하지 않고 R에 기본적으로 내장된 read.csv()를 이용하여 CSV파일을 R로 읽어온다.
- 첫번째 행에 변수명이 없을시 header=F 파라미터를 지정한다.



############## R 실습 #################
df_csv_exam <- read.csv("./data/03/csv_exam.csv")
df_csv_exam



3) 데이터 프레임을 CSV파일로 저장하기

- R의 내장 함수인 write.csv()를 이용해서 데이터 프레임을 CSV 파일로 저장.
- file 파라미터에 저장할 파일명을 지정합니다.
- 저장된 파일은 프로젝트 폴더에 생성됩니다. 

############## R 실습 ##################

#데이터프레임에 데이터 생성한다.
df_midterm <- data.frame(english = c(90, 80, 60, 70),
                         math = c(50, 60, 100, 20),
                         class = c(1, 1, 2, 2))
df_midterm  #내용확인

write.csv(df_midterm, file = "./output/df_midterm.csv") #CSV파일로 저장





4) 데이터 프레임을 RData 저장하기

- RData는 R전용 데이터 파일 이므로 R에서 읽고 쓰는 속도가 다른 파일에 비해 빠르고 용량이 작다.
- R에서 분석작업을 할때 RData를 사용하고 R아닌 곳에서 파일을 주고받을시에는 CSV를 사용한다.
- save()를 이용하여 데이터 프레임을 rda파일로 저장한다.
- rda파일을 불러올때는 load()함수를 이용한다. rda파일을 불러오면 저장할때 사용한 데이터 프레임이
자동으로 만들어진다.


############## R 실습 ##################
df_midterm <- data.frame(english = c(90, 80, 60, 70),
                         math = c(50, 60, 100, 20),
                         class = c(1, 1, 2, 2))
df_midterm

save(df_midterm, file = "./output/df_midterm2.rda")

rm(df_midterm)  #데이터프레임 삭제

df_midterm #지원진 데이터 존재하는지 확인

load("./output/df_midterm2.rda")  #불러올때 저장시 사용한 df_midterm가 자동으로 생성됨

df_midterm



5) txt파일 불러와 data.frame 생성

############## R 실습 #################
txtemp <- read.table('data/03/emp.txt', header=T, sep="") # 제목있음, 공백구분
txtemp
#  사번 이름 급여
#1  101 hong  150
#2  201  lee  250
#3  301  kim  300



(3) data.frame 객체 자료 처리 함수
- 자료구조, 열수, 행수, 요약 통계량 보기

############## R실습 ##################
str(txtemp)
#'data.frame': 3 obs. of  3 variables:
# $ 사번: int  101 201 301
# $ 이름: Factor w/ 3 levels "hong","kim","lee": 1 3 2
# $ 급여: int  150 250 300

ncol(txtemp)
#[1] 3

nrow(txtemp)
#[1] 3

summary(txtemp)
#      사번       이름        급여      
# Min.   :101   hong:1   Min.   :150.0  
# 1st Qu.:151   kim :1   1st Qu.:200.0  
# Median :201   lee :1   Median :250.0  
# Mean   :201            Mean   :233.3  
# 3rd Qu.:251            3rd Qu.:275.0  
# Max.   :301            Max.   :300.0  


#- data.frame의 자료를 대상으로 특정함수 적용하여 연산 수행
# 데이터프레임 자료에 함수 적용

# apply(데이터프레임, 행(1)/열(2), 함수)

apply(txtemp[,c(1,3)],2, sum)
#사번 급여 
# 603  700 

apply(txtemp[,c(1,3)],1, sum)
#[1] 251 451 601


#- data.frame의 부분객체 만들기
#데이터프레임의 부분 객체 만들기

x1 <- subset(txtemp,급여>=200) # 급여>=200인 레코드 대상       
x1
#  사번 이름 급여
#2  201  lee  250
#3  301  kim  300



(4) R에 내장된 dataframe 데이터 세트 저장하고 읽기 

- R은 사용자들의 학습을 위해 다양한 데이터 세트를 제공한다.
- 데이터 세트 목록 보기
- quakes데이터 세트는 지진발생에 관한 정보를 담고 있다.

############## R실습 ##################
# 데이터 세트 목록 보기
library(help=datasets)

# data() 함수로도 데이터 세트 목록 조회가 가능함
data()

# 데이터 세트의 데이터 보기

quakes

head(quakes, n=10)

tail(quakes, n=6)

# 데이터 세트 구조 보기
names(quakes)

str(quakes)

dim(quakes)

# 데이터 세트 요약 보기
summary(quakes)

summary(quakes$mag)

# 데이터 세트 저장하고 읽기
write.table(quakes, "./output/quakes.txt", sep=",")

x <- read.csv("./output/quakes.txt", header=T)
x

x <- read.csv(file.choose(), header=T)
x


------------------------------------------------------------------------------
  ※ 혼자 해보기 ※

Q1 data.frame()과 c()조합해서 표의 내용을 데이터 프레임으로 만들어 출력하기

제품(fruit)	가격(price)	판매량(sales.rate)
사과	1800	24
딸기	1500	38
수박	3000	13


Q2 위에서 만든 데이터 프레임을 이용해 과일가격 평균, 판매량 평균 구하기


Q3. Data를 대상으로 apply()를 적용하여 행/열 방향으로 조건에 맞게 통계량을 구하시오.
조건1) 3개의 점수를 과목별(kor,eng,mat) c()함수를 이용하여 만든후 데이터프레임(Data)을 생성한다. 

조건2) 행/열 방향으로 max() 함수를 적용하여 최대값을 구하시오. apply(데이터프레임,행/열(1/2),함수)

조건3) 행/열 방향으로 mean() 함수를 적용하여 평균 구하기 소숫점 2자리까지
표현하시오. 힌트 : round(data, 자릿수)
