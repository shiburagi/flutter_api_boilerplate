import 'package:fluter_api_boilerplate/api/base.dart';

class UserApi extends BaseApi {
  get path => "user/";
  static UserApi _instance = UserApi();
  static UserApi get instance {
    if (_instance == null) _instance = UserApi();
    return _instance;
  }

  Future get() {
    return dio.get("$path");
  }

}
