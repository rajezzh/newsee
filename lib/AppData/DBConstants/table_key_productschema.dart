/* 
@author   : karthick.d  26/05/2025
@desc     : class to keep string contants for products table 


 */
import 'package:flutter/material.dart';

@immutable
class TableKeysProductSchema {
  TableKeysProductSchema._();

  static const String tableName = 'lov';
  static const String idColumn = 'id';
  static const String header = 'Header';
  static const String optValue = 'optvalue';
  static const String optDesc = 'optDesc';
  static const String optCode = 'optCode';
  static const String version = 'version';
}
