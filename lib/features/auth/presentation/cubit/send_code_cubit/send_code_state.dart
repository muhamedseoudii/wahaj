part of 'send_code_cubit.dart';

class SendCodeState extends Equatable {
  final FireStoreBaseModel model;
  final CubitStatus status;

  const SendCodeState({
    required this.model,
    required this.status,
  });

  factory SendCodeState.initial() {
    return SendCodeState(
        model: FireStoreBaseModel(),  status: CubitStatus.initial);
  }

  @override
  bool get stringify => true;

  SendCodeState copyWith(
      {String? error, FireStoreBaseModel? model, CubitStatus? status}) {
    return SendCodeState(
      model: model ?? this.model,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props {
    return [ status, model];
  }
}
