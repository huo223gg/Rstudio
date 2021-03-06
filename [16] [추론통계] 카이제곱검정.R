[16] [추론통계] 카이제곱검정
1. 교차분석과 카이제곱 검정

- 교차분석은 두 개 이상의 범주형 변수를 대상으로 교차 분할표를 작성하고, 이를 통해서
변수 상호 간의 관련성 여부를 분석한다.

- 교차분석은 특히 빈도분석결과에 대한 보충자료를 제시하는 데 효과적으로 이용할 수 있다.

- 카이제곱검정은 교차분석을 얻어진 교차 분할표를 대상으로 유의확률을 적용하여 변수 간의
독립성 및 관련성 여부 등을 검정하는 분석방법이다.


(1) 교차분석  

- 교차 분석(Cross Table Analyze)은 범주형 자료(명목 척도, 서열 척도)를 대상으로 두개 이상의 변수들에
대한 관련성을 알아보기 위해서 결합분포를 나타내는 교차 분할표를 작성하고 이를 통해서 변수 상호 간의
관련성 여부를 분석하는 방법

- 빈도분석의 특성별 차이를 분석하기 위해 수행하는 분석방법으로 빈도분석결과에 대한 보충자료를
제시하는데 효과적임.

- 비율척도인 경우는 범주형 자료로 변경해서 사용함
예) 10 ~ 19: 1, 
20 ~ 29: 2,
30 ~ 39: 3 등으로 범주화하여 변경해야함.


1) R에서 교차분석 생성

################### R 실습 #####################
data <- read.csv("data/16/cleanDescriptive.csv", header=TRUE)
data # 확인
head(data) # 변수 확인

x <- data$level2 # 리코딩 변수 이용
y <- data$pass2 # 리코딩 변수 이용
x; y # 부모학력수준(x) -> 자녀대학진학여부(y) 

#데이터프레임 생성 
result <- data.frame(Level=x, Pass=y) # 데이터 프레임 생성 - 데이터 묶음
dim(result) # 차원보기
head(result)


# 교차분할표 작성   
table(result) # 빈도보기


> table(result) # 빈도보기
Pass
Level      실패 합격
고졸       40   49
대졸       27   55
대학원졸   23   31


# [실습] 패키지를 이용한 부모 학력 수준과 자녀 대학진학 여부 교차 분할표 작성 
install.packages("gmodels") # gmodels 패키지 설치
library(gmodels) # CrossTable() 함수 사용


x <- data$level2
y <- data$pass2
CrossTable(x, y)



[해설] 
- 기대비율은 카이제곱 식에서 구해진 결과이다.

- 카이제곱 공식의 기댓값은 [(현재 셀의 행합 * 현재 셀의 열합)/전체관측치 ]으로
구해진 결과값이다.

- 예를들면 위 교차표에서 부모의 학력수준이 고졸이면서 자녀가 대학에 합격할 경우의
기대값은 53.4 = (89 * 135)/225 이고 카이제곱 식에 의해 계산된 기대비율은 
0.3625=(49-53.4)²/53.4 가 된다.

- 이렇게 계산된 기대비율 6개(교차분할표 6개 셀)의 총합과 자유도(df)라는
검정통계량을 이용하여 두변인간의 관련성 여부를 검정하는 방법이 
카이제곱 검정이다.


2)  교차분할표 해석

- 부모의 학력수준에 따른 대학진학여부를 설문 조사한 결과 학력수준에 상관없이
대학진학 합격률이 평균 60.0로 학력 수준별로 유사한 결과가 나타났다.

- 전체 응답자 225명을 대상으로 고졸 39.6%(89명) 중 55.1%가 진학에 성공하였고,
대졸 36.4%(82명) 중 68.4%가 성공했으며, 대학원졸은 24%(54명)중 57.4%가 
대학 진학에 성공하였다.

- 특히 대졸부모의 대학진학 합격률이 평균보다 조금 높고, 고졸 부모의  대학진학
합격률이 평균보다 조금 낮은것으로 분석된다.






(2) 카이제곱검정

- 카이제곱검정은 범주별로(Categoy)별로 관측빈도와 기대빈도의 차이를 통해서 
확률모형이 데이터를 얼마나 잘 설명하는지를 검정하는 통계적 방법이다.

- 일반적으로 교차분석으로 얻어진 분할표를 대상으로 유의학률을 적용하여 변수 
간의 독립성(관련성) 여부를 검정하는 분석방법으로 사용한다.

- 교차분할표 생성함수 CrossTable()에  chisq=TRUE 속성을 적용하면 카이제곱검정
결과를 볼수 있다.

- 카이제곱의 유형으로는 일원 카이제곱, 이원 카이제곱 검정 으로 분류된다.



1) 일원 카이제곱 검정

- 교차분할표를 이용하지 않는 카이제곱검정으로 한 개의 변인(집단 또는 범주)을 대상으로
검정을 수행한다.

