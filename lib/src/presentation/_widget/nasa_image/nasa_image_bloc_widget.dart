import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/nasa_image/nasa_image_bloc.dart';
import 'nasa_image_card.dart';
import 'nasa_image_card_list.dart';

class NasaImageBlocWidget extends StatelessWidget {
  const NasaImageBlocWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NasaImageBloc, NasaImageState>(
      builder: (context, state) {
        if (state is NasaImageError) {
          return Center(child: Text(state.message));
        } else if (state is NasaImageHasData) {
          return NasaImageCardList(itemList: state.dataList);
        } else {
          return const CircularProgressIndicator.adaptive(
            backgroundColor: Colors.white,
          );
        }
      },
    );
  }
}
