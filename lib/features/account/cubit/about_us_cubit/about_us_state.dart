part of 'about_us_cubit.dart';

class AboutUsState extends Equatable {
  final FireStoreBaseModel model;
  final CubitStatus status;

  const AboutUsState({
    required this.model,
    required this.status,
  });

  factory AboutUsState.initial() {
    return AboutUsState(
        model: FireStoreBaseModel(), status: CubitStatus.initial);
  }

  @override
  bool get stringify => true;

  AboutUsState copyWith(
      {String? error, FireStoreBaseModel? model, CubitStatus? status}) {
    return AboutUsState(
      model: model ?? this.model,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props {
    return [ status, model];
  }
}
