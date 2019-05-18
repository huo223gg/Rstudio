exam = read.csv("data/csv_exam.csv ")
exam[]
exam[1,]
exam[2,]
# 1반 이면서 수학 점수가 50점 이상
exam[exam$class == 1 & exam$math >= 50, ]

# 영어점수가 90점 미만이거나 과학점수가 50점 미만
exam[exam$english < 90 | exam$science <50, ]
exam[ ,1] # 첫 번째 열 추출 

exam[,2] #두번째 열 추출

exam[,3] #세번째 열 추
exam[, "class"] #class 변수 추출

exam[, "math"] #math 변수 추출

#c()를 이용하면 여러변수를 동시에 추출할 수 있다.
exam[, c("class","math","english")]

exam[1,3] # 행,변수 모두 인덱스

exam[5, "english"] #행 인덱스, 열 변수명

#행 부등호 조건, 열 변수명
exam[exam$math >= 50, "english"]

#행 부등호 조건, 열 변수명
exam[exam$math >= 50, c("english","science")]

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

install.packages("readxl")
library(readxl)


df_exam =read_excel("data/03/excel_exam.xlsx")
df_exam

df_exam_no = read_excel("data/03/excel_exam_novar.xlsx",col_names = F)
df_exam_no

df_exam_sheet = read_excel("data/03/excel_exam_sheet.xlsx",sheet=3)
df_exam_sheet
df_csv_exam <- read.csv("./data/03/csv_exam.csv")
df_csv_exam


#데이터프레임에 데이터 생성한다.
df_midterm <- data.frame(english = c(90, 80, 60, 70),
                         math = c(50, 60, 100, 20),
                         class = c(1, 1, 2, 2))
df_midterm  #내용확인

write.csv(df_midterm, file = "./output/df_midterm.csv") #CSV파일로 저장

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
txtemp <- read.table('data/03/emp.txt', header=T, sep="") # 제목있음, 공백구분
txtemp
str(txtemp)

ncol(txtemp)
#[1] 3

nrow(txtemp)
summary(txtemp)
txtemp
apply(txtemp[,c(1,3)],2, sum)
#사번 급여 
# 603  700 

apply(txtemp[,c(1,3)],1, sum)
#[1] 251 451 601
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

# ※ 혼자 해보기 ※
# 
# Q1 data.frame()과 c()조합해서 표의 내용을 데이터 프레임으로 만들어 출력하기
# 
# 제품(fruit)	가격(price)	판매량(sales.rate)
# 사과	1800	24
# 딸기	1500	38
# 수박	3000	13
kor <- c(90,85,90)
eng <- c(70,85,75)
mat <- c(86,92,88)

df_ex= data.frame(fruit=c('사과','딸기','수박'), price=c(1800,1500,3000),sales.rate=c(24,38,13))

# Q2 위에서 만든 데이터 프레임을 이용해 과일가격 평균, 판매량 평균 구하기

mean(df_ex$price)
mean(df_ex$sales.rate)
# 
# 
# Q3. Data를 대상으로 apply()를 적용하여 행/열 방향으로 조건에 맞게 통계량을 구하시오.
# 조건1) 3개의 점수를 과목별(kor,eng,mat) c()함수를 이용하여 만든후 데이터프레임(Data)을 생성한다. 
Data <- data.frame(kor=c(90,85,90), eng=c(70,85,75), mat=c(86,92,88))
Data
# 조건2) 행/열 방향으로 max() 함수를 적용하여 최대값을 구하시오. apply(데이터프레임,행/열(1/2),함수)

apply(Data,1,max)
apply(Data,2,max)
# 조건3) 행/열 방향으로 mean() 함수를 적용하여 평균 구하기 소숫점 2자리까지
# 표현하시오. 힌트 : round(data, 자릿수)
round(apply(Data,1,mean),2)
round(apply(Data,2,mean),2)



