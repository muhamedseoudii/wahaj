part of 'delete_user_cubit.dart';

class DeleteUserState extends Equatable {
  final FireStoreBaseModel model;
  final CubitStatus status;

  const DeleteUserState({
    required this.model,
    required this.status,
  });

  factory DeleteUserState.initial() {
    return DeleteUserState(
        model: FireStoreBaseModel(), status: CubitStatus.initial);
  }

  @override
  bool get stringify => true;

  DeleteUserState copyWith(
      {String? error, FireStoreBaseModel? model, CubitStatus? status}) {
    return DeleteUserState(
      model: model ?? this.model,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props {
    return [ status, model];
  }
}
