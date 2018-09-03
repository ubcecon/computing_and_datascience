## Introduction to Web Scraping 

Web scraping is a technique for retrieving data or information on web servers. It is most commonly achieved by writing an automated program that queries into a webpage, requests required data (usually in the form of HTML), parses those data to extract needed information and then stores the target information. Web scraping is useful since large databases can be gathered and processed quickly. Areas such as financial forecasting and natural langugage parsing have been benefited tremendously from this practice of gathering data from new webpages and translated texts quickly. Some of the languages that support web scraping include Python (Scrapy and beautifulsoup), Java (Jaunt, Jsoup) and node.js(Noodle, [Osmosis](https://blog.webkid.io/nodejs-scraping-libraries/)). We will start with the basic mechanics of web scraping by learning how to use Python libraries to extract information. 

### 1. Web Scraping in Python 

Python is one of the most popular languages used for web scraping. In particular, *BeautifulSoup* and *Scrapy* are two widely used libraries in python for web crawling. 

#### BeautifulSoup

> *Beautiful Soup, so rich and green, \
> Waiting in a hot tureen! \
> Who for such dainties would not stoop? \
> Soup for the evening, beautiful Soup!*

BeautifulSoup is a highly-efficient Python library used for formating and organizing information from poorly-designed websites quickly by fixing bad HTML and automatically converting incoming documents to traversable Python objects. It sits on top of popular Python parsers such as [lxml](https://lxml.de) and [html5lib](https://github.com/html5lib/), allowing users to try out different parsing strategies with flexibility. 

However, BeautifulSoup is not a default Python library and therefore the following steps will be needed for installation. 

#### Download BeautifulSoup

