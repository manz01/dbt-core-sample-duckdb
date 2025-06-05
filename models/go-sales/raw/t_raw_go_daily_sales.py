"""
Author:       Manzar Ahmed
Create Date:  2025-05-18
Project:      GOSales
Description:  raw table for go_daily_sales
----------------------------------------------------------------------------
Version Control
----------------------------------------------------------------------------
#    Date      Name          Description
1.0  20250518  Manzar Ahmed  Initial
----------------------------------------------------------------------------
"""
from shared_utils.db_utils import db_query

def model(dbt, session):
    sql = dbt.config.get('sql')
    df = db_query(sql, 'GOSales')
    return df
