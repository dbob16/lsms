import dotenv
import pymysql
import os

if os.path.exists(".env"):
    dotenv.load_dotenv(".env")

def db_session():
    conn_props = {
        "host":os.getenv("DB_HOST", "127.0.0.1"),
        "user":os.getenv("DB_USER", "lsms"),
        "password":os.getenv("DB_PASSWORD", "password"),
        "database":os.getenv("DB_DATABASE", "lsms")
    }
    conn = pymysql.connect(**conn_props)
    cur = conn.cursor()
    return conn, cur

def db_create_schema():
    file = open("schema/mariadb-v0.1.sql", "r")
    sql_statements = file.read().split(";")
    file.close()
    conn, cur = db_session()
    for s in sql_statements:
        cur.execute(s)
    conn.commit()
    conn.close()