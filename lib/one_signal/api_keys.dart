import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiKeys {
  static  String appId = dotenv.env['OneSignal_App_ID']!;
  static  String oneSignalApiKey = dotenv.env['Rest_API_Key']!;
}