- 적합도 검정과 선호도 분석에서 주로 이용한다.


① 적합도 검정

- chisq.test()함수를 이용하여 관찰빈도와 기대빈도 일치여부를 검정한다.

- 귀무가설 : 기대치와 관찰치는 차이가 없다. (예:주사위는 게임에 적합하다.)

- 대립가설 : 기대치와 관찰치는 차이가 있다. (예:주사위는 게임에 적합하지 않다.) 

[실습] 주사위 적합도 검정

60회 주사위를 던져서 나온 관측도수와 기대도수가 다음과 같이 나오는 경우 이주사위는
게임에 적합한 주사위 인가를 일원카이제곱검정 방법으로 분석한다.


주사위 눈금	1	2	3	4	5	6
관측도수	4	6	17	16	8	9
기대도수	10	10	10	10	10	10

############## R 실습 ###############
chisq.test(c(4,6,17,16,8,9))

# Chi-squared test for given probabilities

# data:  c(4, 6, 17, 16, 8, 9)
# X-squared = 14.2, df = 5, p-value = 0.01439


② 카이제곱검정 결과 해석

- 유의확률로 해석하는 방법

유의확률(p-value : 0.01439)이 0.05 미만이기 때문에 유의미한 수준(α=0.05)
에서 귀무가설을 기각할 수 있다. 따라서 '주사위는 게임에 적합하다'라는
귀무가설은 기각하고 대립가설(주사위는 게임에 적합하지 않다)을 채택할 수 있다.


- 검정 통계량으로 해석하는 방법

검정통계량 : X-squared = 14.2, df=5
카이제곱은 관측값과 기대값을 이용하여 다음과 같은 식으로 구해진다.



자유도(df :degree of freedom)란 검정을 위해서 n개의 표본(관측치)을 선정한 경우
n번째 표본은 나머지 표본이 정해지면 자동으로 결정되는 변인의 수를 의미하기
때문에 자유도는 N-1로 표현된다.

자유도(df)와 유의수준(α)에 따른 X² 분포표에 의한 기각역을 결정할 수 있다.

검정 통계량이 자유도는 5이고, 유의수준이 0.05인 경우 chi-square분포표에 
의하면 임계값이 11.071에 해당된다.

그러므로 X-squared 기각값(역)은 X²  >= 11.071이 된다. 측 X² 값이 11.071이상이면
귀무가설은 기각된다. 따라서 X-squared 검정 통계량이 14.2이기 때문에 기각역에
해당하여, 귀무가설을 기각하고 , 대립가설을 채택할 수 있다.

※ chi-square분포표





③ 선호도 분석

- 선호도 분석은 적합도 검정과 마찬가지로 관측빈도와 기대빈도의 차이를 통해서
확률 모형이 주어진 자료를 얼마나 잘 서명하는지를 검정하는 통계적 방법이다.

- 차이점은 분석에 필요한 연구 환경과 자료라고 볼 수 있다.

- 귀무가설 :  기대치와 관찰치는 차이가 없다.(예: 스포츠음료에 대한 선호도에 차이가 없다)

- 대립가설 :  기대치와 관찰치는 차이가 있다.(예: 스포츠음료에 대한 선호도 차이가 있다)

?############## R 실습 ###############
data <- textConnection(
  "스포츠음료종류  관측도수
  1   41
  2   30
  3   51
  4   71
  5   61
  ")


x <- read.table(data, header=T)
x # 스포츠음료종류 관측도수


chisq.test(x$관측도수)

#Chi-squared test for given probabilities

#data:  x$관측도수
#X-squared = 20.488, df = 4, p-value = 0.0003999


- 유의확률로 해석
유의확률(p-value:0.0003999)이 0.05 미만이므로 유의미한 수준(α=0.05)에서
귀무가설을 기각할 수 있다.

따라서, '스포츠음료에 대한 선호도에는 차이가 없다'라는 귀무가설을 기각하고
대립가설 '스포츠음료에 대한 선호도에는 차이가 있다' 를 채택할 수 있다.

- 검정 통계량으로 해석

X-squared 기각값(역)은 X²  >= 9.49 된다. 측 X² 값이 9.49 이상이면
귀무가설은 기각된다. 따라서 X-squared 검정 통계량이 20.488 때문에 기각역에
해당하여, 귀무가설을 기각하고 , 대립가설을 채택할 수 있다.


따라서, '스포츠음료에 대한 선호도에는 차이가 없다'라는 귀무가설을 기각하고
대립가설 '스포츠음료에 대한 선호도에는 차이가 있다' 를 채택할 수 있다.




2) 이원 카이제곱 검정

- 한개이상의 변인(집단 또는 범주) 대상으로 교차 분할표를 이용하는 카이제곱검정 방법으로
분석대상의 집단수에 의해서 독립성 검정과 동질성 검정으로 나누어진다.

