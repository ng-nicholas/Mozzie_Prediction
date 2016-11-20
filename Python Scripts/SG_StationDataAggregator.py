"""
SG Station Data Aggregator

 This file aggregates data from the weather stations in SG into one sqlite
 database. Can be automated for incremental refresh.
"""

import sqlite3
import urllib.request
import PyPDF2

conn = sqlite3.connect("SG_Weather.sqlite3")
cur = conn.cursor()

cur.execute("""
CREATE TABLE IF NOT EXISTS weather_sg_station_attr (
    id     INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
    stn_name text,
    lat real,
    long real,
    stn_code text,
    remarks text,
    rcrd_created text
);
""")
