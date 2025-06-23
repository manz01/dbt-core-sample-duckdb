"""Unit tests for db_query function."""

import unittest.mock as mock
import pandas as pd
from shared_utils.db_query import db_query  # Update path accordingly


@mock.patch("shared_utils.db_query.get_db_config")
@mock.patch("shared_utils.db_query.mysql.connector.connect")
@mock.patch("shared_utils.db_query.pd.read_sql")
def test_db_query_success(mock_read_sql, mock_connect, mock_get_config):
    """Test db_query runs SQL and returns DataFrame correctly."""
    fake_config = {
        "host": "dummy-host",
        "port": 1234,
        "user": "dummy",
        "password": "dummy",
        "database": "dummy_db"
    }

    mock_conn = mock.Mock()
    mock_get_config.return_value = fake_config
    mock_connect.return_value = mock_conn

    expected_df = pd.DataFrame({"id": [1], "name": ["Test"]})
    mock_read_sql.return_value = expected_df

    sql = "SELECT * FROM dummy_table"
    result = db_query(sql, "GOSales")

    mock_get_config.assert_called_once_with("GOSales")
    mock_connect.assert_called_once_with(**fake_config)
    mock_read_sql.assert_called_once_with(sql, mock_conn)
    mock_conn.close.assert_called_once()
    pd.testing.assert_frame_equal(result, expected_df)
