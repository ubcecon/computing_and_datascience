## Introduction to Web Scraping 

Web scraping is a technique for retrieving data or information on web servers. It is most commonly achieved by writing an automated program that queries into a webpage, requests required data (usually in the form of HTML), parses those data to extract needed information and then stores the target information. Web scraping is useful since large databases can be gathered and processed quickly. Areas such as financial forecasting and natural langugage parsing have been benefited tremendously from this practice of gathering data from new webpages and translated texts quickly. Some of the languages that support web scraping include Python (Scrapy and beautifulsoup), Java (Jaunt, Jsoup) and node.js (Noodle, Osmosis). Check out [here] (https://blog.webkid.io/nodejs-scraping-libraries/)) for more information about Osmosis. We will start with the basic mechanics of web scraping by learning how to use Python libraries to extract information. 

## Web Scraping in Python 

Python is one of the most popular languages used for web scraping. In particular, *BeautifulSoup* and *Scrapy* are two widely used libraries in python for web crawling. 

 ### 1. BeautifulSoup

> *Beautiful Soup, so rich and green, \
> Waiting in a hot tureen! \
> Who for such dainties would not stoop? \
> Soup for the evening, beautiful Soup!*

BeautifulSoup is a highly-efficient Python library used for formating and organizing information from poorly-designed websites quickly by fixing bad HTML and automatically converting incoming documents to traversable Python objects. It sits on top of popular Python parsers such as [lxml](https://lxml.de) and [html5lib](https://github.com/html5lib/), allowing users to try out different parsing strategies with flexibility. 

However, BeautifulSoup is not a default Python library and therefore the following steps will be needed for installation. 

### Before downloading BeautifulSoup
We will be using the **BeautifulSoup 4** library (aka BS4). The current release is [Beautiful Soup 4.6.3](https://www.crummy.com/software/BeautifulSoup/bs4/download/) (August 12, 2018). Before installing BeautifulSoup 4, please make sure you have the followings installed first: 
* [*For absolute beginners*] Download [Python](https://www.python.org)
  
  Check out this [tutorial](https://github.com/econtoolkit/tutorials/edit/master/python.md). 
* [*Optional*] Set up virutal environments. 

  An virtural environment is a tool which helps keep the associated libraries required by multiple Python projects in separate places so that users can easily manage installed libraries without worring about potential conflicts between them. **[Virtualenv](https://virtualenv.pypa.io/en/stable/)** helps creates isolated python environments. Creating a virual environemnt is simple: 
  
  ```
   $ virtualenv scrapingEnv
  ```
  which sets up the environment called *ScrapingEnv* and you must activate it to use: 
  
  ```
   $ cd scrapingEnv/
   $ source bin/activate
  ```
  After activiation, the name of this environment will appear in commond-line prompt and any libaries and scripts you run will be placed under thsi virtual environment only. To leave the environment, simply use 
  
  ```
  $ deactivate 
  ```
  Please check out its [user guide](https://virtualenv.pypa.io/en/stable/userguide/) for more information on how to use a virtual environment.
 * [*Optional*] Install text editors. [Atom](https://github.com/econtoolkit/tutorials/blob/master/atom.md) and [VS Code](https://github.com/econtoolkit/tutorials/blob/master/vscode.md) are popular. 
 
 ### Installing BeautifulSoup 
   Check out [here](https://www.crummy.com/software/BeautifulSoup/bs4/doc/) for complete instructions for installing BeautifulSoup 4. You may also follow the steps below for basic setup: 
   - For *Linux* users: 
   ```
  $ sudo apt-get install python-bs4
  ```
  - For *Mac* users, first install the Python package manager *pip*:
  ```
  $ sudo easy_install pip
  ```
   Now, run this comamnd to install the library: 
    
   ```
   $ pip install beautifulsoup4
   ```
  - For *Windows* users, first download BeautifulSoup 4 from [here](https://www.crummy.com/software/BeautifulSoup/#Download). Then, check the directory you unzipped the downloaded files to and run: 
  
  ```
   > python setup.py install
   ```
   
   ## Example: 
   
   Now, let's create a file named `myScript.py` in any Python text editors you prefer. Consider
  
  
 

  

  

