import scrapy
from scrapy.crawler import CrawlerProcess
from datetime import datetime
import pathlib
import re
import datetime

date = datetime.datetime.now().strftime('%Y_%m')
year = datetime.datetime.now().strftime('%Y')
month = datetime.datetime.now().strftime('%m')
# dir_name = datetime.datetime.now().strftime('%Y_%m_%d_%H')
path = pathlib.Path(f'webscraping_data')
path.mkdir(parents=True, exist_ok=True)


class LubimyCzytacSpider(scrapy.Spider):
    name = 'books_top100'
    csv_file = f'{path}/{name}_{date}.csv'

    custom_settings = {
        'FEEDS': {csv_file: {'format': 'csv'}
                  }
    }

    def start_requests(self):
        url = 'https://lubimyczytac.pl/top100'
        yield scrapy.Request(url, callback=self.parse)

    def parse(self, response):
        all_books = response.css('div.authorAllBooks__single')
        all_links = all_books.css('a.authorAllBooks__singleTextTitle.float-left::attr(href)').extract()
        for link in all_links:
            book_link = response.urljoin(link)
            yield response.follow(book_link, callback=self.parse_elements)
        next_page = response.css('a.page-link.ml-0.stdPaginator.btn::attr(href)').extract_first()[-1]
        if next_page.isdigit():
            next_page = 'https://lubimyczytac.pl/top100?page={}&listId=listTop100&month={}&year={}&paginatorType=Standard'.format(next_page, month, year)
            print(next_page)
            yield response.follow(next_page, callback=self.parse)

    def parse_elements(self, response):
        categories = response.css('dl>dt::text').extract()
        values = response.css('dl>dd::text').extract()
        # categories = list(filter(None, map(lambda x: x.replace('\n', ''), categories)))
        values = list(filter(None, map(lambda x: x.replace('\n', '')[:-1], values)))
        print(values)
        try:
            last_element = values.pop()
            if last_element.isdigit():
                isbn = int(last_element)
            else:
                if values[-1] > 3000:
                    isbn = int(values.pop())
        except (NameError, SyntaxError, ValueError):
            isbn = None

        print(values)
        values_numerical = list(re.findall('[0-9]+', i) for i in values)
        print(values_numerical)
        publish_dates = []
        no_pages = None
        for i in values_numerical:
            if len(i) > 0:
                if len(i[0]) == 4:
                    publish_dates.append(datetime.date(int(i[0]), int(i[1]), int(i[2])))
                elif int(i[0]) > 15:
                    no_pages = i[0]
        try:
            series = response.css('span.d-none.d-sm-block.mt-1>a::text').extract_first().replace('\n', '').split('(')[0]
        except AttributeError:
            series = None

        item = {
            'ISBN': isbn,
            'title': response.css('div.title-container.relative>h1.book__title::text').extract()[0].replace('\n', ''),
            'publish_date': min(publish_dates).strftime("%d/%m/%Y"),
            'no_pages': no_pages,
            'series': series,
            'author': response.css('span.author.pb-2>a::text').extract_first(),
            'publisher': response.css('span.book__txt.d-block.d-xs-none.mt-2>a::text').extract(),
            'description': response.css('div.collapse-content>p::text').extract()[0].replace('\n', '')
        }

        yield item


process = CrawlerProcess()
process.crawl(LubimyCzytacSpider)
process.start()
