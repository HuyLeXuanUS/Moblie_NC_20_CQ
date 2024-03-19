import 'package:final_project/services/setting/host_api_dev.dart' as dev;
import 'package:final_project/services/setting/host_api_product.dart' as prod;

// ignore: constant_identifier_names
enum Enviroment { DEV, PROD }

class Enviroments {
  // ignore: unused_field, prefer_final_fields
  static Enviroment _currentEnviroment = Enviroment.DEV;

  static void setEnviroment(Enviroment env) {
    _currentEnviroment = env;
  }

  static String get baseUrl {
    switch (_currentEnviroment) {
      case Enviroment.DEV:
        return dev.apiUrl;
      case Enviroment.PROD:
        return prod.apiUrl;
      default:
        return dev.apiUrl;
    }
  }
}
