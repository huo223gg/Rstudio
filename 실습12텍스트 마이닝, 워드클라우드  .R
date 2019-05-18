[12] 텍스트 마이닝, 워드클라우드
1. 비정형 데이터

- 문서, 그림, 음성, 영상처럼 구조화되지 않은 데이터
- 형태와 구조가 다양한 정보

(1) 비정형 데이터의 분석

1) 텍스트 마이닝

- 자연어 처리 방식을 이용하여 정보를 추출하는 기법
- 정보 검색 – 추출 – 체계화 - 분석의 과정

2) 오피니언 마이닝

- 특정 주제나 대상에 대한 사람들의 주관적이고 감정적인 의견을 분석하여 선호도 판별

2. 한글 텍스트 마이닝 

- 텍스트 마이닝(Text mining) : 문자로 된 데이터에서 가치 있는 정보를
얻어내는 분석기법
- 형태소 분석(Morephology Analysis) : 텍스트 마이닝 할때 가장 먼저 하는 작업,
어절들의 품사 파악
- 형태소 분석으로 어절들의 품사를 파악후 명사,동사, 형용사 등 의미를 지닌
품사의단어를 추출해 각 단어가 얼마나 많이 등장했는지 확인하다.

(1) 힙합가사 텍스트 마이닝

1) 패키지 준비
- 한글 자연어 분석 패키지인 KoNLP(Korean Natural Language Processing)를 이용하면 한글 데이터로
형태소를 분석할 수 있다.
- KoNLP는 자바가 설치 되어있어야 한다. 자바 설치후 환경변수 설정을 한다.
- KoNLP패키지는 rJava와 memoise패키지가 설치되어 있어야 한다.
- 세개의 패키지를 설치후 전처리 작업에 사용할 dplyr패키지를 로드한다.

install.packages("rJava")
install.packages("memoise")
install.packages("KoNLP")

# 패키지 로드
library(KoNLP)
library(dplyr)

※ rJava Error가 나면 자바설치된 폴더의 경로를 설정하는 코드를 실해 한후 다시 로드합니다.
# java 폴더 경로 설정
Sys.setenv(JAVA_HOME="C:/Program Files/Java/jre1.8.0_171")


2) 사전 설정
- KoNLP에서 지원하는 NIA사전은 98만여 개의 단어로 구성되어 있다.
- 형태소 분석을 위해 이사전을 이용하도록 설정한다.

> useNIADic()
Backup was just finished!
  983012 words dictionary was built.


3) 데이터 준비
- 예제테스트 hiphop.txt파일을 프로젝트 폴더에 넣는다.
- readLine()로 데이터를 R로 가져온다.
- 데이터는 맬론차트 랩/힙합 부문 2017년 3월 둘째 주 50위까지의 노래 가사로 이루어졌다.

> txt <- readLines("./data/12/hiphop.txt")
Warning message:
  In readLines("hiphop.txt") : incomplete final line found on 'hiphop.txt'
> head(txt)
[1] "\"보고 싶다"                  "이렇게 말하니까 더 보고 싶다" "너희 사진을 보고 있어도"     
[4] "보고 싶다"                    "너무 야속한 시간"             "나는 우리가 밉다"      


4) 특수문자 제거하기
- stringr패키지의 str_replace_all()을 이용해서 문장에 들어있는 특수문자를 빈값으로 수정한다.
- '\\W'는 특수문자를 나타내는 정규표현식 이다. W는 대문자이므로 참고 소문자면 반대로 문자가 삭제됨.

install.packages("stringr")
library(stringr)

# 특수문제 제거
txt <- str_replace_all(txt, "\\W", " ") #W 대문자, " " 공백 철저히




5) 가장 많이 사용되는 단어 추출
- 가사의 명사를 추출한다 KoNLP의 extractNoun()를 이용해서 문장에서 명사를 추출한다.
- 두 글자 이상으로 된 단어만 추출한다. nchar()를 이용한다.

> extractNoun("대한민국의 영토는 한반도와 그 부속도서로 한다")
[1] "대한민국" "영토"     "한반도"   "부속도서" "한"      

# 가사에서 명사추출. list로 나와서 형변환을 해서 빈도수 확인;
nouns <- extractNoun(txt)

# 추출한 명사 list를 문자열 벡터로 변환, 단어별 빈도표 생성
wordcount <- table(unlist(nouns))

