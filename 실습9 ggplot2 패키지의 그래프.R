[09] ggplot2 패키지의 그래프
1. ggplot2  패키지의 그래프

- ggplot2를 사용해야 하는이유
ggplot2창시자 : 기본 그래픽 시스템은 그림을 그리기 위해 좋은 툴이지만, ggplot2는
데이터를 이해하는 데 좋은 시각화 툴이다.


※ ggplot2 레이어 구조 
ggplot2는 레이어 구조로 되어있다. 배경을 만들고, 그위에 그래프 형태를 그리고,
마지막으로 축 범위, 색, 표식 등 설정을 추가하는 순서로 그래프를 만든다.







(1) 산점도 그래프

- 데이터를 x측과 y측에 점으로 표현한 그래프를 산점도(Scater Plot) 라 한다.
- 산점도는 나이와 소득처럼 연속 값으로 된 두 변수의 관계를 표현할 때 사용한다.
- mpg데이터의 displ(배기량)과 hwy(고속도로 연비)로 산점도 그래프를 그린다.

1) 배경 설정하기

library(ggplot2)

# x축 displ, y축 hwy로 지정해 배경 생성
ggplot(data = mpg, aes(x = displ, y = hwy))




2) 그래프 추가하기
- dplyr 패키지는 함수들을 %>% 기호로 연결하지만 ggplot2 패키지 함수들은 + 기호로
연결한다.


# 배경에 산점도 추가
ggplot(data = mpg, aes(x = displ, y = hwy)) + geom_point()





- 표시된 점들은 각각의 관측치(행)을 의미한다. 각 점이 하나의 자동차 모델을 의미한다.
- 그래프의 내용은 전반적으로 배기량이 큰 자동차일수록 고속도로 연비가 낮은 경향이 있다.


3) 축 범위를 조정하는 설정 추가하기
- 축의 범위는 xlim()과 ylim() 를 이용해서 지정한다.

# x축 범위 3~6으로 지정
ggplot(data = mpg, aes(x = displ, y = hwy)) + geom_point() + xlim(3, 6)


# x축 범위 3~6, y축 범위 10~30으로 지정
ggplot(data = mpg, aes(x = displ, y = hwy)) + 
  geom_point() + 
  xlim(3, 6) + 
  ylim(10, 30)




4) 그래프 이미지 파일로 저장하기
- 오른쪽 아래 이미지가 보여지는 창 메뉴에서 [Export] -> 서브세개의 메뉴가 나온다
이미지로저장, PDF로저장, 메모리로 저장 등의 메뉴를 사용할 수 있다.







5) 산점도 모양과 크기 설정하기
- colour에 명목형 변수를 설정해 levels별로 컬러를 다르게 할 수 있다.
df <- read.csv("./data/09/example_studentlist.csv")
head(df)
#install.packages("ggplot2")
library(ggplot2)
g1<- ggplot(df, aes(x=weight, y=height))
g1 + geom_point(aes(colour=gender,shape=bloodtype),size=5)



- colour에 명목형 변수 뿐만 아니라 연속형 변수도 넣을 수 있다.
g1 + geom_point(aes(colour=height,shape=gender),size=5)




#alpha로 투명도 조절
g1 + geom_point(aes(colour=height,shape=gender),size=5, alpha=0.6)


- 회귀모델 추가해서 산점도 그리기(geom_smooth())

g1 + geom_point(aes(colour=gender),size=5) + geom_smooth(method="lm")




- 관측치가 몇 개 되지 않으면 점에 이름을 넣을 수 있다.
vjust값을 이용해서  점과 이름의 간격을 조절한다.

g1 + geom_point(aes(colour=gender),size=5) +
  geom_text(aes(label=name),vjust=-1.1, colour="grey35")





6) ggplot() vs qplot()
- qplot() : 전처리 단계 데이터 확인용 문법 간단, 기능 단순
- ggplot() : 최종 보고용. 색, 크기, 폰트 등 세부 조작 가능

----------------------------------------------------------------------------------------------------
  ※ 혼자서 해보기
- mpg 데이터와 midwest 데이터를 이용해서 분석 문제를 해결해 보세요.
Q1. mpg 데이터의 cty(도시 연비)와 hwy(고속도로 연비) 간에 어떤 관계가 있는지 알아보려고 합니다. 
x축은 cty, y축은 hwy로 된 산점도를 만들어 보세요.

Q2. 미국 지역별 인구통계 정보를 담은 ggplot2 패키지의 midwest 데이터를 이용해서 전체 인구와 
아시아인 인구 간에 어떤 관계가 있는지 알아보려고 합니다. 
x축은 poptotal(전체 인구), y축은 popasian(아시아인 인구)으로 된 산점도를 만들어 보세요. 
전체 인구는 50만 명 이하, 아시아인 인구는 1만 명 이하인 지역만 산점도에 표시되게 설정하세요.





