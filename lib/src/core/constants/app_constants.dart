
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApplicationConstants {
  static final baseURL = '${dotenv.env['BASE_URL']}';
  static final apiKEY = '${dotenv.env['API_KEY']}';
}
