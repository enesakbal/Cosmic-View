import 'package:cosmicview/src/data/models/apod_model.dart';
import 'package:cosmicview/src/domain/entities/apod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late APODModel tModel;
  late APOD tEntity;
  setUp(() {
    tModel = const APODModel(
      copyright: 'Adam Block',
      date: '2013-12-26',
      explanation:
          "Gorgeous spiral galaxy M33 seems to have more than its fair share of glowing hydrogen gas. A prominent member of the local group of galaxies, M33 is also known as the Triangulum Galaxy and lies about 3 million light-years distant.  Its inner 30,000 light-years are shown in this telescopic galaxy portrait that enhances the reddish ionized hydrogen clouds or HII regions. Sprawling along loose spiral arms that wind toward the core, M33's giant HII regions are some of the largest known stellar nurseries, sites of the formation of short-lived but very massive stars. Intense ultraviolet radiation from the luminous, massive stars ionizes the surrounding hydrogen gas and ultimately produces the characteristic red glow. To enhance this image, broadband data was used to produce a color view of the galaxy and combined with narrowband data recorded through a hydrogen-alpha filter, transmitting the light of the strongest hydrogen emission line. To see the monochromatic narrowband data alone, move your cursor over the image, or take this video tour of the hydrogen clouds of M33.",
      hdurl: 'https://apod.nasa.gov/apod/image/1312/M33block_Ha_enhanced.jpg',
      mediaType: 'image',
      serviceVersion: 'v1',
      title: 'The Hydrogen Clouds of M33',
      url: 'https://apod.nasa.gov/apod/image/1312/M33block_Ha_enhanced900.jpg',
    );

    tEntity = const APOD(
      copyright: 'Adam Block',
      date: '2013-12-26',
      explanation:
          "Gorgeous spiral galaxy M33 seems to have more than its fair share of glowing hydrogen gas. A prominent member of the local group of galaxies, M33 is also known as the Triangulum Galaxy and lies about 3 million light-years distant.  Its inner 30,000 light-years are shown in this telescopic galaxy portrait that enhances the reddish ionized hydrogen clouds or HII regions. Sprawling along loose spiral arms that wind toward the core, M33's giant HII regions are some of the largest known stellar nurseries, sites of the formation of short-lived but very massive stars. Intense ultraviolet radiation from the luminous, massive stars ionizes the surrounding hydrogen gas and ultimately produces the characteristic red glow. To enhance this image, broadband data was used to produce a color view of the galaxy and combined with narrowband data recorded through a hydrogen-alpha filter, transmitting the light of the strongest hydrogen emission line. To see the monochromatic narrowband data alone, move your cursor over the image, or take this video tour of the hydrogen clouds of M33.",
      hdurl: 'https://apod.nasa.gov/apod/image/1312/M33block_Ha_enhanced.jpg',
      mediaType: 'image',
      serviceVersion: 'v1',
      title: 'The Hydrogen Clouds of M33',
      url: 'https://apod.nasa.gov/apod/image/1312/M33block_Ha_enhanced900.jpg',
    );
  });

  test('APOD model to entity', () {
    final entity = tModel.toEntity();

    expect(entity, isA<APOD>());
    expect(entity, equals(tEntity));
  });
}