※ 힌트
Q1. geom_point()를 이용해 산점도를 만들어 보세요.
Q2. xlim()과 ylim()을 이용해 조건에 맞게 축을 설정하면 됩니다.

----------------------------------------------------------------------------------------------------
  
  (2) 막대그래프

- 막대그래프(Bar Chart)는 데이터의 크기를 막대의 길이로 표현한 그래프입니다.
성별 소득 차이처럼 집단 간 차이를 표현할 때 주로 사용한다.
- mpg데이터의 drv(구동방식)별 평균 hwy(고속도로 연비) 막대 그래프를 만든다.

1) 집단별 평균표 만들기
- dplyr패키지를 이용하여 구동방식별 고속도로 연비로 구성 데이터프레임을 생성한다.

#install.packages("dplyr")
library(dplyr)

df_mpg <- mpg %>% 
  group_by(drv) %>%
  summarise(mean_hwy = mean(hwy, na.rm=T))

df_mpg


2)그래프 생성하기

ggplot(data = df_mpg, aes(x = drv, y = mean_hwy)) + geom_col()




3) 크기순으로 정렬하기
- reorder()를 사용하면 막대를 값의 크기 순으로 정렬할 수 있다.
- 정렬기준 변수 앞 - 기호를 붙이면 내림차순으로 정렬합니다.

ggplot(data = df_mpg, aes(x = reorder(drv, -mean_hwy), y = mean_hwy)) + geom_col()



4) 빈도 막대 그래프 만들기
- 빈도 막대 그래프는 값의 개수(빈도)로 막대의 길이를 표현한 그래프이다.
- y축 없이 x축만 지정하고, geom_col() 대신 geom_bar()를 사용한다.
- drv항목별 빈도 막대 그래프 그리기

ggplot(data = mpg, aes(x = drv)) + geom_bar()



- x축에 연속적인 데이터를 지정하면 값의 분포를 파악할 수 있다.
- hwy변수의 분포를 나타낸 빈도 막대 그래프 그리기

ggplot(data = mpg, aes(x = hwy)) + geom_bar()




- fill, position 사용하기
- fill : 막대의 컬러에 명목형 변수를 넣어 levels별로 컬러를 나타낼 수 있다. 하나의 막대에 누적되어 
나타난다.
df <- read.csv("./data/09/example_studentlist.csv")
head(df)
#install.packages("ggplot2")
library(ggplot2)
ggplot(df,aes(x=bloodtype)) + geom_bar()

ggplot(df,aes(x=bloodtype,fill=gender)) + geom_bar()





- geom_bar(postion="dodge")를 사용하면 누적하지 않고 개별로 막대그래프를 그릴 수 있다

ggplot(df,aes(x=bloodtype,fill=gender)) + geom_bar(position="dodge")






- geom_bar(postion="identity")를 사용하면 levels별로 겹쳐보인다. 누적되지 않고 나타난다.

ggplot(df,aes(x=bloodtype,fill=gender)) + geom_bar(position="identity")





5) geom_col() VS geom_bar() 비교
- 평균 막대 그래프 : 데이터를 요약한 평균표를 먼저 만든 후 평균표를 이용해 그래프 생성 - geom_col()
- 빈도 막대 그래프 : 별도로 표를 만들지 않고 원자료를 이용해 바로 그래프 생성 - geom_bar()


----------------------------------------------------------------------------------------------------------------
  ※ 혼자서 해보기
- mpg 데이터를 이용해서 분석 문제를 해결해 보세요.
Q1. 어떤 회사에서 생산한 "suv" 차종의 도시 연비가 높은지 알아보려고 합니다.
"suv" 차종을 대상으로 평균 cty(도시 연비)가 가장 높은 회사 다섯 곳을 막대 그래프로 표현해 보세요. 
막대는 연비 가 높은 순으로 정렬하세요.
Q2. 자동차 중에서 어떤 class(자동차 종류)가 가장 많은지 알아보려고 합니다. 
자동차 종류별 빈도를 표현한 막대 그래프를 만들어 보세요.



※ 힌트
Q1. 우선 그래프로 나타낼 집단별 평균표를 만들어야합니다. 
filter()로 "suv" 차종만 추출한 후 group_by()와 summarise()로 회사별 cty 평균을 구하고, 
arrange()와 head()로 상위 5행을 추출하면 됩니다. 
이렇게 만든 표를 geom_col()을 이용해 막대 그래프로 표현해 보세요. 
reorder()를 이용해 정렬 기준이 되는 평균 연비 변수 앞에 - 기호를 붙이면 
연비가 높은 순으로 막대를 정렬할 수 있습니다.

