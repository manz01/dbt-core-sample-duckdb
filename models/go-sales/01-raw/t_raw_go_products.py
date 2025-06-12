"""
--------------------------------------------------------------------------------
Program:        t_raw_go_products
Project:        duckdb-core-sample-go-sales
Description:    Raw model for the GO Sales data go_products
Input(s):       msql go_sale.go_products
Output(s):      raw.t_raw_go_products
Author:         Manzar Ahmed
First Created:  Feb 2025
--------------------------------------------------------------------------------
Program history:
--------------------------------------------------------------------------------
Date        Programmer             Description
----------  ---------------------  ---------------------------------------------
2025-06-11  Manzar Ahmed           v0.01/Initial version
--------------------------------------------------------------------------------
"""

from shared_utils.db_utils import db_query

def model(dbt, session):
    sql = dbt.config.get('sql')
    df = db_query(sql, 'GOSales')
    return df
