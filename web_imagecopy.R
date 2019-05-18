url ="https://news.sbs.co.kr/news/endPage.do?news_id=N1005017669&utm_source=dable"
sess <- read_html(url)
node <- html_node(sess.".text_area")
imgurl <- html_attr(node."src")

download.file(imgurl,destfile = "img_test.jpg", method = "curl")