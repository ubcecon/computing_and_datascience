This example uses preliminary R packages without advanced function. The main goal is to parse an html web page and extract tables from the web page. \#\# Preload packages This script requires httr, XML, stringr. We are using GET function from httr httr: <https://cran.r-project.org/web/packages/httr/httr.pdf>

For parsing the XML, we use the htmlParse,readHTMLTable from XML <https://cran.r-project.org/web/packages/XML/XML.pdf>

The stringr package is used for parsing the strings. <http://edrub.in/CheatSheets/cheatSheetStringr.pdf>

dplyr cheat sheet: <https://www.rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf>

``` r
for (pkg in c("rvest","httr","dplyr","stringr","XML","RCurl","ggplot2","reshape")){
 if (!pkg %in% rownames(installed.packages())){install.packages(pkg)}
}
library(rvest)
```

    ## Loading required package: xml2

``` r
library(httr)
library(dplyr)
```

    ## 
    ## Attaching package: 'dplyr'

    ## The following objects are masked from 'package:stats':
    ## 
    ##     filter, lag

    ## The following objects are masked from 'package:base':
    ## 
    ##     intersect, setdiff, setequal, union

``` r
library(stringr)
library(XML)
```

    ## 
    ## Attaching package: 'XML'

    ## The following object is masked from 'package:rvest':
    ## 
    ##     xml

``` r
library(RCurl)
```

    ## Loading required package: bitops

Realtime data collecting
------------------------

This section collect realtime data from yahoo finance currency page. Other pages are also available for data collect. Examples are listed below.

``` r
url_crypto <-"https://ca.finance.yahoo.com/cryptocurrencies"
url_commo <- "https://ca.finance.yahoo.com/commodities"
url_curr <- "https://ca.finance.yahoo.com/currencies"
i = 0 
currency_price <- data.frame()
time_list <- c()
while (i < 10){
  web_page_parsed <- htmlParse(GET(url_curr), encoding = "UTF-8") #Parse the HTML
  table <- readHTMLTable(web_page_parsed) #Extract table from HTML
  table <- table[[1]][,1:3] #Only keep the 3rd table, digit part
  names(table) <- c("Symb","Name","price") #Change dataframe name for easy merge
  price_list <-as.numeric(strsplit(toString(table$price),",")[[1]])[1:28] #Process the data type, for all 28 FX price
  name_list <- strsplit(toString(table$Name),",")[[1]][1:28] #Get the name of the FX
  currency_price <- rbind(currency_price,price_list) #Merge the fetched data into the metadata
  colnames(currency_price) <- name_list #Rename the columns of the metadata
  time_list <- c(time_list,toString(Sys.time())) #Append the time to time_list
  Sys.sleep(5) #Sleep for 5 secs
  i = i + 1
}
currency_price$time <- time_list
print(head(currency_price))
```

    ##   CAD/USD  CAD/EUR  CAD/GBP  CAD/CNY  EUR/USD  USD/JPY  GBP/USD  USD/CHF
    ## 1    0.76     0.67   0.5805   5.2489   1.1321  113.606  1.30014  1.00596
    ## 2    0.76     0.67   0.5805   5.2489   1.1321  113.606  1.30014  1.00596
    ## 3    0.76     0.67   0.5805   5.2489   1.1321  113.607  1.30014  1.00593
    ## 4    0.76     0.67   0.5805   5.2489   1.1322  113.607  1.30017  1.00597
    ## 5    0.76     0.67   0.5805   5.2489   1.1322  113.590  1.30017  1.00602
    ## 6    0.76     0.67   0.5805   5.2489   1.1322  113.600  1.30017  1.00596
    ##    AUD/USD  AUD/JPY  NZD/USD  EUR/JPY  GBP/JPY  EUR/GBP  EUR/SEK  EUR/CHF
    ## 1   0.7240   82.191   0.6793  128.588  147.687  0.87042 10.27400  1.13856
    ## 2   0.7240   82.191   0.6793  128.588  147.687  0.87042 10.27400  1.13856
    ## 3   0.7240   82.196   0.6793  128.590  147.703  0.87050 10.27399  1.13811
    ## 4   0.7238   82.196   0.6793  128.589  147.708  0.87051 10.27405  1.13863
    ## 5   0.7238   82.184   0.6793  128.583  147.699  0.87053 10.27365  1.13865
    ## 6   0.7238   82.189   0.6793  128.580  147.698  0.87053 10.27364  1.13865
    ##    EUR/HUF  EUR/JPY  USD/CNY  USD/HKD  USD/SGD  USD/INR  USD/MXN  USD/PHP
    ## 1   322.33  128.588   6.9499   7.8308  1.37850   72.304  20.3953    53.08
    ## 2   322.33  128.588   6.9499   7.8308  1.37850   72.304  20.3953    53.08
    ## 3   322.37  128.590   6.9499   7.8308  1.37872   72.304  20.3986    53.08
    ## 4   322.37  128.589   6.9499   7.8306  1.37848   72.304  20.3986    53.08
    ## 5   322.40  128.583   6.9499   7.8306  1.37867   72.304  20.3986    53.08
    ## 6   322.40  128.580   6.9499   7.8306  1.37854   72.304  20.3955    53.08
    ##    USD/IDR  USD/THB  USD/MYR  USD/ZAR                time
    ## 1       14      785   32.922   4.1945 2018-11-14 15:41:55
    ## 2       14      785   32.922   4.1945 2018-11-14 15:42:01
    ## 3       14      785   32.922   4.1945 2018-11-14 15:42:07
    ## 4       14      785   32.922   4.1945 2018-11-14 15:42:12
    ## 5       14      785   32.933   4.1945 2018-11-14 15:42:18
    ## 6       14      785   32.933   4.1945 2018-11-14 15:42:24

Plot the Data from the last 10 seconds
--------------------------------------

Reshape <https://www.statmethods.net/management/reshape.html>

GGplot2 cheat sheet: <https://www.rstudio.com/wp-content/uploads/2015/03/ggplot2-cheatsheet.pdf>

``` r
library(ggplot2)
library(reshape)
```

    ## 
    ## Attaching package: 'reshape'

    ## The following object is masked from 'package:dplyr':
    ## 
    ##     rename

``` r
price_plot <- melt(currency_price,"time")
ggplot2::ggplot(price_plot,aes(x = time, 
                               y = value, 
                                  group = variable, color = variable)) + 
                                geom_line(size = 1.2, alpha = 0.5)   
```

![](Yahoo-realtime_files/figure-markdown_github/unnamed-chunk-1-1.png)

Real time example
-----------------

These two examples use the same script. Instead we setting the Sys.sleep() to 60 seconds and collect 100 data points.

![](Yahoo_realtime_files/figure-markdown_github/GBP_USD.png) ![](Yahoo_realtime_files/figure-markdown_github/GBP_JPY.png)
