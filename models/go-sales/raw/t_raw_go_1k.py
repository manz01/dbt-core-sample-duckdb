"""
-------------------------------------------------------------------------------------------------
Program:        t_stg_go_1k
Project:        duckdb-core-sample-go-sales
Description:    Staging model for the GO Sales data go_1k
Input(s):       raw.t_raw_go_1k
Output(s):      det.t_stg_go_1k
Author:         Manzar Ahmed
First Created:  Feb 2025
-------------------------------------------------------------------------------------------------
Program history:
-------------------------------------------------------------------------------------------------
Date        Programmer                Description
----------  ------------------------  -----------------------------------------------------------
2023-02-01  Manzar Ahmed              v0.01/Create
-------------------------------------------------------------------------------------------------
"""

from shared_utils.db_utils import db_query

def model(dbt, session):
    sql = dbt.config.get('sql')
    df = db_query(sql, 'GOSales')
    return df
