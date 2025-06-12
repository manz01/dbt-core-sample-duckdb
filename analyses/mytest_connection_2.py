"""Module to test database connection using SQLAlchemy and pandas."""
from sqlalchemy import create_engine
import pandas as pd

USER = 'guest'
PASSWORD = 'ctu-relational'
HOST = 'relational.fel.cvut.cz'
PORT = 3306
DATABASE = 'GOSales'  # Replace with actual database name

engine = create_engine(f"mariadb+mariadbconnector://{USER}:{PASSWORD}@{HOST}:{PORT}/{DATABASE}")


# Query the database into a DataFrame
SQL_QUERY = "SELECT * FROM your_table_name LIMIT 10"  # Replace with actual table name
df = pd.read_sql(SQL_QUERY, engine)

print(df)