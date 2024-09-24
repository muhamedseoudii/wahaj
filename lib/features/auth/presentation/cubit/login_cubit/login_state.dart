part of 'login_cubit.dart';

class LoginState extends Equatable {
  final FireStoreBaseModel model;
  final CubitStatus status;

  const LoginState({

    required this.model,
    required this.status,
  });

  factory LoginState.initial() {
    return LoginState(
        model: FireStoreBaseModel(), status: CubitStatus.initial);
  }

  @override
  bool get stringify => true;

  LoginState copyWith(
      {String? error, FireStoreBaseModel? model, CubitStatus? status}) {
    return LoginState(
      model: model ?? this.model,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props {
    return [ status, model];
  }
}
