import mysql.connector
import pandas as pd

# Define connection parameters
config = {
    'host': 'relational.fel.cvut.cz',
    'port': 3306,
    'user': 'guest',
    'password': 'ctu-relational',
    'database': 'GOSales',  # ✅ use this actual database name
}

# Establish connection
conn = mysql.connector.connect(**config)

# Create a cursor
cursor = conn.cursor()

# Example SQL query (change as needed)
sql_query = "SELECT * FROM go_1k LIMIT 10"  # Replace with actual table name

# Use pandas to read into DataFrame
df = pd.read_sql(sql_query, conn)

# Display result
print(df)

# Clean up
cursor.close()
conn.close()
