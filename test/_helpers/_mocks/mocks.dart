import 'package:cosmicview/src/data/datasources/remote/apod/apod_remote_data_source.dart';
import 'package:cosmicview/src/data/datasources/remote/nasa_image/nasa_image_remote_data_source.dart';
import 'package:cosmicview/src/domain/repositories/apod_repository.dart';
import 'package:cosmicview/src/domain/repositories/nasa_image_repository.dart';
import 'package:cosmicview/src/domain/usecases/apod_usecase.dart';
import 'package:cosmicview/src/domain/usecases/nasa_image_usecase.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  APODRemoteDataSource,
  APODRepository,
  APODUsecase,
  NasaImageRemoteDataSource,
  NasaImageRepository,
  NasaImageUsecase,
], customMocks: [])
void main() {}
