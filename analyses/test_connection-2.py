from sqlalchemy import create_engine
import pandas as pd

# Build the connection string using SQLAlchemy
user = 'guest'
password = 'ctu-relational'
host = 'relational.fel.cvut.cz'
port = 3306
database = 'GOSales'  # Replace with actual database name

# Using the mariadb connector
engine = create_engine(f"mariadb+mariadbconnector://{user}:{password}@{host}:{port}/{database}")

# Query the database into a DataFrame
sql_query = "SELECT * FROM your_table_name LIMIT 10"  # Replace with actual table name
df = pd.read_sql(sql_query, engine)

print(df)