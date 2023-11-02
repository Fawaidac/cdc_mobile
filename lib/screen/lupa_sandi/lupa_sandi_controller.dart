import 'package:cdc_mobile/screen/lupa_sandi/lupa_sandi_services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LupaSandiController {
  Future<void> handleRecovery(String email) async {
    final response = await LupaSandiServices.recovery(email);
    if (response['code'] == 200) {
      Fluttertoast.showToast(msg: response['message']);
    } else {
      Fluttertoast.showToast(msg: response['message']);
    }
  }
}
