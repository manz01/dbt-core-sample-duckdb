import pandas as pd
import pytest
from unittest import mock
from your_module import db_query  # Replace with actual module path


@mock.patch("your_module.get_db_config")
@mock.patch("your_module.mysql.connector.connect")
@mock.patch("your_module.pd.read_sql")
def test_db_query_success(mock_read_sql, mock_connect, mock_get_config):
    # --- Setup ---
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

    expected_df = pd.DataFrame({
        "id": [1, 2],
        "name": ["Alice", "Bob"]
    })
    mock_read_sql.return_value = expected_df

    # --- Run ---
    sql = "SELECT * FROM test_table"
    result = db_query(sql, "GOSales")

    # --- Assert ---
    mock_get_config.assert_called_once_with("GOSales")
    mock_connect.assert_called_once_with(**fake_config)
    mock_read_sql.assert_called_once_with(sql, mock_conn)
    mock_conn.close.assert_called_once()

    pd.testing.assert_frame_equal(result, expected_df)