# 데이터 프레임으로 변환stringsAsFactors = F:캐릭터로 인식함.
df_word <- as.data.frame(wordcount, stringsAsFactors = F) 

# 변수명 수정
df_word <- rename(df_word,
                  word = Var1,
                  freq = Freq)

# 두 글자 이상 단어 추출
df_word <- filter(df_word, nchar(word) >= 2)

#빈도순으로 정렬한 후 상위 20개 단어를 추출한다. 세세한 정제로 작업이 필요함.
top_20 <- df_word %>%
  arrange(desc(freq)) %>%
  head(20)

> top_20
word freq
1   you   89
2    my   86
3   YAH   80
4    on   76
5  하나   75
6  오늘   51
7   and   49
8  사랑   49
9  like   48
10 우리   48
11  the   43
12 시간   39
13 love   38
14   to   38
15   we   36
16   it   33
17   em   32
18  not   32
19 역사   31
20 flex   30



6) 워드 클라우드 만들기
- 워드 클라우드(word clound)는 단어를 빈도를 구름 모양으로 표현한 그래프이다.
- 단어의 빈도에 따라 글자의 크기와 색깔이 다르게 표현되기 때문에 어떤 단어가 얼마나
많이 사용됐는지 한눈에 파악할 수 있다.
- 힙합가사에 자주 사용된 단어로 워드 클라우드를 생성한다.

# 패키지 설치
install.packages("wordcloud")

# 패키지 로드
library(wordcloud)
library(RColorBrewer)

pal <- brewer.pal(8,"Dark2")  # Dark2 색상 목록에서 8개 색상 추출

wordcloud(words = df_word$word,  # 단어
          freq = df_word$freq,   # 빈도
          min.freq = 2,         # 최소언급 횟수 지정(이 값 이상 언급된 단어만 출력)
          max.words = 200,   # 표시할 최대 단어 개수 지정 (출력된 단어 개수가 
          # 설정된 값 이상이라면, 최소 빈도수를 갖는 데이터부터 제거)
          random.order = F,  # 고빈도 단어 중앙 배치
          rot.per = .1,           # 단어 배치를 90° 각도로 출력할 단어비율(10%)
          scale = c(4, 0.3),     # 가장 많이 언급된 글자와 적게 언급된 글자의 크기 비율
          colors = pal)          # 색깔 목록






7) 단어색상 바꾸기
- 파란색 계열의 색상 목록을 만들어 빈도가 높을수록 진한 파란색으로 표현한다.
pal <- brewer.pal(9,"Blues")[5:9]  # 색상 목록 생성

wordcloud(words = df_word$word,    # 단어
          freq = df_word$freq,     # 빈도
          min.freq = 2,         # 최소언급 횟수 지정(이 값 이상 언급된 단어만 출력)
          max.words = 200,   # 표시할 최대 단어 개수 지정 (출력된 단어 개수가 
          # 설정된 값 이상이라면, 최소 빈도수를 갖는 데이터부터 제거)
          random.order = F,  # 고빈도 단어 중앙 배치
          rot.per = .1,           # 단어 배치를 90° 각도로 출력할 단어비율(10%)
          scale = c(4, 0.3),     # 가장 많이 언급된 글자와 적게 언급된 글자의 크기 비율
          colors = pal)          # 색깔 목록









(2) 국정원 트윗 텍스트 마이닝  

- 텍스트 마이닝은 소셜네트워크에 올라온 글을 통해 사람들이 어떤생각들을 하고 있는지를
알아보기 위한 목적으로 자주 활용된다.
- 무작위로 나열된 것처럼 보이는 수많은 글 중에서 의도가 분명한 경향성을 발견할 수 있다.
- 국정원 계정의 트윗 3,744개의 데이터를 이용한다.

1) 데이터 준비
- twitter.csv파일을 프로젝트 폴더의 data폴더에 넣는다.
- 한글변수명을 다루기 쉽게 영어이름으로 변경하고 특수문자 제거한다.

# 데이터 로드
twitter <- read.csv("./data/12/twitter.csv", #data frame 타입으로 불러ㅇ
                    header = T, # 헤드명 그대로 사요
                    stringsAsFactors = F, #범주가 생기므로 애매한 분리가 이뤄짐.
                    fileEncoding = "UTF-8")

# 변수명 수정
twitter <- rename(twitter,
                  no = 번호,
                  id = 계정이름,
                  date = 작성일,
                  tw = 내용)

# 특수문자 제거
twitter$tw <- str_replace_all(twitter$tw, "\\W", " ")

