import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mo_wahaj_top/core/firebase/firebase_core/firestore_base_model.dart';
import 'package:mo_wahaj_top/core/firebase/firebase_core/firestore_method.dart';
import 'package:mo_wahaj_top/core/storage/shared_pref/shared_preferences.dart';

import '../../../../../core/firebase/firebase_core/firestore_status_code.dart';
import '../../../../../core/resource/cubit_status.dart';

part 'send_code_state.dart';

class SendCodeCubit extends Cubit<SendCodeState> {
  SendCodeCubit() : super(SendCodeState.initial());

  void sendCode({required Map<String, dynamic> body}) async {
    emit(state.copyWith(status: CubitStatus.loading));

    FireStoreBaseModel model = await FireStoreAddMethod.sendCode(body: body);

    if (isClosed) return;

    if (FireStoreStatusCode.successStatus().contains(model.code)) {
      emit(state.copyWith(status: CubitStatus.success, model: model));
    } else {
      emit(state.copyWith(status: CubitStatus.error,model: model));
    }
  }
}
