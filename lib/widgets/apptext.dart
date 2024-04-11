import 'package:flutter/material.dart';



class AppText extends StatelessWidget {
 final String? data;
 final double? size;
 final Color? color;
 final FontWeight? fw;
 final TextAlign? align;
  const AppText({super.key, required this.data, this.size=18, this.color, this.fw,this.align=TextAlign.left});

  @override
  Widget build(BuildContext context) {
    return Text(

      data.toString(),
      textAlign: align,
     // overflow: TextOverflow.ellipsis,
      style: TextStyle(fontSize: size, color: color,fontWeight: fw),
    );
  }
}
