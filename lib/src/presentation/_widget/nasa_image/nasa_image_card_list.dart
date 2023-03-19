import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../domain/entities/nasa_image/item.dart';
import 'nasa_image_card.dart';

class NasaImageCardList extends StatelessWidget {
  const NasaImageCardList({Key? key, required this.itemList}) : super(key: key);

  final List<Item> itemList;

  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        mainAxisSpacing: 20.r,
      ),
      itemCount: itemList.length,
      itemBuilder: (context, index) {
        return NasaImageCard(item: itemList[index]);
        // ...itemList.map((e) {
        //   return NasaImageCard(item: e);
        // }).toList()
        // if (context.read<NasaImageBloc>().more) ...[
        //   Container(
        //     alignment: Alignment.center,
        //     height: 80,
        //     child: const CircularProgressIndicator.adaptive(),
        //   )
        // ]
      },
    );
  }
}
