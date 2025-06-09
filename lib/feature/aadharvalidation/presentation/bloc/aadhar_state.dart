import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

import 'package:newsee/feature/aadharvalidation/domain/modal/aadharvalidate_response.dart';
import 'package:newsee/feature/aadharvalidation/domain/repository/aadharvalidate_repo.dart';

enum AadharValidateStatus { init, loading, success, failue }

class AadharState extends Equatable {
  final AadharValidateStatus status;
  final String? errorMsg;
  final AadharvalidateResponse? aadharvalidateResponse;

  AadharState({
    this.status = AadharValidateStatus.init,
    this.errorMsg,
    this.aadharvalidateResponse,
  });
  @override
  // TODO: implement props
  List<Object?> get props => [status, errorMsg, aadharvalidateResponse];

  AadharState copyWith({
    AadharValidateStatus? status,
    ValueGetter<String?>? errorMsg,
    ValueGetter<AadharvalidateResponse?>? aadharvalidateResponse,
  }) {
    return AadharState(
      status: status ?? this.status,
      errorMsg: errorMsg != null ? errorMsg() : this.errorMsg,
      aadharvalidateResponse:
          aadharvalidateResponse != null
              ? aadharvalidateResponse()
              : this.aadharvalidateResponse,
    );
  }

  @override
  String toString() =>
      'AadharState(status: $status, errorMsg: $errorMsg, aadharvalidateResponse: $aadharvalidateResponse)';
}
