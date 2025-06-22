"""
Configuration utility to provide database connection settings.
"""


def get_db_config(database: str) -> dict:
    """
    Returns database connection configuration for the specified database.

    Args:
        database (str): The name of the database.

    Returns:
        dict: A dictionary with connection parameters.

    Raises:
        ValueError: If the specified database is not supported.
    """
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

    return config_map[database]
