import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mo_wahaj_top/core/firebase/firebase_core/firestore_base_model.dart';
import 'package:mo_wahaj_top/core/firebase/firebase_core/firestore_method.dart';

import '../../../../../core/firebase/firebase_core/firestore_status_code.dart';
import '../../../../../core/resource/cubit_status.dart';

part 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit() : super(ForgotPasswordState.initial());

  void forgotPassword({required Map<String, dynamic> body}) async {
    emit(state.copyWith(status: CubitStatus.loading));

    FireStoreBaseModel model = await FireStoreAddMethod.forgotPassword(body: body);

    if (isClosed) return;

    if (FireStoreStatusCode.successStatus().contains(model.code)) {
      emit(state.copyWith(status: CubitStatus.success, model: model));
    } else {
      emit(state.copyWith(status: CubitStatus.error));
    }
  }
}
