import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'constants.dart';


class CustomLoader extends StatefulWidget {
  final String title;
  CustomLoader({
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  _CustomLoader createState() => _CustomLoader();
}

class _CustomLoader extends State<CustomLoader> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.2),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: Container(
            height: 180.0,
            width: 250.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                    backgroundColor: AppColors.colorEFAF31,
                    color: AppColors.colorE07809),
                SizedBox(
                  height: 25,
                ),
                Container(
                  child: Text(
                    "${widget.title}",
                    style: TextStyle(
                        fontSize: 16,
                        color: AppColors.color001122,
                        fontFamily: AppFonts.nunitoSans,
                        fontWeight: FontWeight.w400),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
