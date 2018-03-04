library(rvest)
library(wordcloud)
library(KoNLP)
library(Sejong)
library(NIADic)
install.packages(NIADic)
useNIADic()
useSejongDic()
# webcrawling libarary
# daum 영화 평점 페이지 url

allText<-NULL
page <- c(1:10)
for(i in page){ #8장 데이터 관리의 자동화
  #6장 효율적인 데이터 관리
  url<-sprintf("http://movie.daum.net/moviedb/grade?movieId=95501&type=netizen&page=%d",i)
  
  #다음 영화 평점 페이지의 html을 r로 가져오기
  daumMovieSrc<-read_html(url)
  #class ="desc_review"부분에 리뷰 글이 있으므로 그 부분만 추출하기
  daumMovieTag<-html_nodes(daumMovieSrc,".desc_review")
  #텍스트 부분만 추출하기
  daumMoiveText<-html_text(daumMovieTag)
  
  #추출한 부분 콘솔 추력하기
  ##print(daumMovieText)
  daumMoiveText<-gsub("\t","", daumMoiveText)
  daumMoiveText<-gsub("\n","", daumMoiveText)
  daumMoiveText<-gsub("\r","", daumMoiveText)
  daumMoiveText<-unlist(daumMoiveText)
  daumMoiveText<-Filter(function(x){nchar(x)>=2}, daumMoiveText)
  allText<-c(allText,daumMoiveText)
  
}

print(allText)

#명사추출
noun1<-extractNoun(allText)
noun1
noun2<-unlist(noun1)
table(noun3)
noun3<-noun2[nchar(noun2)>=2]
nounCount1<-table(noun3)

nounCount<-head(sort(nounCount1, decreasing = TRUE), 15)

wordcloud(names(nounCount), freq = nounCount, scale = c(5,2),
          rot.per = 0.25, min.freq=2, random.order = FALSE, random.color = FALSE)

#Wordcloud Color
library(RColorBrewer)
palete<-brewer.pal(12,"Paired")
wordcloud(names(nounCount), freq = nounCount, scale = c(5,2),
          rot.per = 0.25, min.freq=2, random.order = FALSE, random.color = TRUE, colors = palete)

??RColorBrewer
