강사 공유폴더  192.168.103.99

playdata
7276

http://lectureblue.pe.kr

dplyr


install.packages("ggplot2")
library(ggplot2)
head(mpg)

graph setting
ggplot(data = mpg,aes(x=displ, y= hwy)) : x axis, y axis building
+geom_point() : graph type setting
+xlim(3,6):x axis limit 3~6 setting
+ylim(10,30) :y axis limit 10~30 setting

plots->expot=>image save function

df<-read.csv("data/09/example_studentlist.csv") : data reading

<- or = possible to input

g1<-ggplot(df,aes(x=weight, y=height)) :data= cut possible, graph preparation
g1+geom_point(aes(colour=gender,shape=bloodtype),size=5) : data point display/ colour & shape add/size magnification
g1+geom_point(aes(colour=bloodtype,shape=gender),size=5) : diffent shape
g1+geom_point(aes(colour=bloodtype,shape=gender),size=5, alpha=0.6): alpha 투명도 조저
g1+geom_point(aes(colour=gender,shape=bloodtype),size=5)+geom_smooth(method="lm") : lm hoigui model
geom_text(aes(label=name), vjust=-1.1,colour="grey35") : name add, vjust distance from text


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

ggplot(mpg,aes(x=cty, y=hwy))축만들기
+geom_point() 점찍어서 보기

ggplot(midwest,aes(x=poptotal, y=popasian))+
  geom_point()+
  xlim(0,500000)+
  ylim(0,10000)

집단별 group_by
summarise함께 사용함.

구동방식별로 평균 연비구하기
df_mpg<-mpg%>%
  filter(!ls.na(drv)) : not 이므로 drv의 na가 아닌 것만 추출하는 필ㅌ
  group_by(drv)%>%
  summarise(mean_hwy = mean(hwy, na.rm =T)) : na.rm=T 결측값 제거

ggplot(df_mpg,aes(x=drv, y=mean(hwy,na.rm = T)))

ggplot(data = df_mpg, aes(x = drv, y = mean_hwy)) + geom_col() : 막대그래프 만들기

ggplot(data = df_mpg, aes(x = reorder(drv, -mean_hwy), y = mean_hwy)) + geom_col() : reorder로 재정렬하는데 - 내림차순으로 정ㄹ려
ggplot(data = df_mpg, aes(x = reorder(drv, mean_hwy), y = mean_hwy)) + geom_col() : 오름차순으로 

빈도 막대 그래프
- y축 없이 x축만 지정하고, geom_col() 대신 geom_bar()를 사용한다.
- drv항목별 빈도 막대 그래프 그리기

ggplot(data = mpg, aes(x = drv)) + geom_bar() : col과 bar의 차이 기어의 종류 

ggplot(data = mpg, aes(x = hwy)) + geom_bar() : 연비의 카운트 

fill : 막대의 컬러에 명목형 변수를 넣어 levels별로 컬러ㄹ하나의 막대에 누적되어 표시
ggplot(data= df, aes(x=bloodtype,fill=gender)) + geom_bar()

각자 구분하여 표기
ggplot(data=df, aes(x=bloodtype,fill=gender))+ geom_bar(position="dodge")

ggplot(df,aes(x=bloodtype,fill=gender)) + geom_bar(position="dodge")

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

먼저 

mpg_test = mpg%>%
  filter(class=='suv') %>% : suv의 행만 추출
  group_by(manufacturer) %>%:회사로 그룹핑하기
  summarise(cty_mean = mean(cty)) %>%
  arrange(desc(cty_mean)) %>%:정렬할 수 있음. 오른차순이므로 desc로 정의
  head(5) : 상위 5개만 산출:
  
ggplot(mpg_test,aes(x=reorder(manufacturer,-cty_mean), y=cty_mean))+
  geom_col()

ggplot(mpg,aes(x=class))+geom_bar()

선그래프
- 선그래프(Line Chart)는 시간에 따라 달라지는 데이터를 표현할 때 사용한다.
- 환율, 주가지수등 경제지표등을 표현한다.
economics2 <-ggplot2::economics : :: 접근하겠다는 의미 
ggplot(economics2,aes(x=date, y=unemploy))+
  + geom_line()

※ 혼자서 해보기
- economics 데이터를 이용해서 분석 문제를 해결해 보세요.
Q1. psavert(개인 저축률)가 시간에 따라서 어떻게 변해왔는지 알아보려고 합니다. 
시간에 따른 개인 저축률의 변화를  시계열 그래프를 만들어 보세요.

ggplot(economics,aes(x=date, y=psavert ))+geom_line()

ggplot(data = mpg, aes(x = drv, y = hwy)) + : ggplot그리고
  geom_boxplot() : 상자그래프 그리기고

상자 그래프의 수염이라고 하며 1.5배내에 있으며 밖에 있는 것은 이상치

mpg$drv : drv 값만 출력하여 확인가능
filter(!is.na(drv)) : na값이 아닌 것만 필터링

ggplot(data = mpg, aes(x = drv, y = hwy)) +
  geom_boxplot() : 상자그래프 그리기고


※ 혼자서 해보기
- mpg 데이터를 이용해서 분석 문제를 해결해 보세요.
Q1. class(자동차 종류)가 "compact", "subcompact", "suv"인 자동차의 cty(도시 연비)가 
어떻게 다른지 비교해보려고 합니다. 세 차종의 cty를 나타낸 상자 그림을 만들어보세요.


※ 힌트
- 우선 filter()를 이용해 비교할 세 차종을 추출해야 합니다. 추출한 데이터를 이용해 geom_boxplot()으로
상자그림을 만들면 됩니다.
mpg_filtered <- mpg%>%
  filter(class=='compact'| class=='subcompact' | class =='suv'): 하기와 동일한 방식
  filter(class %in% c("compact","subcompact","suv")) : 상기보다 간단하 표현ㅅ
ggplot(mpg_filtered, aes(x=class, y= cty))+
  geom_boxplot()

geom_line()와 geom_point 같이 그리기

df <- read.csv("./data/09/example_studentlist.csv")
head(df)
#install.packages("ggplot2")
library(ggplot2)
g1<- ggplot(df, aes(x=height,y=weight, colour=bloodtype))
g1
g1 + geom_point()
g1 + geom_line()
g1  + geom_line() + geom_point() : 같이 보려면 그냥 더하기 연결됨;
g1  + geom_line(size=1) + geom_point(size=5) : 사이즈 변경;
g1  + geom_line(aes(colour=gender),size=1) + geom_point(size=5)

