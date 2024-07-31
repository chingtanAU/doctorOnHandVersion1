


import 'package:get/get.dart';

class SignUpContoller extends GetxController {

  var clinic= "".obs ;
  var accountType= "".obs;

  void setAccountType(value) {
    print(value);
    accountType.value=value;
  }
    void setClinic(value) {
    print(value);
    clinic.value=value;
  }


}