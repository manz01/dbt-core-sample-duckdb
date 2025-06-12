"""
--------------------------------------------------------------------------------
Program:        t_raw_go_methods
Project:        duckdb-core-sample-go-sales
Description:    Raw model for the GO sales data go_methods
Input(s):       msql go_sale.go_methods
Output(s):      raw.t_raw_go_methods
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
