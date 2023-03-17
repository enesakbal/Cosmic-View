import '../../enums/dio_client_enum.dart';
import '../dio_client.dart';

class APODClient extends BaseClient {
  APODClient(super.dio, {super.clientType = ClientEnum.APOD_CLIENT})
      : assert(clientType == ClientEnum.APOD_CLIENT, 'MUST BE APOD CLIENT');
}

class NasaImageClient extends BaseClient {
  NasaImageClient(super.dio, {super.clientType = ClientEnum.NASA_IMAGE_CLIENT})
      : assert(clientType == ClientEnum.NASA_IMAGE_CLIENT,
            'MUST BE NASA IMAGE CLIENT');
}
