import 'package:flutter/material.dart';


import '../utilities/constants.dart';
import '../utilities/assets_constant.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        enabledBorder: _inputBorder,
        focusedBorder: _inputBorder.copyWith(
          borderSide: BorderSide(
            color: AppColors.primaryColor.withOpacity(0.4),
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
        ),
        hintText: 'Search -> Grilled chicken -> Pizza',
        suffixIcon: Image.asset(Assets.searchIcon),
      ),
    );
  }
}

var _inputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(30),
  borderSide: BorderSide(
    color: AppColors.primaryColor.withOpacity(0.3),
    width: 0.8,
  ),
);
