/* 
@author    : karthick.d 05/06/2025
@desc      : LoanproductBloc - encapsulates business logic of loanproducts page
@param     : 
 */
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsee/core/db/db_config.dart';
import 'package:newsee/feature/masters/domain/modal/product.dart';
import 'package:newsee/feature/masters/domain/modal/productschema.dart';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:newsee/feature/masters/domain/repository/product_schema_crud_repo.dart';
import 'package:newsee/feature/masters/domain/repository/products_crud_repo.dart';
import 'package:newsee/feature/masters/domain/repository/products_master_crud_repo.dart';
import 'package:sqflite/sqlite_api.dart';

part './loanproduct_event.dart';
part 'loanproduct_state.dart';

class LoanproductBloc extends Bloc<LoanproductEvent, LoanproductState> {
  LoanproductBloc() : super(LoanproductState.init()) {
    on<LoanproductInit>(onLoanProductInit);
    on<LoanProductDropdownChange>(onLoanProductDropdownChange);
  }

  Future<void> onLoanProductInit(LoanproductInit event, Emitter emit) async {
    // initiate the dataset for typeofloan
    String leadId = event.loanproductState.leadId ?? '';
    Database db = await DBConfig().database;
    if (leadId.isEmpty) {
      List<ProductSchema> productSchemaList =
          await ProductSchemaCrudRepo(db).getAll();
      print('productSchemaList from DB => ${productSchemaList.length}');
      emit(state.copyWith(productSchemeList: productSchemaList));
    }
  }

  Future<void> onLoanProductDropdownChange(
    LoanProductDropdownChange event,
    Emitter emit,
  ) async {
    Database db = await DBConfig().database;
    List<Product> products = await ProductsCrudRepo(db).getAll();
    print('get all product master values => ${products.length}');
  }
}
