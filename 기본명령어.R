2:10

1:5 * 2
## 조금 더 복잡한 수열 만들기 이후에 연산

1:10 %% 3

rep(10, 3)

rep( c('A','B'), 3 )
## c('A','B') 를 3번 반복

rep( c('A','B'), c(3,2) )
## 각각 'A'를 3번 ,'B'를 2번 반복
paste0( 'A', '+', 1, '등급')

paste('2학년', c('1반','2반','3반'), sep='-')

paste(1:4, '학기', sep='')
## 공백없이 글자를 붙이는 방법 1

paste0(1:4, '학기')
## 공백없이 글자를 붙이는 방법 2(1과 결과는 동일)

substr('ABCDEFGHIJKLMNOPQRSTUVWXYZ', 10, 13)
## 10번째~13번째 글자 추출

substr('가A나B다C', 3, 4)
## 한글과 영어 모두 1칸으로 계산


1:5 >= 3
## 1~5까지의 숫자모두 3과 비교한다.

y = 1:5 >= 3
## 논리연산의 결과를 y로 저장  
y  

y+1
## TRUE는 1, FALSE는 0으로 계산

v1=1:10

v1 %in% c(3,7,9)

v2 = c("서울","인천","부산","경기","강원","대전","대구","제주","광주","울산")

v2 %in% c("부산", "대구")

(v1 %in% c(3,7,9)) & (v2 %in% c("부산", "대구"))

(v1 %in% c(3,7,9)) | (v2 %in% c("부산", "대구"))

rbind(c("A","B","C"), c("x","y","z"))

cbind(c("A","B","C"), c("x","y","z"))

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

data1 = read.csv('data2/sample1.csv')
data1

read.csv('./data2/sample2.csv',header = F)


subway = read.csv("./data2/subway.csv", fileEncoding = 'euc-kr')
head(subway,20)

names(subway)
## 저장되어 있는 변수이름 확인

c("Station", "Date", "InOut", paste0("H", 5:25))
## 새로운 변수이름 만들기 

names(subway) = c("Station","Date","InOut",paste0("H", 5:25))
## "names(subway)" 뒤에 "="을 붙이고 새로운 이름을 넣어 업데이트

names(subway)
head(subway)


str(subway)
View(subway)

subway[, 4]

subway$H5

demo = read.csv('data2/gender_age.csv')

demo

str(demo)

demo$Gender
## 이건 그냥 숫자

factor(demo$Gender)
## factor 형식(R에서 범주형 변수를 다루는 형식)으로 바꿔 "출력"

demo$Gender = factor(demo$Gender)
## demo$Gender를 불러와 factor 형식으로 바꾼 뒤, demo$Gender를 업데이트

str(demo)

paste0(demo$Gender,  "_", demo$Age, "대")

demo$Group = paste0(demo$Gender,  "_", demo$Age, "대")
## 변수를 추가  

str(demo)

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

demo$Age == 30
## 논리 연산

which( demo$Age == 30 )

which(demo$Age==30 & demo$Gender=='1_남자')
## 두 조건을 모두 만족하는 관측치 선택 

demo[demo$Age==30 & demo$Gender=='1_남자', ]

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

dim(subdata1)

nrow(subdata1)

length( subway$Station )

length( levels(subway$Station ) ) 

write.csv(subdata3, 'output/result1.csv')

write.csv(subdata3, 'output/result2.csv', row.names=FALSE)
























