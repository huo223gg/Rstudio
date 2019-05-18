main_url = "https://kin.naver.com/search/list.nhn?query=%ED%81%AC%EB%A6%AC%EC%8A%A4%EB%A7%88%EC%8A%A4&section=qna"

reply_list = character()


for(pager_url in 1:10){
  
  url=paste(main_url,pager_url, sep ="")
  content = read_html(url)
  
  node_1 = html_nodes(content,"._searchListTitleAnchor")


  reply = html_text(node_1)

  
  reply_list = append(reply_list, reply)

  
}

df = data.frame(reply_list)
colnames(df) = c("Á¦¸ñ")

write.csv(df,file = "ssss.csv", row.names=FALSE)


.link_issue