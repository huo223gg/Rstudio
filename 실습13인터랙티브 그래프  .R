[13] 인터랙티브 그래프
1. 인터랙티브 그래프 

- 마우스 움직임에 반응하여 실시간으로 형태가 변하는 그래프이다.
- 그래프를 자유롭게 조절하면서 관심있는 부분을 자세히 살펴볼 수 있다.
- html로 저장하여 웹 브라우저를 이용해서 그래프를 자유롭게 조작하면서 살펴볼 수 있다.

(1) plotly 패키지로 인터랙티브 그래프 생성  

1) 산점도 인터랙티브 그래프 생성

- plotly 패키지 설치 및 로딩
- ggplot2로 만든 그래프 plotly 패키지의 ggplotly()함수로 인터그랙티브 그래프를 만든다.
- mpg데이터를 이용하여 x축 displ(배기량), y축 hwy(고속도로 연비)를 지정하여 산점도 생성한다.
- drv(구동방식)별 색상을 표현하기 위해 col=drv를 지정한다.

install.packages("plotly")
library(plotly)

library(ggplot2)
p <- ggplot(data = mpg, aes(x = displ, y = hwy, col = drv)) + geom_point()

ggplotly(p)

- 산점도위에 마우스 커서를 올려놓으면  값이 나타난다.
- 마우스로 드래그하면 특정영역이 확대되며 더불 클릭하면 원상태로 돌아간다.







- 뷰어창의 [Expoert -> Save as Web Page...] 로 html 로 저장할 수 있으며 브라우저에서 확인가능하다.






2) 막대그래프 인터랙티브 그래프 생성
- ggplot2패키지에 내장된 diamonds데이터를 이용해 막대 그래프를 만든후 인터랙티브 그래프를 생성한다.
- diamonds데이터는 다이아몬드 5만여 개의 캐럿, 컷팅방식, 가격 등의 속성을 담은 데이터이다.

p <- ggplot(data = diamonds, aes(x = cut, fill = clarity)) + 
  geom_bar(position = "dodge")

ggplotly(p)





(2) dygraphs 패키지로 인터랙티브 시계열 그래프 생성 

1) 시간에 따른 데이터의 변화를 표현한 인터렉티브 시계열 그래프 생성

- 마우스로 시간 축을 움직이면 시간에 따른 데이터의 변화를 확인할 수 있다.
- ggplot2패키지에 내장된 economics데이터는 실업자 수, 저출률 등 1967~2015년 
미국의 월별 경제 지표를 담은 데이터이다.
- 시간순서 속성을 지니는 xts 데이터 타입으로 되어 있어야 한다.
- unemploy(실업자수)를 xts()로 xts타입으로 변환한다.

install.packages("dygraphs")
library(dygraphs)

economics <- ggplot2::economics
head(economics)

library(xts)
eco <- xts(economics$unemploy, order.by = economics$date)
head(eco)

# 그래프 생성
dygraph(eco)




- 화살표가 이동하면 시간이 변경되면서 위상자의 내용이 바뀐다.
- 드래그및 더불클리으로 확대,취소를 할 수 있다.

2) dygraph()에 %>%를 이용하여  dyRangeSelector()추가하면 그래프 아래 날짜 범위 선태기능이 추가된다.
-특정기간 선택과 범위를 정한 부분의 좌우 움직임으로 데이터 변화를 확인할 수 있다

# 날짜 범위 선택 기능
dygraph(eco) %>% dyRangeSelector()



3) 여러값을 동시에 표현할 수 있다.
- economics 데이터의 unemploy(실업자수)와 psavert(저축률)를 그래프에 함께 그린다.
- 시간순서 속성을 지닌 xts타입으로 변환하고 실업자수의 단위를  1000명에서 100만명 
단위로 수정한다.

# 저축률 
eco_a <- xts(economics$psavert, order.by = economics$date)

# 실업자 수
eco_b <- xts(economics$unemploy/1000, order.by = economics$date)

eco2 <- cbind(eco_a, eco_b)                 # 데이터 결합(데이터프레임타입으로)
colnames(eco2) <- c("psavert", "unemploy")  # 변수명 바꾸기(알아보기 쉽도록)
head(eco2)

dygraph(eco2) %>% dyRangeSelector()

