import 'package:flutter/material.dart';
import 'package:my_foodhub/pages/category_details_screen.dart';
import 'package:my_foodhub/utilities/constants.dart';

import 'app_circle_image.dart';


class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    required this.category,
    required this.image,
    required this.selected,
    required this.onSelected,
  }) : super(key: key);

  final String category;
  final String image;
  final bool selected;
  final ValueChanged onSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: [lightBoxShadow],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Material(
          type: MaterialType.card,
          child: InkWell(
            onTap: () {
              onSelected(!selected);

              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CategoryDetailsScreen()),
              );
            },
            child: Ink(
              width: 119,
              // alignment: Alignment.center,
              color: selected ? AppColors.lightAmberColor : Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppCircleImage(image: image),
                  Text(category),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

var lightBoxShadow = BoxShadow(
  blurRadius: 5,
  spreadRadius: 1,
  color: AppColors.greyColor.withOpacity(0.5),
  offset: const Offset(0, 1),
);