> head(twitter$tw)
[1] "민주당의 ISD관련 주장이 전부 거짓으로 속속 드러나고있다  미국이 ISD를 장악하고 있다고 주장하지만 중재인 123명 가운데 미국인은 10명뿐이라고 한다 "                                                                               
[2] "말로만  미제타도   사실은  미제환장   김정일 운구차가 링컨 컨티넬탈이던데 북한의 독재자나 우리나라 종북들이나 겉으로는 노동자  서민을 대변한다면서 고급 외제차  아이팟에 자식들 미국 유학에 환장하는 위선자들인거죠"            
[3] "한나라당이 보수를 버린다네요 뭔가착각하는모냥인에 국민들이보수를싫어하는게 아니라뻘짓거리하는분들을싫어하는겁니다야당이진보어쩌고저쩌고한다고해서그들을조아한다고생각하면대착각"                                                
[4] "FTA를 대하는 현명한 자세  사실 자유주의 경제의 가장 큰 수해자는 한국이죠  농어업분야 피해를 줄이는 정부대안을 최대한  보완하고 일자리 창출 등 실익을 최대화해 나가는게 현실적인 대처자세일듯 "                                  
[5] "곽노현씨 갈수록 가관입니다  뇌물질에 아들 병역 의혹까지  도대체 아이들이 뮐 보고 배우겠습니까  이래도 자리 연연하시겠습니까 "                                                                                                   
[6] "과거 집권시 한미FTA를 적극 추진하던 세력이 이제 집권하면 폐기하겠다고 주장합니다  어이없어 말도 안 나오네요  표만 얻을 수 있다면 국가 안보나 경제가 어떻게 되든 상관없다는 무책임한 행태들  우리 정치의 후진성을 드러내는 거죠 "



2) 단어 빈도표 생성 
- 트윗에서 명사 추출후, 각 단어가 몇 번씩 사용됐는지 나타낸 빈도표를 만든다.
- 두 글자 이상된 단어 추출후 빈도순으로 정렬하여 상위20개 추출한다

# 트윗에서 명사추출
nouns <- extractNoun(twitter$tw)

# 추출한 명사 list를 문자열 벡터로 변환, 단어별 빈도표 생성
wordcount <- table(unlist(nouns))

# 데이터 프레임으로 변환
df_word <- as.data.frame(wordcount, stringsAsFactors = F)

# 변수명 수정
df_word <- rename(df_word,
                  word = Var1,
                  freq = Freq)


# 두 글자 이상 단어만 추출
df_word <- filter(df_word, nchar(word) >= 2)

# 상위 20개 추출
top20 <- df_word %>%
  arrange(desc(freq)) %>%
  head(20)

> top20
word freq
1      북한 2216
2  대한민국  804
3      우리  779
4      좌파  641
5      국민  550
6      들이  428
7      세력  409
8      친북  385
9    김정일  342
10     단체  335
11     진보  333
12     대선  329
13   천안함  319
14     사회  307
15     정부  283
16   전교조  278
17     주장  269
18     정권  263
19   연평도  262
20     국가  242

3) 단어 빈도 막대그래프 생성
- ggplot2를 이용하여 막대 그래프 만든다.

library(ggplot2)

order <- arrange(top20, freq)$word               # 빈도 순서 변수 생성

ggplot(data = top20, aes(x = word, y = freq)) +  
  ylim(0, 2500) +
  geom_col() + 
  coord_flip() +
  scale_x_discrete(limit = order) +              # 빈도 순서 변수 기준 막대 정렬
  geom_text(aes(label = freq), hjust = -0.3)     # 빈도 표시= 그래프에서의 거리를 설정해줌.

ggplot(data = top20, aes(x = word, y = freq)) +  
  ylim(0, 2500) +
  geom_col() + 
  scale_x_discrete(limit = order) +
  coord_flip() +              # 빈도 순서 변수 기준 막대 정렬
  geom_text(aes(label = freq), hjust = -0.3)     # 빈도 표시= 그래프에서의 거리를 설정해줌.



4) 워드 클라우드 생성

pal <- brewer.pal(8,"Dark2")       # 색상 목록 생성

