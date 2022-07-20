from data_generate import genres_data, friends_data, rooms, genres_all, purchase_places, countries_author, cities_publisher
import psycopg2
from psycopg2.extensions import register_adapter, AsIs
import numpy as np
import os
from glob import glob
import pandas as pd
import scipy.stats as ss
from faker import Faker
import datetime
import random
import string
import configparser
fake = Faker()
config = configparser.ConfigParser()
config.read('config.ini')

def get_truncated_normal(mean=0, sd=1, low=0, upp=10):
    return ss.truncnorm.rvs(
        (low - mean) / sd, (upp - mean) / sd, loc=mean, scale=sd)


conn = psycopg2.connect(host=config['mylibrary']['host_name'],
                        dbname=config['mylibrary']['db_name'],
                        user=config['mylibrary']['user_name'],
                        password=config['mylibrary']['password'])
cur = conn.cursor()
psycopg2.extensions.register_adapter(np.int64, psycopg2._psycopg.AsIs)

path = 'webscraping_data'
ext = '*.csv'
all_csv_files = [file for path, subdir, files in os.walk(path)
                 for file in glob(os.path.join(path, ext))]
data_frames = []
begin_date = datetime.date(year=2000, month=1, day=1)

for filename in all_csv_files:
    df = pd.read_csv(filename, header=0)
    data_frames.append(df)

df = pd.concat(data_frames, axis=0)
df.drop_duplicates()


insert_data = [{'isbn': pd.to_numeric(df.iloc[i, 0], errors='coerce'),
                'title':df.iloc[i, 1],
                'publish_date': datetime.datetime.strptime(df.iloc[i, 2], '%d/%m/%Y').date(),
                'no_pages': abs(round(ss.laplace.rvs(loc=350, scale=100))),
                'series':df.iloc[i, 4],
                'author':df.iloc[i, 5],
                'publisher':df.iloc[i, 6],
                'description':df.iloc[i, 7],
                'read_date': fake.date_between(start_date=begin_date, end_date='now'),
                'rating': round(get_truncated_normal(7, 2, 0, 10), 2),
                'genre_name': genres_all[i % 3][random.randint(0, len(genres_all[i % 3])-1)],
                'cover_image': None,
                'country_author': random.choice(['Polska', random.choice(countries_author)]),
                'birthday_author': fake.date_between(start_date=begin_date, end_date='-20y'),
                'city_publisher': random.choice(cities_publisher),
                'foundation_year_publisher': random.randint(1900, 2022),
                'price':abs(float(round(ss.laplace.rvs(loc=29, scale=2), 2))),
                'purchase_place': random.choice(purchase_places),
                'id_purchase_date': fake.date_between(start_date=begin_date, end_date='now'),
                'shelf':random.randint(1, 3),
                'bookcase':random.choice(string.ascii_lowercase[:4]),
                'room': random.choice(rooms)} for i in range(df.shape[0])]

print(insert_data)

cur.executemany("INSERT INTO homelibrary_stg.books_stage (isbn, title, publish_date, no_pages, series, "
                "author, publisher, description, read_date, rating, genre_name, cover_image, country_author,"
                "birthday_author, city_publisher, foundation_year_publisher, price, purchase_place, id_purchase_date,"
                "shelf, bookcase, room) "
                "VALUES (%(isbn)s, %(title)s, %(publish_date)s, %(no_pages)s, %(series)s, %(author)s, "
                "%(publisher)s, %(description)s, %(read_date)s,%(rating)s,%(genre_name)s,%(cover_image)s,"
                "%(country_author)s, %(birthday_author)s, %(city_publisher)s, %(foundation_year_publisher)s,"
                " %(price)s, %(purchase_place)s,%(id_purchase_date)s, %(shelf)s,%(bookcase)s, %(room)s)",
                insert_data)

cur.executemany("INSERT INTO homelibrary.genre (genre_name, type_name) "
                "VALUES (%(genre_name)s, %(type_name)s)",
                genres_data)

cur.executemany("INSERT INTO homelibrary.friends (name_friend, phone, email) "
                "VALUES (%(name_friend)s, %(phone)s, %(email)s)",
                friends_data)

conn.commit()
cur.close()
conn.close()
