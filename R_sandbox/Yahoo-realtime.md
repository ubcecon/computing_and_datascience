This example uses preliminary R packages without advanced function. The main goal is to parse an html web page and extract tables from the web page. \#\# Preload packages This script requires httr, XML, stringr. We are using GET function from httr httr: <https://cran.r-project.org/web/packages/httr/httr.pdf>

For parsing the XML, we use the htmlParse,readHTMLTable from XML <https://cran.r-project.org/web/packages/XML/XML.pdf>

The stringr package is used for parsing the strings. <http://edrub.in/CheatSheets/cheatSheetStringr.pdf>

dplyr cheat sheet: <https://www.rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf>

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
  web_page_parsed <- htmlParse(GET(url_curr), encoding = "UTF-8")
  table <- readHTMLTable(web_page_parsed)
  table <- table[[1]][,1:3]
  names(table) <- c("Symb","Name","price")
  price_list <-as.numeric(strsplit(toString(table$price),",")[[1]])[1:28]
  name_list <- strsplit(toString(table$Name),",")[[1]][1:28]
  # names(price_list) <- name_list
  currency_price <- rbind(currency_price,price_list)
  colnames(currency_price) <- name_list
  time_list <- c(time_list,toString(Sys.time()))
  Sys.sleep(5)
  i = i + 1
}
currency_price$time <- time_list
print(head(currency_price))
```

    ##   CAD/USD  CAD/EUR  CAD/GBP  CAD/CNY  EUR/USD  USD/JPY  GBP/USD  USD/CHF
    ## 1    0.76     0.67   0.5807   5.2488   1.1321  113.590  1.29970  1.00606
    ## 2    0.76     0.67   0.5807   5.2488   1.1321  113.590  1.29970  1.00606
    ## 3    0.76     0.67   0.5807   5.2488   1.1321  113.592  1.29970  1.00607
    ## 4    0.76     0.67   0.5807   5.2488   1.1322  113.592  1.29976  1.00600
    ## 5    0.76     0.67   0.5807   5.2488   1.1322  113.593  1.29976  1.00607
    ## 6    0.76     0.67   0.5807   5.2488   1.1322  113.592  1.29976  1.00607
    ##    AUD/USD  AUD/JPY  NZD/USD  EUR/JPY  GBP/JPY  EUR/GBP  EUR/SEK  EUR/CHF
    ## 1   0.7237   82.187   0.6795  128.566  147.646  0.87080 10.27357  1.13862
    ## 2   0.7237   82.187   0.6795  128.566  147.646  0.87080 10.27357  1.13862
    ## 3   0.7237   82.204   0.6795  128.571  147.639  0.87079 10.27390  1.13855
    ## 4   0.7237   82.208   0.6795  128.565  147.639  0.87079 10.27370  1.13856
    ## 5   0.7237   82.201   0.6795  128.568  147.640  0.87079 10.27370  1.13871
    ## 6   0.7237   82.202   0.6795  128.571  147.640  0.87077 10.27400  1.13870
    ##    EUR/HUF  EUR/JPY  USD/CNY  USD/HKD  USD/SGD  USD/INR  USD/MXN  USD/PHP
    ## 1   322.30  128.566   6.9499   7.8307  1.37865   72.304  20.3998    53.08
    ## 2   322.30  128.566   6.9499   7.8307  1.37865   72.304  20.3998    53.08
    ## 3   322.33  128.571   6.9499   7.8307  1.37865   72.304  20.3997    53.08
    ## 4   322.32  128.565   6.9499   7.8308  1.37865   72.304  20.3997    53.08
    ## 5   322.33  128.568   6.9499   7.8308  1.37865   72.304  20.3997    53.08
    ## 6   322.38  128.571   6.9499   7.8308  1.37870   72.304  20.3997    53.08
    ##    USD/IDR  USD/THB  USD/MYR  USD/ZAR                time
    ## 1       14      785   32.917   4.1945 2018-11-14 15:28:54
    ## 2       14      785   32.917   4.1945 2018-11-14 15:28:59
    ## 3       14      785   32.917   4.1945 2018-11-14 15:29:05
    ## 4       14      785   32.917   4.1945 2018-11-14 15:29:10
    ## 5       14      785   32.917   4.1945 2018-11-14 15:29:16
    ## 6       14      785   32.943   4.1945 2018-11-14 15:29:22

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

Real time
---------

![](Yahoo_realtime_files/figure-markdown_github/GBP_USD.png) ![](Yahoo_realtime_files/figure-markdown_github/GBP_JPY.png)
