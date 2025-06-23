"""Unit tests for shared_utils.config.get_db_config."""

import json
import unittest.mock as mock
import pytest
from shared_utils.config import get_db_config, CREDENTIALS_PATH


# Synthetic dummy config
mock_config_data = {
    "GOSales": {
        "host": "dummy-host.local",
        "port": 1234,
        "user": "test_user",
        "password": "test_password",
        "database": "dummy_db"
    }
}


@mock.patch("builtins.open", new_callable=mock.mock_open, read_data=json.dumps(mock_config_data))
def test_get_db_config_valid(mock_open):
    """Test get_db_config returns config for valid DB key."""
    result = get_db_config("GOSales")
    assert result == mock_config_data["GOSales"]
    mock_open.assert_called_once_with(CREDENTIALS_PATH, "r", encoding="utf-8")


@mock.patch("builtins.open", new_callable=mock.mock_open, read_data=json.dumps(mock_config_data))
def test_get_db_config_invalid(mock_open):
    """Test get_db_config raises ValueError for unsupported DB key."""
    with pytest.raises(ValueError, match="Unsupported database: InvalidDB"):
        get_db_config("InvalidDB")