wordcloud(words = df_word$word,    # 단어
          freq = df_word$freq,     # 빈도
          min.freq = 10,         # 최소언급 횟수 지정(이 값 이상 언급된 단어만 출력)
          max.words = 200,   # 표시할 최대 단어 개수 지정 (출력된 단어 개수가 
          # 설정된 값 이상이라면, 최소 빈도수를 갖는 데이터부터 제거)
          random.order = F,  # 고빈도 단어 중앙 배치
          rot.per = .1,           # 단어 배치를 90° 각도로 출력할 단어비율(10%)
          scale = c(6, 0.2),     # 가장 많이 언급된 글자와 적게 언급된 글자의 크기 비율
          colors = pal)          # 색깔 목록



- 단어 색상을 파란계열로 바꿔 워드 클라우드 생성

pal <- brewer.pal(9,"Blues")[5:9]  # 색상 목록 생성

wordcloud(words = df_word$word,    # 단어
          freq = df_word$freq,     # 빈도
          min.freq = 10,         # 최소언급 횟수 지정(이 값 이상 언급된 단어만 출력)
          max.words = 200,   # 표시할 최대 단어 개수 지정 (출력된 단어 개수가 
          # 설정된 값 이상이라면, 최소 빈도수를 갖는 데이터부터 제거)
          random.order = F,  # 고빈도 단어 중앙 배치
          rot.per = .1,           # 단어 배치를 90° 각도로 출력할 단어비율(10%)
          scale = c(6, 0.2),     # 가장 많이 언급된 글자와 적게 언급된 글자의 크기 비율
          colors = pal)          # 색깔 목록


※ wordcloud함수 설명
wordcloud(words = df_word$word,    # 단어
          freq = df_word$freq,        # 빈도
          min.freq = 10,         # 최소언급 횟수 지정(이 값 이상 언급된 단어만 출력)
          max.words = 200,   # 표시할 최대 단어 개수 지정 (출력된 단어 개수가 
          # 설정된 값 이상이라면, 최소 빈도수를 갖는 데이터부터 제거)
          random.order = F,  # 고빈도 단어 중앙 배치
          rot.per = .1,           # 단어 배치를 90° 각도로 출력할 단어비율(10%)
          scale = c(6, 0.2),     # 가장 많이 언급된 글자와 적게 언급된 글자의 크기 비율
          colors = pal)          # 색깔 목록



words 수만큼 freq (빈도)를 나타낸다.
등장하는 단어의 가장 작은 빈도 수는10로,
등장하는 단어의 가장 큰 빈도 수는 200이다.
빈도가 가장 큰 단어를 중앙에 두도록 하기 위해 random order는 False 값을 준다.
scale(폰트의 크기)은 최고 6픽셀에서, 제일 작은건 0.2 픽셀까지
rotation(세로로 출력되는)  단어의 비율은 10%정도로 하고, 
컬러는 위에서 정한 pal의 값으로 컬러 팔레트를 사용한다. 






※ library(RColorBrewer) 색상정보

> brewer.pal.info
maxcolors category colorblind
BrBG            11      div       TRUE
PiYG            11      div       TRUE
PRGn            11      div       TRUE
PuOr            11      div       TRUE
RdBu            11      div       TRUE
RdGy            11      div      FALSE
RdYlBu          11      div       TRUE
RdYlGn          11      div      FALSE
Spectral        11      div      FALSE
Accent           8     qual      FALSE
Dark2            8     qual       TRUE
Paired          12     qual       TRUE
Pastel1          9     qual      FALSE
Pastel2          8     qual      FALSE
Set1             9     qual      FALSE
Set2             8     qual       TRUE
Set3            12     qual      FALSE
Blues            9      seq       TRUE
BuGn             9      seq       TRUE
BuPu             9      seq       TRUE
GnBu             9      seq       TRUE
Greens           9      seq       TRUE
Greys            9      seq       TRUE
Oranges          9      seq       TRUE
OrRd             9      seq       TRUE
PuBu             9      seq       TRUE
PuBuGn           9      seq       TRUE
PuRd             9      seq       TRUE
Purples          9      seq       TRUE
RdPu             9      seq       TRUE
Reds             9      seq       TRUE
YlGn             9      seq       TRUE
YlGnBu           9      seq       TRUE
YlOrBr           9      seq       TRUE
YlOrRd           9      seq       TRUE



par(mfrow=c(1, 3))
display.brewer.all(type="div")
display.brewer.all(type="seq")
display.brewer.all(type="qual")

pal <- brewer.pal(9,"Blues")[5:9] #원하는 색스타일을 선택하여 갯수와 이름을 입력,일정 색은 [:]로 정해주면 됨.

