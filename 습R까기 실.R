## 통계 변하는 값에서 어떤 의미를 찾는다.
## 작업의 50% 데이터 손질
## 데이터 관리/분석
##c() 벡터만드는 함수
##is() 성분확인 함수
##as.integer() 정수 변환 함수
##data.frame(이름=a,이름=b,이름=c) a,b,c요소를 행칼럼으로 만들어 순서대로 결합 이름: 칼럼명 입력
##str() 문장 성분 분석
##변수$칼럼명 칼럼을 모두 불러옴DF[[?]]로도 사용 가능:DF[]보다 한 개 더 들어감
##변수[c(?,?)] 필요한 칼럼만 불러옴
##attach() 검색목록에 올리기
##subset(DF,subset=(height>170)) 조건으로 변수 선택
##subset(DF,select=c(name,height),subset=(height>170)) 조건에서 칼럼선택
##subset(DF,select=-c(name,height),subset=(height>170)) 조건에서 마이너스만 제외
##colnames(DF)[6]<-"blood" 칼럼명 변경
##colnames(DF)<-c("na","na","na","na","na","na","na","na") 모두 바꾸기
##DF<-cbind(DF,BMI) 칼럼추가 함수
##DF<-merge(DF,omit, by="name") 이름에 맞춰 누락 셀추가

##DF<-rbind(DF,AddCol) 행추가

##HeightBySex<-split(DF$height,DF$sex) ??을 ??로 나눠라 함수
##mean(heightBySex[[1]]) 구분하여 평균구하기
##sapply(heightBySex,mean) 다 평균구하기
##sapply(heightBySex,sd)표준편차 구하기 편차가 클수록 퍼져 있다.
##Sapply(heightBySEX,range) 범위 구하기
##Freq<-table(DF$bloodtype) 항목별 개수 세기
##prop.table() 비율(도수) 구하기
##Table <- addmargins(Table, margin=2) 행렬의 합, 1 열합, 2 행합
##도수 분포표를 만들기 위해서 계급을 나눔
##FactorOfHeight<-cut(DF$height, breaks =4,lable=c('1','2','3')) 4구간으로 나누기( 포함하지않음)[포함]
##DOA<-table(cut(DF$age,breaks=(1:10*10))) 10개로 나누고 10개 단위로 구간 배정
##Freq <- table(FactorOfHeight) 구간별 개수 구하기
##cumsum(FreqofHeight[2,]) 누적상대도수 구하기기
##rownames(FreqOfHeight)<-c("도수","상대도수","누적도수") 행 이름 넣기
##colnames()<-c() 열이름
##colnames()<- NULL 이름 삭ㅈ
##complete.cases(a) NA 결측치를 True False로조사
##a<-a[complete.cases(a)] False 값 제거
##a<-na.omit(a) na 제거하며 행삭제
##na.rm() na값 분석시 제오
##read.csv() csv읽기
##fread() csv보다 빠른 읽기외
##qplot() 그래프 그리기
##which(colnames(Freq)=="1997") 위치를 알려 주거나 해당 값을 알려줌
##which.max(colnames(Freq)) 마지막 위치의 값을 구하기
##ndf<- data.frame(colnames(Freq), Freq[1,], Freq[2,], PF[1,], PF[2,])
##그래프 그리기
ggplot(ndf,aes(x=factor(Time),y=Close,group=1))+
  + geom_line(colour="steelblue1",size=1)+
  + geom_point(colour="steelblue", size=3)+
  + geom_line(aes(y=Open),colours="tomato2", size=1)+
  + geom_point(aes(y=Open),colours ="red", size=6)+
  + theme_bw()
##summary() 평균, 최소 최대 결측치 구하기
##Size[Size>10000]<-NA 해당 값 NA처리해서 제거하기
ggplot(data=DF,aes(x=sizeOfsite))+
  + geom_freqpoly(binwidth=10, Size=1.2, colour="orange")+
  + scale_x_continuous(limits=c(0,300),breaks=seq(0,300,20))+
  + theme_wsj()

