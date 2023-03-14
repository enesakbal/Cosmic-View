import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApplicationConstants {
  static final apodApiURL = '${dotenv.env['APOD_URL']}';
  static final apodApiKey = '${dotenv.env['APOD_API_KEY']}';
  static final imagesApiURL = '${dotenv.env['IMAGES_API_URL']}';
}
