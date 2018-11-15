SEC firm locations
==================

This is an example of scraping location information of firms. The firms uses rvest, for scraping data of a HTML page given the node number.

The doccumentation of R vest file: [Rvest Documentation](https://cran.r-project.org/web/packages/rvest/rvest.pdf)

The ggmap is used for extracting the longitude and latitude information given a string containing the address.

The documentation of ggmap: [ggmap Documentation](https://cran.r-project.org/web/packages/ggmap/ggmap.pdf)

Other than that, the natural language processing is done using tm and stringr.

``` r
for (pkg in c("rvest","httr","dplyr","stringr","XML","RCurl","ggplot2","reshape","tm","ggmap")){
 if (!pkg %in% rownames(installed.packages())){install.packages(pkg)}
}
library(rvest)
```

    ## Loading required package: xml2

``` r
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
library(ggmap)
```

    ## Loading required package: ggplot2

``` r
library(XML)
```

    ## 
    ## Attaching package: 'XML'

    ## The following object is masked from 'package:rvest':
    ## 
    ##     xml

``` r
library(httr)
library(tm)
```

    ## Loading required package: NLP

    ## 
    ## Attaching package: 'NLP'

    ## The following object is masked from 'package:httr':
    ## 
    ##     content

    ## The following object is masked from 'package:ggplot2':
    ## 
    ##     annotate

Getting firm addresses from SEC website
---------------------------------------

We analyze the following industries:

``` r
SIC.CODES <- c(6798, 7371)
SIC.NAMES <- c("SIC 6798: Real Estate Investment Trusts","SIC 7371: Computer Programming Services")
```

Define a function that searches all firms in a given industry from the SEC website:

``` r
MAX.PAGE <- 1 # maximum number of pages to be read (each page contains 100 firms)

ConstructFirmDF <- function(sic) {
  i <- 0
  continue_indic = TRUE
  firm.df <- data.frame(firm_code=character(),compnay=character(),state=character())
  
  while (continue_indic){
    search_url <- paste('https://www.sec.gov/cgi-bin/browse-edgar?',
                      'action=getcompany&SIC=',sic,
                      '&owner=exclude&match=&start=',i*100,'&count=100&hidefilings=0',
                      sep="")
  
    search_info <- GET(search_url)
    parsed_search <- htmlParse(search_info)
    info <- try( data.frame(readHTMLTable(parsed_search)),TRUE)
    
    i <- i+1
    if (typeof(info) != "list"|| (i > MAX.PAGE) ) {
      break
    }
    names(info) <- c("firm_code","company","state")
    firm.df <- rbind(firm.df,info)
  }
  
  return (firm.df)
}

firm.df.1 <- ConstructFirmDF(SIC.CODES[1])
```

    ## No encoding supplied: defaulting to UTF-8.
    ## No encoding supplied: defaulting to UTF-8.

``` r
firm.df.2 <- ConstructFirmDF(SIC.CODES[2])
```

    ## No encoding supplied: defaulting to UTF-8.
    ## No encoding supplied: defaulting to UTF-8.

``` r
print(head(firm.df.1))
```

    ##    firm_code                                                      company
    ## 1 0001700461                                       1st stREIT Office Inc.
    ## 2 0001279088                                                   A REIT INC
    ## 3 0001282552                                        AAMES INVESTMENT CORP
    ## 4 0000899629                                          ACADIA REALTY TRUST
    ## 5 0001038522     ACCREDITED MORT LN TR MORT LN ASSET BK CERTS SERS 19961-
    ## 6 0001137108 ACCREDITED MORT LOAN TR 2000-1 ASSET BACKED NOT SE 2000-1 TR
    ##   state
    ## 1    CA
    ## 2    CA
    ## 3    CA
    ## 4    NY
    ## 5    CA
    ## 6    MD

``` r
print(head(firm.df.2))
```

    ##    firm_code                    company state
    ## 1 0001627611             12 Retech Corp    NV
    ## 2 0001023185   ACCELER8 TECHNOLOGY CORP    CO
    ## 3 0001089799 ACCUIMAGE DIAGNOSTICS CORP    CA
    ## 4 0001085621                 Actua Corp    PA
    ## 5 0001607551              ADEPTPROS INC    AZ
    ## 6 0001002225   ADVENT SOFTWARE INC /DE/    CA

For each individual firm, find the location in the firm's home page.

``` r
GetLocation <- function(firm_code){
  url <- paste('https://www.sec.gov/cgi-bin/browse-edgar?action=getcompany&CIK=',
               firm_code,'&owner=include&count=40&hidefilings=0',sep = "")
  firm_page <- read_html(url)
  addr_str <- firm_page %>% html_nodes(".mailer") %>% html_text() 
  mail_addr <- addr_str[1] %>% strsplit("\n") 
  mail_addr <- mail_addr[[1]][-1] %>% str_trim() %>% str_c(collapse = "\n")
  
  # The first element is buisness address, the second is the mailing address
  return(mail_addr)
}

firm.df.1$address <- sapply(firm.df.1$firm_code, GetLocation)
firm.df.2$address <- sapply(firm.df.2$firm_code, GetLocation)

print(head(firm.df.1))
```

    ##    firm_code                                                      company
    ## 1 0001700461                                       1st stREIT Office Inc.
    ## 2 0001279088                                                   A REIT INC
    ## 3 0001282552                                        AAMES INVESTMENT CORP
    ## 4 0000899629                                          ACADIA REALTY TRUST
    ## 5 0001038522     ACCREDITED MORT LN TR MORT LN ASSET BK CERTS SERS 19961-
    ## 6 0001137108 ACCREDITED MORT LOAN TR 2000-1 ASSET BACKED NOT SE 2000-1 TR
    ##   state                                                        address
    ## 1    CA 11601 WILSHIRE BOULEVARD\nSUITE 1690\n\nLOS ANGELES CA 90025\n
    ## 2    CA        1551 N TUSTIN AVENUE\nSUITE 200\n\nSANTA ANA CA 92705\n
    ## 3    CA      350 SOUTH GRAND AVENUE\n43RD FL\n\nLOS ANGELES CA 90071\n
    ## 4    NY         411 THEODORE FREMD AVENUE\nSUITE 300\n\nRYE NY 10580\n
    ## 5    CA                                3 PARK PLZ\n\nIRVINE CA 92614\n
    ## 6    MD               11000 BROKEN LAND PARKWAY\n\nCOLUMBIA MD 21044\n

``` r
print(head(firm.df.2))
```

    ##    firm_code                    company state
    ## 1 0001627611             12 Retech Corp    NV
    ## 2 0001023185   ACCELER8 TECHNOLOGY CORP    CO
    ## 3 0001089799 ACCUIMAGE DIAGNOSTICS CORP    CA
    ## 4 0001085621                 Actua Corp    PA
    ## 5 0001607551              ADEPTPROS INC    AZ
    ## 6 0001002225   ADVENT SOFTWARE INC /DE/    CA
    ##                                                          address
    ## 1        10785 W. TWAIN AVE.,\nSUITE 210\n\nLAS VEGAS NV 89135\n
    ## 2                   303 E. 17TH AVENUE #108\n\nDENVER CO 80203\n
    ## 3 501 GRANDVIEW DRIVE\nSTE 100\n\nSOUTH SAN FRANCISCO CA 94080\n
    ## 4        555 E. LANCASTER AVENUE\nSUITE 640\n\nRADNOR PA 19087\n
    ## 5             14301 N. 87TH ST\nSTE 317\n\nSCOTTSDALE AZ 85260\n
    ## 6                    600 TOWNSEND ST\n\nSAN FRANCISCO CA 94103\n

Getting location
----------------

It turns out that company addresses are not sufficient for plotting -- we need geographical locations in terms of latitude and longitude as well. One good news is that `ggmap` can handle this pretty well. Construct the following function that returns the address given an addresss string:

``` r
GetGeocode <- function (address) {
  geocode(address, source = "dsk") # extract geocode using Data Science Toolkit
}
```

For instance, the geocode of company `BOREALIS TECHNOLOGY CORP` from `https://www.sec.gov/cgi-bin/browse-edgar?action=getcompany&CIK=0001014767&owner=include&count=40&hidefilings=0` can be found by passing their business address:

``` r
address <- "4070 SILVER SAGE DR\nSTE 211\nCARSON CITY NV 89701"
GetGeocode(address)
```

    ## Information from URL : http://www.datasciencetoolkit.org/maps/api/geocode/json?address=4070%20SILVER%20SAGE%20DR%0ASTE%20211%0ACARSON%20CITY%20NV%2089701&sensor=false

    ##         lon      lat
    ## 1 -119.7636 39.13062

where `lon` and `lat` indicate its longitude and latitude respectively.

### Multiple locations

Getting multiple locations can be done by using `lapply` function:

``` r
firm.df.1.locations <- lapply(firm.df.1$address, GetGeocode)
```

    ## Warning: geocode failed with status ZERO_RESULTS, location = "520 WEST 103RD STREET #108
    ## 
    ## KANSAS CITY MO 64114
    ## "

``` r
firm.df.2.locations <- lapply(firm.df.2$address, GetGeocode)
```

    ## Warning: geocode failed with status ZERO_RESULTS, location = "303 E. 17TH AVENUE #108
    ## 
    ## DENVER CO 80203
    ## "

    ## Warning: geocode failed with status ZERO_RESULTS, location = "ROOM 1904, 19/F. JUBILEE CENTRE
    ## 18 FENWICK STREET
    ## 
    ## WANCHAI K3 00000
    ## "

    ## Warning: geocode failed with status ZERO_RESULTS, location = "13511 VULCAN WAY
    ## V6V 1K4
    ## 
    ## RICHMOND BC CANADA A1
    ## "

    ## Warning: geocode failed with status ZERO_RESULTS, location = "2150 SCOTIA ONE
    ## 10060 JASPER AVE
    ## 
    ## EDMONTON ALBERTA
    ## "

    ## Warning: geocode failed with status ZERO_RESULTS, location = "1010 SHERBROOKE ST WEST
    ## STE 1610
    ## 
    ## MONTREAL QUEBEC CANA A8 00000
    ## "

    ## Warning: geocode failed with status ZERO_RESULTS, location = "BEIJING PUBLISHING HOUSE
    ## 6 NORTH THIRD RING ROAD
    ## 
    ## BEIJING F4 100120
    ## "

    ## Warning: geocode failed with status ZERO_RESULTS, location = "UNIT 703-8280 WESTMINSTER HIGHWAY
    ## 
    ## RICHMOND, B.C. Z4 V6X 3W3
    ## "

    ## Warning: geocode failed with status ZERO_RESULTS, location = "PKWY PLAZA #101
    ## 110 ROOSEVELT BLVD
    ## 
    ## MARMORA NJ 08223
    ## "

    ## Warning: geocode failed with status ZERO_RESULTS, location = "ROOM A1103, BUILDING A, CHENGJIAN PLAZA
    ## NO. 18 BEITAIPINGZHUANG ROAD, HAIDIAN
    ## 
    ## BEIJING F4 100088
    ## "

    ## Warning: geocode failed with status ZERO_RESULTS, location = "2020 WINSTON PARK DRIVE
    ## SUITE 201
    ## 
    ## OAKVILLE A6 L6H 6X7
    ## "

    ## Warning: geocode failed with status ZERO_RESULTS, location = "JOOP GEESINKWEG 541-542
    ## 
    ## AMSTERDAM P7 1096-AX
    ## "

``` r
print(head(firm.df.1.locations))
```

    ## [[1]]
    ##         lon     lat
    ## 1 -118.4603 34.0498
    ## 
    ## [[2]]
    ##         lon      lat
    ## 1 -117.8342 33.75961
    ## 
    ## [[3]]
    ##         lon      lat
    ## 1 -118.2518 34.05227
    ## 
    ## [[4]]
    ##         lon      lat
    ## 1 -73.69876 40.97578
    ## 
    ## [[5]]
    ##         lon     lat
    ## 1 -117.8387 33.6786
    ## 
    ## [[6]]
    ##         lon      lat
    ## 1 -76.86467 39.21984

Note that some locations might not have been fetched due to errors (some addresses might not exist anymore). `lapply` performs broadcasting a given function (second parameter) to a vector (first parameter) and returns a list, which is why it is called *l*`apply`.

To extract longitudes and latitudes, one can call the followings.

``` r
firm.df.1.lons <- sapply(firm.df.1.locations, "[[", "lon") # extract lon elements from a list of lists
firm.df.1.lats <- sapply(firm.df.1.locations, "[[", "lat") # extract lat elements from a list of lists
firm.df.2.lons <- sapply(firm.df.2.locations, "[[", "lon") # extract lon elements from a list of lists
firm.df.2.lats <- sapply(firm.df.2.locations, "[[", "lat") # extract lat elements from a list of lists
location.df.1 <- data.frame(lon = firm.df.1.lons, lat = firm.df.1.lats)
location.df.2 <- data.frame(lon = firm.df.2.lons, lat = firm.df.2.lats)
```

Plotting locations
------------------

First, construct a combined `data.frame` for plot:

``` r
location.df.1$SIC <- SIC.NAMES[1]
location.df.2$SIC <- SIC.NAMES[2]

location.df <- rbind(location.df.1, location.df.2)
```

Plot:

``` r
USA.MAP <- map_data("state") # load USA map from ggmap
ggplot(location.df, aes(x=lon, y=lat, color=SIC)) + 
  borders("world", colour="gray50", fill="white") +
  # geom_map(data=USA.MAP, map=USA.MAP, # draw borders based on USA.MAP
  #         aes(long, lat, map_id=region),
  #         color="gray30", fill=NA) +
  geom_point(size=4) +
  labs(x = "Longitude", y = "Latitude", title = "Firm locations") +
  theme_bw() +
    theme(legend.position="bottom")
```

    ## Warning: Removed 23 rows containing missing values (geom_point).

![](sec-location_files/figure-markdown_github/plot-locations-1.png)