##head(df,5) 상위 목록 5개 보기
##temp<-str_split_fixed(df[,1], "\\(",2)
##[,1]                          [,2]         
##[1,] "서울특별시  "                "1100000000)"
## tp<-str_split_fixed(df[,1],"\\(",2)
##> nc<-str_split_fixed(tp[,1]," ", 2)
##> colnames(nc)<-c("provinces","City")
##> df<-data.frame(nc,df[,c(2:7)])
##> df[df==" "]<-NA
##> head(df,10)
##provinces      City Population Households PersInHou      Male    Female SexRatio
##1  서울특별시      <NA> 10,078,850  4,197,478      2.40 4,962,774 5,116,076     0.97
##2  서울특별시   종로구     155,695     72,882      2.14    76,962    78,733     0.98
##df<-df[complete.cases(df),]

##> for(i in 3:8){
##  + df[,i]<-sapply(df[,i],function(x) gsub(",","",x))
##  + df[,i]<-as.character(df[,i])
##  + df[,i]<-as.numeric((df[,i]))
##  + }

##propopul<-tapply(df$Population,df$provinces,sum)
##> df[,1]<-factor(df[,1])
##> propopul<-tapply(df$Population,df$provinces,sum)
##> propopul
##강원도         경기도       경상남도       경상북도     광주광역시     대구광역시     대전광역시     부산광역시     서울특별시 
##1547166       18723822        4428762        3215695        1476974        2491137        1525656        3517491 
##gr<-ggplot(df, aes(x=Provinces,y=Population, fill=Provinces))+geom_bar(stat="identity")+theme_wsj()
mean(height,na.rm=T) 평균구하기 na 제외
[1] 170.0353

> median(height,na.rm=T) 중앙값
[1] 169.2
> range(height,na.rm=T) 범위 구하깁ㅂㅂㅂㅂ
[1] 155.2 182.1
> quantile(height, na.rm=T)사분위 구하기
0%   25%   50%   75%  100% 
155.2 165.3 169.2 176.1 182.1 

IQR(height, na.rm=T) Q1, Q3보기
[1] 10.8
summary(height,na.rm=T) 최소 평균 중간 q1, q3보기
Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
155.2   165.3   169.2   170.0   176.1   182.1 
boxplot(height) na 제거후 박스표를 보여줌
> cor(height, weight) 상관관계를 보여주며 자세한 것은 cor.test()로 확인
[1] 0.6641816
cor(height, weight, use = "complete.obs") complete.obs = na 전체 제거하여 줌ㅊㅊㅊㅊㅊㅊㅇㅇㅇㅇㅇㅁ
[1] 0.6641816
cor(height, weight, use="pairwise.complete.obs") na 해당치 제거 후 계사
[1] 0.6641816
> sal<-list(평균월급=me, 중앙값월급=mid) 리스트에 담ㄱ
> sal
$`평균월급`
[1] 2171578

$중앙값월급
[1] 2120345기

iqr<-IQR(salary,na.rm=T,type=7) 사분위 중앙ㄱ
> iqr
[1] 834139값

boxplot(age,range=1.5) 박스 iqr에서 1.5배로 아웃라이더 위치하도록 위치

> distIQR<-IQR(age,na.rm=T) IQR 길ㅇ
> posIQR<-quantile(age,probs=c(0.25,0.75), na.rm=T) IQR위치
> posIQR
25% 75% 
  55  72 
> down<-posIQR[[1]]-distIQR*1.5 25%지점에서 IQR 1.5배연장
> up<-posIQR[[2]]+distIQR*1.5 75%지점에서 IQR1.5배 연자
> Outlier<-subset(df,subset=(df$age<down|df$age>up)) 아웃라이어 관측ㅍ
> Outlier
age sex height weight dateOfoperation cancerStaging hospitalization diseaseCode
426    29  남  162.0   70.6      2011-05-17            II              24        C184
531    28  남  151.4   44.9      2011-08-02             I               8        C187
