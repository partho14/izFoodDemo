import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import '../pages/ProductDetailsScreen.dart';
import '../utilities/data.dart';
import 'offer_card.dart';

class OffersSection extends StatelessWidget {
  const OffersSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // padding: const EdgeInsets.only(left: 26),
      height: 158.h,
      child: ListView.separated(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        clipBehavior: Clip.none,
        scrollDirection: Axis.horizontal,
        itemCount: 2,
        separatorBuilder: (context, index) => SizedBox(width: 28.w),
        itemBuilder: (context, index) {
          final offer = offerData[index];
          return OfferCard(
            image: offer.image,
            percentOff: offer.percentOff,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProductDetailsScreen()),
              );
            },
            offer: offer.offer,
          );
        },
      ),
    );
  }
}
