import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerRunner extends StatelessWidget {

  final String container;
  final bool isIcon;



  const ShimmerRunner({
     required this.isIcon, required this.container
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: isIcon ? 
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(10),
          ), 
        )
        
        : Container(
       width: double.infinity,
        height: 16,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(5),
        ),
                        ),
    );
  }
}
