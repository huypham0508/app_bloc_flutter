import 'package:app_bloc_flutter/app/constants/graph_ql_string.dart';
import 'package:app_bloc_flutter/app/data/local_data_source.dart';
import 'package:app_bloc_flutter/app/data/provider/graph_QL.dart';
import 'package:app_bloc_flutter/app/models/auth_dto.dart';
import 'package:bloc/bloc.dart';

part 'auth_events.dart';
part 'auth_repository.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(authInitialState) {
    on<InitialAuthEvent>(_initial);
    on<StartedLoginAuthEvent>(_login);
  }

  void _initial(InitialAuthEvent event, Emitter<AuthState> emit) async {}

  void _login(StartedLoginAuthEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));
    final result = await authRepository.login(event.loginModel);
    await _backDialog(emit);
    if (result) {
      emit(state.copyWith(status: AuthStatus.loginSuccess));
    } else {
      emit(state.copyWith(status: AuthStatus.loginFailure));
    }
  }

  Future _backDialog(Emitter<AuthState> emit) async {
    await Future.delayed(const Duration(milliseconds: 200));
    emit(state.copyWith(status: AuthStatus.backDialog));
  }
}
