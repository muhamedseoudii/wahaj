part of 'notificaiton_cubit.dart';

class NotificationState extends Equatable {
  final FireStoreBaseModel model;
  final CubitStatus status;

  const NotificationState({
    required this.model,
    required this.status,
  });

  factory NotificationState.initial() {
    return NotificationState(
        model: FireStoreBaseModel(), status: CubitStatus.initial);
  }

  @override
  bool get stringify => true;

  NotificationState copyWith(
      {String? error, FireStoreBaseModel? model, CubitStatus? status}) {
    return NotificationState(
      model: model ?? this.model,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props {
    return [ status, model];
  }
}
