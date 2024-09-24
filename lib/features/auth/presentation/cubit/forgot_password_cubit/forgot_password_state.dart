part of 'forgot_password_cubit.dart';

class ForgotPasswordState extends Equatable {
  final FireStoreBaseModel model;
  final CubitStatus status;

  const ForgotPasswordState({
    required this.model,
    required this.status,
  });

  factory ForgotPasswordState.initial() {
    return ForgotPasswordState(
        model: FireStoreBaseModel(), status: CubitStatus.initial);
  }

  @override
  bool get stringify => true;

  ForgotPasswordState copyWith(
      {String? error, FireStoreBaseModel? model, CubitStatus? status}) {
    return ForgotPasswordState(

      model: model ?? this.model,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props {
    return [ status, model];
  }
}
