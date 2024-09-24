part of 'sign_cubit.dart';

class SignState extends Equatable {
  final FireStoreBaseModel model;
  final CubitStatus status;

  const SignState({
    required this.model,
    required this.status,
  });

  factory SignState.initial() {
    return SignState(
        model: FireStoreBaseModel(), status: CubitStatus.initial);
  }

  @override
  bool get stringify => true;

  SignState copyWith(
      {String? error, FireStoreBaseModel? model, CubitStatus? status}) {
    return SignState(
      model: model ?? this.model,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props {
    return [ status, model];
  }
}
