/*
@author     : akshayaa.p 28/05/2025
@desc       : class to keep string constants for masterversion table
*/

import 'package:flutter/material.dart';

class TableKeyMasterversion {
  TableKeyMasterversion._();

static const String tableName = 'masterversion';
static const String idColumn = 'id';
static const String mastername ='mastername';
static const String version = 'version';
static const String status = 'status';

static const String createTableQuery = '''
            CREATE TABLE IF NOT EXISTS $tableName(
            $idColumn INTEGER PRIMARY KEY AUTOINCREMENT,
            $mastername TEXT,
            $version TEXT,
            $status TEXT
            )
            ''';
}