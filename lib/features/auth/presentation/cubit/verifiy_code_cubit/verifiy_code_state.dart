part of 'verifiy_code_cubit.dart';

class VerifiyCodeState extends Equatable {
  final FireStoreBaseModel model;
  final CubitStatus status;

  const VerifiyCodeState({
    required this.model,
    required this.status,
  });

  factory VerifiyCodeState.initial() {
    return VerifiyCodeState(
        model: FireStoreBaseModel(),  status: CubitStatus.initial);
  }

  @override
  bool get stringify => true;

  VerifiyCodeState copyWith(
      {String? error, FireStoreBaseModel? model, CubitStatus? status}) {
    return VerifiyCodeState(
      model: model ?? this.model,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props {
    return [ status, model];
  }
}
