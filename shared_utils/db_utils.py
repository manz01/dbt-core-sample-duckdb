import mysql.connector
import pandas as pd

def db_query(sql: str, database: str) -> pd.DataFrame:
    config_map = {
        'GOSales': {
            'host': 'relational.fel.cvut.cz',
            'port': 3306,
            'user': 'guest',
            'password': 'ctu-relational',
            'database': 'GOSales',
        },
    }

    if database not in config_map:
        raise ValueError(f"Unsupported database: {database}")

    config = config_map[database]
    print(f"\nRunning SQL query:\n{sql}")
    # Connect and query
    conn = mysql.connector.connect(**config)
    try:
        df = pd.read_sql(sql, conn)
    finally:
        conn.close()
    print(f"\nshape: {df.shape} \n")
    return df