Q2. 빈도 막대 그래프는 요약표를 만드는 절차 없이 원자료를 이용해 만들므로 geom_col() 대신 
geom_bar()를 사용하면 됩니다.

----------------------------------------------------------------------------------------------------------------
  
  (3) 선그래프

- 선그래프(Line Chart)는 시간에 따라 달라지는 데이터를 표현할 때 사용한다.
- 환율, 주가지수등 경제지표등을 표현한다.
- 일정시간 간격의 데이터를 시계열 데이터(Time Series Data)라 하고
시계열 데이타를 선으로 표현한 그래프를 시계열 그래프라 한다.
- ggplot2패키지의 economics데이터로 시계열 그래프 그리기
- economics데이터는 미국의 경제 지표들을 월별로 나타낸 데이터이다.
- x 축 시간을 의미하는 date, y축 실업자 수 unemploy
- 선그래프 표현을 위해 geom_line()함수를 추가한다.

economics2 <-ggplot2::economics
head(economics2)

ggplot(data=economics2,aes(x=date, y=unemploy)) +
  geom_line()




※ 데이터 분석 설명
- 실업자 수가 약 5년주기로 등락을 반복하고, 2005년 이후 급격하게 증가 했다가 
2010년 이후 다시 감소하고 있는 추세라는 것을 알 수 있다.


-----------------------------------------------------------------------------------------------------
  ※ 혼자서 해보기
- economics 데이터를 이용해서 분석 문제를 해결해 보세요.
Q1. psavert(개인 저축률)가 시간에 따라서 어떻게 변해왔는지 알아보려고 합니다. 
시간에 따른 개인 저축률의 변화를 나타낸 시계열 그래프를 만들어 보세요.




----------------------------------------------------------------------------------------------------
  
  
  (4) 상자그림

- 상자그림(Box plot)은 데이터 분포(퍼져있는 형태)를 직사각형 상자 모양으로 표현한 그래프이다.
- 데이터의 특성을 좀 더 자세히 이해할 수 있다.
- mpg데이터의 drv(구동방식)별 hwy(고속도로 연비)를 상자그림으로 그린다.
- x축 drv, y축 hwy 지정후 상자 그림 표현을 위해 geom_boxplot()를 추가한다.

ggplot(data = mpg, aes(x = drv, y = hwy)) + geom_boxplot()




※ 데이터 분석 설명
- 4륜구동(4)  
17~22사이에 대부분의 자동차가 모여있다.
중앙값이 상자 밑면에 가까운것을 보면 낮은 값쪽으로 치우친 형태의 분포이다.
- 전륜구동(f)
26~29 사이의 좁은 범위에 자동차가 모여 있는 뾰족한 형태의 분포라는 것을 알 수 있다.
수염의 위, 아래에 점표식이 있는 것을 보면 연비가 극단적으로 높거나 낮은 자동차들이
존재 한다는 것을 알 수 있다. 
- 후륜구동(r)
17~24사이의 넓은 범위에 자동차가 분포하고 있다는 것을 알 수있다.
수염이 짧고 극단치가 없는 것을 보면 대부분의 자동차가 사분위 범위에 해당한다는 것을
알수있다.


※상자그림의 값과 설명





----------------------------------------------------------------------------------------------------
  ※ 혼자서 해보기
- mpg 데이터를 이용해서 분석 문제를 해결해 보세요.
Q1. class(자동차 종류)가 "compact", "subcompact", "suv"인 자동차의 cty(도시 연비)가 
어떻게 다른지 비교해보려고 합니다. 세 차종의 cty를 나타낸 상자 그림을 만들어보세요.




※ 힌트
- 우선 filter()를 이용해 비교할 세 차종을 추출해야 합니다. 추출한 데이터를 이용해 geom_boxplot()으로
상자그림을 만들면 됩니다.

---------------------------------------------------------------------------------------------------
  
  (5) geom_line()와 geom_point 같이 그리기

df <- read.csv("./data/09/example_studentlist.csv")
head(df)
#install.packages("ggplot2")
library(ggplot2)
g1<- ggplot(df, aes(x=height,y=weight, colour=bloodtype))
g1
g1 + geom_point()
g1 + geom_line()

#두그래프 같이 사용
g1  + geom_line() + geom_point()



#size로 그래프 크기 설정
g1  + geom_line(size=1) + geom_point(size=10)




#geom_line만 aes추가할 수 있다. geom_poin()까지는 전달되지 않는다.
#기존 colour설정은 무시된다.
g1  + geom_line(aes(colour=gender),size=1) + geom_point(size=10)








