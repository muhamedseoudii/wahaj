part of 'submit_message_cubit.dart';

class SubmitMessageState extends Equatable {
  final FireStoreBaseModel model;
  final CubitStatus status;

  const SubmitMessageState({
    required this.model,
    required this.status,
  });

  factory SubmitMessageState.initial() {
    return SubmitMessageState(
        model: FireStoreBaseModel(), status: CubitStatus.initial);
  }

  @override
  bool get stringify => true;

  SubmitMessageState copyWith(
      {String? error, FireStoreBaseModel? model, CubitStatus? status}) {
    return SubmitMessageState(
      model: model ?? this.model,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props {
    return [ status, model];
  }
}
