import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApplicationConstants {
  static final apodApiURL = '${dotenv.env['APOD_URL']}';
  static final apodApiKey = '${dotenv.env['APOD_API_KEY']}';
  static final nasaImageApiURL = '${dotenv.env['IMAGES_API_URL']}';

  static const halfEarth = 'assets/images/half_earth.jpg';
}
