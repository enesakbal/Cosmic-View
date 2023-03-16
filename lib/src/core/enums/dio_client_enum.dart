// ignore_for_file: constant_identifier_names

import '../constants/app_constants.dart';

enum ClientEnum { APOD_CLIENT, NASA_IMAGE_CLIENT }

extension ClientExtension on ClientEnum {
  String getBaseURL() {
    switch (this) {
      case ClientEnum.APOD_CLIENT:
        return ApplicationConstants.apodApiURL;
      case ClientEnum.NASA_IMAGE_CLIENT:
        return ApplicationConstants.nasaImageApiURL;
      default:
        return '';
    }
  }

  Map<String, String>? getApiKey() {
    switch (this) {
      case ClientEnum.APOD_CLIENT:
        return {'x-api-key': ApplicationConstants.apodApiKey};
      case ClientEnum.NASA_IMAGE_CLIENT:
        return null;
      default:
        return null;
    }
  }
}
