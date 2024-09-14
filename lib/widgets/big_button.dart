import 'package:e_commerce/constants/themes.dart';
import 'package:flutter/material.dart';

class BigButton extends StatelessWidget {
  BigButton({super.key, this.title = 'Order', required this.onPressed});

  final String title;
  void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return ElevatedButton(
      style: const ButtonStyle(
          backgroundColor: WidgetStatePropertyAll<Color>(kPrimaryColor)),
      onPressed: onPressed,
      child: Center(
        child: Text(
          title,
          style: AppTheme.kBigTitle,
        ),
      ),
    );
  }
}
