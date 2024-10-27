import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../supabase/core.dart';
import '../../otp/otp.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  TextEditingController emailController = TextEditingController();

  late String? userID;

  void login({required String email, required BuildContext context}) async {
    print('login');
    emitLoading();
    if (await isAllowedEmail(email: email)) {
      await OneSignal.login(Random().nextInt(99999).toString());
      userID = await OneSignal.User.getExternalId();
      print('userID: $userID');
      final sendUserID = await supabase
          .from('allowed_emails_test')
          .update({'user_id_t': userID}).eq('email', email);
      final response = await supabase.auth.signInWithOtp(email: email);
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (x) => Otp()));
    }
    emitUpdated();
  }

  Future<bool> isAllowedEmail({required String email}) async {
    print('isAllowedEmail');
    final response = await supabase
        .from('allowed_emails_test')
        .select()
        .eq('email', email)
        .maybeSingle();
    if (response == null) {
      print('null');
      return false;
    }
    return true;
  }

  void emitLoading() => emit(LoadingState());
  void emitUpdated() => emit(UpdatedState());
}
