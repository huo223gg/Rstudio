[05] 기본명령어 정리 31 개
1. 기초적인 연산자와 함수들을 엄선하여 31가지 기본명령어 복습

(1) 사칙연산자

1+2

1-2

4*2

4/2

(1+2)*4/2


(2) 제곱, 몫과 나머지 연산자

2^4 
## 2* 2* 2* 2

16^(1/4)

16 %/% 3
## 16을 3으로 나눈 몫을 계산

16 %% 3
## 16을 3으로 나눈 나머지를 계산


(3) :으로 정수 수열 만들기

2:10

1:5 * 2
## 조금 더 복잡한 수열 만들기 이후에 연산

1:10 %% 3
(4) seq()함수로 수열 만들기

seq(from=1, to=15, by=5)
## 1부터 15까지 5 간격으로 등차수열 만들기


seq(1, 15, 5)
## 함수에서 정의된 순서대로 속성값을 넣을 때는 속성이름을 생략 가능


seq(1, 15, length=5)
## length 옵션을 사용하여 1부터 15까지를 5등분


(5) "",'' 로 문자 입력하기

"A"
'A'
## 글자를 입력할 때는 "", ''로 감싸서 표현  

A
## 따옴표를 사용하지 않으면 A라는 이름을 가진 객체(데이터)를 찾음
## 아직 A라는 이름으로 저장된 것이 없으므로 오류 발생

'한글'
## 한글도 사용가능 

(6) c()함수로 값 나열하기

c('A', 'Z', 'C')

c(2017, 2019, 2020)

(7) rep() 함수로 값 반복하기

rep(10, 3)

rep( c('A','B'), 3 )
## c('A','B') 를 3번 반복

rep( c('A','B'), c(3,2) )
## 각각 'A'를 3번 ,'B'를 2번 반복

(8) paste() 함수로 문자 붙이기
- paste() 는 붙인값들 사이에 공백을 넣는다. sep= 옵션을 사용하면 
공백대신 다른 문자를 넣을 수 이있다. 
- 공백 없이 값들을 붙이고 싶을때 sep="" 옵션을 사용해도 되고 paste0()로 
사용한다.

paste( 'A', '+', 1, '등급')

paste('2학년', c('1반','2반','3반'), sep='-')

paste(1:4, '학기', sep='')
## 공백없이 글자를 붙이는 방법 1

paste0(1:4, '학기')
## 공백없이 글자를 붙이는 방법 2(1과 결과는 동일)

(9) substr() 함수로 글자 부분 선택하기
- 함수안에는 원본글자, 시작위치, 끝위치를 의미하며
끝위치값도 선택된다.

substr('ABCDEFGHIJKLMNOPQRSTUVWXYZ', 10, 13)
## 10번째~13번째 글자 추출

substr('가A나B다C', 3, 4)
## 한글과 영어 모두 1칸으로 계산


(10) =으로 값 저장하기

x=1
## x라는 이름으로 1을 저장

x
## 저장된 값을 출력


x=c('A', 'D')
## x에 새로운 값이 저장됨

x

y = rep(x,2)
y

(11)부등로(>,<)와 등호(==, !=)로 논리연산하기

3>0

3<0

3==0

3!=0

1:5 >= 3
## 1~5까지의 숫자모두 3과 비교한다.

y = 1:5 >= 3
## 논리연산의 결과를 y로 저장  
y  

y+1
## TRUE는 1, FALSE는 0으로 계산

(12) %in%로 논리연산하기

v1=1:10

v1 %in% c(3,7,9)

v2 = c("서울","인천","부산","경기","강원","대전","대구","제주","광주","울산")

v2 %in% c("부산", "대구")

(13) &(and)와 |(or)로 다양한 논리연산하기

(v1 %in% c(3,7,9)) & (v2 %in% c("부산", "대구"))

(v1 %in% c(3,7,9)) | (v2 %in% c("부산", "대구"))


(14) cbind()/rbind()함수로 열/행 결합하기

rbind(c("A","B","C"), c("x","y","z"))

cbind(c("A","B","C"), c("x","y","z"))


(15) []로 부분 선택하기

x = 1:20 *2 -1

x
## 1부터 39까지 홀수 수열

x[ 13 ]
## x의 13번째 값 확인

x[ c(1,13,19) ]
## x의 1, 13, 19번째 값 확인

xy = rbind( 1:3, 7:9)

xy

xy[2, ]
## 2번째 행 선택

xy[,c(1,3)]
## 1,3번째 열 선택 

xy[,-2]
## 2번째 열 제외 선택

xy[2,3]
## 2번째 행, 3번째 열 선택
(16) read.csv()로 csv파일 읽어오기

- data2.zip파일을 R\testR\data2폴더에 압축을 푼다.
- read.csv()함수안에 header=F를 사용하면 첫번째 행을 변수로 사용하지
않고 변수이름에 V1,V2등으로 자동지정된다.

