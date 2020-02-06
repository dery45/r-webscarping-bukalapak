library(rvest)
library(stringi)
library(tidyr)
library(reshape2)

url <- 'https://www.bukalapak.com/c/fashion-pria/sepatu-169?from=navbar_categories&source=navbar'
webpage <- read_html(url)

produk_html <- html_nodes(webpage,'product_name, .line-clamp--2,.js-tracker-product-line a')
produk <- html_text(produk_html)

harga_html <- html_nodes(webpage,'.product-price')
harga_awal <- html_text(harga_html)

rating_html <- html_nodes(webpage,'.product__rating')
rating <- html_text(rating_html)
rating_awal <- gsub("\n","",rating)
rating_awal_2 <- gsub("ulasan","",rating)
rating <- as.numeric(rating_awal_2) 

dataframea <- data.frame(produk, rating)
dataframea$id <- c(1:50)
dataframea


str_split(tableout$harga, "Rp")
summary(tableout)
dataframeb <- colsplit(harga_awal, "Rp", c('harga','harga awal','harga diskon'))
dataframeb$harga <- NULL
dataframeb$id <- c(1:50)
dataframeb
z <- dataframeb$`harga awal`
y <- gsub("Cicilan","",z)
harga_awal_b <- gsub("0%","",y)

v <- dataframeb$`harga diskon`
w <- gsub("Cicilan","",v)
harga_diskon <- gsub("0%","",w)
id <- c(1:50)

dataframeb <- data.frame(harga_awal_b,harga_diskon,id)

total <- merge(dataframea,dataframeb,by="id")
total


write.csv(total,"C:\\Users\\ANDRI\\Documents\\Learn R Programming\\dataset\\bukalapak-jadi.csv")

