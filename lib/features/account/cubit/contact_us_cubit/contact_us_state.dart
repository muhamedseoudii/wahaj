part of 'contact_us_cubit.dart';

class ContactUsState extends Equatable {
  final FireStoreBaseModel model;
  final CubitStatus status;

  const ContactUsState({
    required this.model,
    required this.status,
  });

  factory ContactUsState.initial() {
    return ContactUsState(
        model: FireStoreBaseModel(), status: CubitStatus.initial);
  }

  @override
  bool get stringify => true;

  ContactUsState copyWith(
      {String? error, FireStoreBaseModel? model, CubitStatus? status}) {
    return ContactUsState(
      model: model ?? this.model,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props {
    return [ status, model];
  }
}