read.csv('data2/sample1.csv')
## 작업폴더 내 data 폴더에 있는 sample1.csv 불러와서 출력하기

data1 = read.csv('data2/sample1.csv')
## 작업폴더 내 data 폴더에 있는 sample1.csv 불러와서 data1로 저장하기
## 실행 후 오른쪽 위 환경창에서 data1이 추가된 것을 확인  
data1

read.csv('./data2/sample2.csv', header=FALSE)


(17) head() 함수로 관측치 확인하기
- 6개의 관측치를 제일 앞에서 읽어온다.

subway = read.csv('data2/subway.csv', fileEncoding='euc-kr')
## 서울시 1~4호선 12월 역별 시간대별 지하철 승차하 인원 집계데이터
## 자료 출처 : 공공데이터포탈(data.go.kr)

## 옵션 fileEncoding='euc-kr' : csv 파일 인코딩이 'euc-kr'임을 지정

head(subway)

(18)names()함수로 변수 이름 확인하고 바꾸기

names(subway)
## 저장되어 있는 변수이름 확인

c("Station", "Date", "InOut", paste0("H", 5:25))
## 새로운 변수이름 만들기 

names(subway) = c("Station","Date","InOut",paste0("H", 5:25))
## "names(subway)" 뒤에 "="을 붙이고 새로운 이름을 넣어 업데이트

names(subway)

(19) str()함수로 데이터 구조 확인하기

str(subway)

(20) View()함수로 스프레드시트 확인하기

View(subway)
## 스크립트 창에 데이터 탭이 추가 됨
## 오른쪽 위 환경창에서 데이터 이름 클릭 시 동일한 작업 실행


(21) $를 활용한 변수 선택하기
subway[, 4]

subway$H5

(22) factor()함수로 범주형 변수 만들기

demo = read.csv('data2/gender_age.csv')

demo

str(demo)

demo$Gender
## 이건 그냥 숫자

factor(demo$Gender)
## factor 형식(R에서 범주형 변수를 다루는 형식)으로 바꿔 "출력"


(23) $를 활용한 변수 수정과 추가하기

demo$Gender = factor(demo$Gender)
## demo$Gender를 불러와 factor 형식으로 바꾼 뒤, demo$Gender를 업데이트

str(demo)

paste0(demo$Gender,  "_", demo$Age, "대")

demo$Group = paste0(demo$Gender,  "_", demo$Age, "대")
## 변수를 추가  

str(demo)


(24) levels()함수로 범주형 변수의 수준 확인하고 바구기

levels( demo$Gender )
## 수준(levels) 확인하기

levels( demo$Gender ) = c("1_남자", "2_여자")
## "="을 붙이고 새로운 값을 넣어 수준 업데이트

levels( demo$Gender )
## 수준이 바뀌면,

demo
## 보이는 값도 바뀜

demo$Gender

as.numeric(demo$Gender)

(25) which() 함수로 조건과 일치하는 관측치 찾기
- 조건을 모두 만족하는 관측치가 몇 번째인지 확인할 수 있다.

demo$Age == 30
## 논리 연산

which( demo$Age == 30 )

which(demo$Age==30 & demo$Gender=='1_남자')
## 두 조건을 모두 만족하는 관측치 선택 


(26) []와 논리연산으로 관측치 선택하기

demo[demo$Age==30 & demo$Gender=='1_남자', ]

(27) subset() 함수로 부분 데이터 선택하기

subdata1 = subset(subway, Station %in% c("강남(222)", "명동(424)"))
## 2호선 강남역과 4호선 명동역 데이터만 선택

str(subdata1)
## 일치하는 124개 관측치로 만들어진 데이터

subdata2 = subset(subway, Station %in% c("강남(222)", "명동(424)") 
                  & Date=="2016-12-24")
## 위의 조건에 날짜 조건(12월 24일)을 추가

str(subdata2)
## 일치하는 4개 관측치로 만들어진 데이터

subdata2

subdata3 = subset(subway, Station %in% c("강남(222)", "명동(424)") 
                  & Date=="2016-12-24", select=c(Station, InOut, H23, H24, H25))

subdata3

(28) dim()/nrow()/length()함수로 변수/데이터크기 확인하기

dim(subdata1)

nrow(subdata1)

length( subway$Station )

length( levels(subway$Station ) ) 


(29) write.csv()함수로 데이터를 csv 파일로 내보내기

write.csv(subdata3, 'output/result1.csv')

write.csv(subdata3, 'output/result2.csv', row.names=FALSE)


(30) install.packages()함수로 패키지 설치하기

## R을 제대로 활용하기 위해서는 패키지 설치가 필요하고,
## 패키지 설치를 위해서는 컴퓨터가 인터넷에 연결되어 있어야 합니다.

install.packages('ca')
## 'ca'라고하는 패키지를 설치


(31) library()함수로 패키지 불러오기

library(ca)