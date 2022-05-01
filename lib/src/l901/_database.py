from contextlib import contextmanager as _contextmanager
import sqlite3 as _sqlite3


class Connection:
    def __init__(self, filepath):
        self._connection = _sqlite3.connect(filepath, isolation_level=None)

    def cursor(self, *, transaction=False):
        if transaction:
            return self._transaction()
        return self._query()

    @_contextmanager
    def _query(self):
        cursor = self._connection.cursor()
        try:
            yield cursor
        finally:
            cursor.close()

    @_contextmanager
    def _transaction(self):
        cursor = self._connection.cursor()
        try:
            cursor.execute('BEGIN TRANSACTION;')
            yield cursor
            cursor.execute('COMMIT TRANSACTION;')
        except BaseException as e:
            cursor.execute('ROLLBACK TRANSACTION;')
            raise e
        finally:
            cursor.close()

    def close(self):
        self._connection.close()