① 독립성 검정(관련성 검정)

- 동일 집단의 두변인을 대상으로 관련성이 있는지, 없는지를 검정하는 방법이다.

- 귀무가설(Hο) : 부모의 학력수준과 자녀의 대학진학 여부는 관련성이 없다

- 대립가설(H₁) : 부모의 학력수준과 자녀의 대학진학 여부는 관련성이 있다(연구가설)

?############## R 실습 ###############
# [실습] 패키지를 이용한 부모 학력 수준과 자녀 대학진학 여부 교차 분할표 작성 
data <- read.csv("data/16/cleanDescriptive.csv", header=TRUE)
data # 확인
head(data) # 변수 확인
x <- data$level2
y <- data$pass2
CrossTable(x, y)


# 교차테이블에 카이검정 적용 
CrossTable(x, y, chisq = T)
# 
#-------------------------------------------------------------------------------



- 유의확률로 해석
유의확률(p-value:0.2507057)이 0.05 이상이므로 유의미한 수준(α=0.05)에서
귀무가설을 기각할 수 없다.

따라서, '부모의 학력수준과 자녀의 대학진학 여부는 관련성이 없다'라는 귀무가설을 기각
할 수 없기 때문에  두 변인 간에 관령성이 있는 것으로 해석할 수 있다.

- 검정 통계량으로 해석
X-squared 기각값(역)은 X²  >= 5.99 된다. 측 X² 값이 5.99 이상이면
귀무가설은 기각된다. 그러나 X-squared 검정 통계량이 2.766951 이기 때문에
귀무가설을 기각할 수 없다.


- 논문/보고서에서 교차분석과 카이제곱검정 결과해석
부모의 학력 수준과 자녀의 대학진학 여부와 관련성이 있다를 분석하기위해서 
자녀를 둔 A회사 225명의 부모를 표본으로 추출한 후 설문 조사하여 교차분석과
카이제곱검정을 실시하였다.

분석결과를 살펴보면 부모의 학력 수준과 자녀의 대학진학 여부의 관련성은 
유의미한 수준에서 차이가 없는 것으로 나타났다(X² = 2.766951, p > 0.05) 
따라서 귀무가설을 기각할 수 없어서 부모의 학력 수준과 대학진학 여부와는
관련성이 없는 것으로 분석되었다.




② 동질성 검정

- 두집단의 분포가 동일한지, 아닌지를 검정하는 방법이다. 
즉, 동일한 분포를 가지는 모집단에서 추출된 것인지를 검정하는 방법이다.

- 귀무가설(Hο) : 교육방법에 따라 만족도 차이가 없다.

- 대립가설(H₁) : 교육방법에 따라 만족도 차이가 있다.(연구가설)

?############## R 실습 ###############

#[실습] 동질성 검정
data <- read.csv("data/16/homogenity.csv", header=TRUE)
head(data) 
# method와 survery 변수만 서브셋 생성
data <- subset(data, !is.na(survey), c(method, survey)) 
data

# 2. 변수리코딩 - 코딩 변경
# 교육방법2 필드 추가
data$method2[data$method==1] <- "방법1" 
data$method2[data$method==2] <- "방법2"
data$method2[data$method==3] <- "방법3"

# 만족도2 필드 추가
data$survey2[data$survey==1] <- "1.매우만족"
data$survey2[data$survey==2] <- "2.만족"
data$survey2[data$survey==3] <- "3.보통"
data$survey2[data$survey==4] <- "4.불만족"
data$survey2[data$survey==5] <- "5.매우불만족"

# 3. 교차분할표 작성 ※ 주의 반드시 각 집단의 길이가 같아야 한다.
table(data$method2, data$survey2)  # 교차표 생성 -> table(행,열)
#      1.매우만족 2.만족 3.보통 4.불만족
#방법1          5      8     15       16
#방법2          8     14     11       11
#방법3          8      7     11       15

#      5.매우불만족
#방법1            6
#방법2            6
#방법3            9

# 4. 동질성 검정 - 모수 특성치에 대한 추론검정  
chisq.test(data$method2, data$survey2) 

# Pearson's Chi-squared test

# data:  data$method2 and data$survey2
#X-squared = 6.5447, df = 8, p-value =
# 0.5865

- 유의확률로 해석
유의확률(p-value:0.5865)이 0.05 이상이므로 유의미한 수준(α=0.05)에서
귀무가설을 기각할 수 없다.

따라서, '교육방법에 따라 만족도 차이가 없다'라는 귀무가설을 기각
할 수 없다.


- 검정 통계량으로 해석
X-squared 기각값(역)은 X²  >= 15.51 된다. 측 X² 값이 15.51 이상이면
귀무가설은 기각된다. 그러나 X-squared 검정 통계량이 6.5447 이기 때문에 
귀무가설을 기각할 수 없다.

따라서 '교육방법에 따라 만족도 차이가 없다' 로 말할 수 있다.