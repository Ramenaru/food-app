import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Restaurant_appbar extends StatelessWidget {
  const Restaurant_appbar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(  
    expandedHeight: 200,
    backgroundColor: Colors.white,
    elevation: 0,
    pinned: true,
    flexibleSpace: FlexibleSpaceBar(
    background: Image.asset
    ("assets/images/Header-image.png", 
    fit: BoxFit.cover,
      ),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: SvgPicture.asset("assets/icons/back.svg"),
          ),
        ),
        actions: [
          CircleAvatar(
            backgroundColor: Colors.white,
            child: SvgPicture.asset("assets/icons/share.svg",
             color: Colors.black,
             ),
          ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CircleAvatar(
              backgroundColor: Colors.white,
              child: SvgPicture.asset("assets/icons/search.svg",
               color: Colors.black,
               ),
          ),
            ),
        ],
    );
  }
}