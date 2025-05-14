import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsee/Model/api_core/AsyncResponseHandler.dart';
import 'package:newsee/Model/login_request.dart';
import 'package:newsee/feature/auth/domain/model/user/auth_response_model.dart';
import 'package:newsee/feature/auth/domain/repository/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

final class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthState.init()) {
    on<LoginWithAccount>(onLoginWithAccount);
  }

  Future onLoginWithAccount(LoginWithAccount event, Emitter emit) async {
    emit(state.copyWith(status: AuthStatus.loading));

    AsyncResponseHandler response = await authRepository.loginWithAccount(
      event.loginRequest,
    );
    print('AuthBloc => ${response.right}');
    print('AuthBloc => ${response.isRight()}');

    if (response.isRight()) {
      emit(
        state.copyWith(
          status: AuthStatus.success,
          authResponseModel: response.right,
        ),
      );
    } else {
      emit(
        state.copyWith(
          status: AuthStatus.failure,
          errorMessage: response.left.message,
        ),
      );
    }
  }
}
