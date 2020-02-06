library(rvest)
library(stringi)
library(tidyr)
library(reshape2)

#--------- Function webscraping Bukalapak ----------
#Jalankan line ke-8 hingga ke-45
webscrapping_bukalapak <- function(puturl, putid){
  url <- puturl
  webpage <- read_html(url)
  
  produk_html <- html_nodes(webpage,'product_name, .line-clamp--2,.js-tracker-product-line a')
  produk <- html_text(produk_html)
  
  harga_html <- html_nodes(webpage,'.product-price')
  harga_awal <- html_text(harga_html)
  
  rating_html <- html_nodes(webpage,'.product__rating')
  rating <- html_text(rating_html)
  rating_awal <- gsub("\n","",rating)
  rating_awal_2 <- gsub("ulasan","",rating)
  rating_awal_3 <- as.numeric(rating_awal_2) 
  rating <- round(rating_awal_3, digits = 2)
  
  dataframea <- data.frame(produk, rating)
  dataframea$id <- c(putid)
  dataframea
  
  dataframeb <- colsplit(harga_awal, "Rp", c('harga','harga awal','harga diskon'))
  dataframeb$harga <- NULL
  dataframeb$id <- c(putid)
  dataframeb
  z <- dataframeb$`harga awal`
  y <- gsub("Cicilan","",z)
  harga_awal_b <- gsub("0%","",y)
  
  v <- dataframeb$`harga diskon`
  w <- gsub("Cicilan","",v)
  harga_diskon <- gsub("0%","",w)
  id <- c(putid)
  
  dataframeb <- data.frame(harga_awal_b,harga_diskon,id)
  
  total <- merge(dataframea,dataframeb,by="id")
}

#---------- Menjalankan Function webscrapping Bukalapak --------
#Masukan link web bukalapak yang akan di analisis, serta id untuk data
# format: 
# nama_dataframe <- webscrapping_bukalapak(link, id_produk)
#contoh:
# analsis_bukalapak <- webscrapping_bukalapak('https://www.bukalapak.com/c/fashion-pria?from=category_home&search%5Bkeywords%5D=', 51:100)
analsis_bukalapak <- webscrapping_bukalapak('https://www.bukalapak.com/c/fashion-pria?from=category_home&search%5Bkeywords%5D=', 51:100)


#-----------export data ke csv---------- 
#mengecek lokasi file dimana data akan diexport
getwd()

#merubak lokasi file dimana akan diexport
#setwd('lokasi data akan disimpan')
#contoh:
#setwd('C:\\Users\\user\\Documents\\')

setwd("C:\\Users\\ANDRI\\Downloads")

#export data kecsv
#write.csv(dataframe-yang-akan-diexport,'nama_file.csv')
write.csv(analsis_bukalapak,'bukalapak.csv')