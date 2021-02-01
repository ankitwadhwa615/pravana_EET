import 'package:flutter/material.dart';
import 'package:pravana_eet/components/constants.dart';
class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            kGradientColorStart,
            kGradientColorEnd
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          child: Center(
            child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white),),
          ),
        ),
      ),
    );
  }
}
