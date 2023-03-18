import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/apod/apod_bloc.dart';
import 'apod_carousel.dart';

class ApodBlocWidget extends StatelessWidget {
  const ApodBlocWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<APODBloc, APODState>(
      builder: (context, state) {
        if (state is APODHasData) {
          return APODCarousel(apodList: state.dataList);
        } else if (state is APODError) {
          return Center(child: Text(state.message));
        }
        return const APODCarousel(apodList: []);
      },
    );
  }
}
