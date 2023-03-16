import 'dart:io';

import 'package:cosmicview/src/data/models/nasa_image_model/nasa_image_model.dart';
import 'package:cosmicview/src/domain/entities/nasa_image/nasa_image.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../_helpers/json_reader.dart';

void main() {
  late NasaImageModel tModel;
  late NasaImage tEntity;

  setUp(() {
    dotenv.testLoad(fileInput: File('.env').readAsStringSync());

    tModel = NasaImageModel.fromJson(
        readJson('nasa_image_dummy_data.json') as Map<String, dynamic>);

    tEntity = tModel.toEntity();
  });

  test('Should convert Nasa Image model to entity', () {
    final entity = tModel.toEntity();

    expect(entity, isA<NasaImage>());
    expect(entity, equals(tEntity));
  });
}
