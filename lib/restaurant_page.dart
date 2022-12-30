import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_app/components/Menu_card.dart';
import 'package:food_app/components/Restaurant_categories.dart';
import 'package:food_app/components/Restaurant_info.dart';
import 'package:food_app/models/menu.dart';

import 'components/Restaurant_appbar.dart';

class RestaurantPage extends StatefulWidget {
  const RestaurantPage({super.key});

  @override
  State<RestaurantPage> createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage> {

  final scrollController = ScrollController();

  int selectedCategory = 0;

  double RestaurantInfoHeight = 200 + 170 - kToolbarHeight;

  @override
  void initState() {
    createBreakPoints();
    scrollController.addListener(() {
      updateCategoryIndexOnScroll(scrollController.offset);
    });
    super.initState();
  }

  void scrollToCategory (int index) {
    if (selectedCategory != index) {
    int totalItems = 0;

    for (var i = 0; i < index; i++) {
      totalItems += demoCategoryMenus[i].items.length;
    }

    scrollController.animateTo(RestaurantInfoHeight + (116 * totalItems) + (50 * index),
    duration: Duration(milliseconds: 500),
    curve: Curves.ease,
    );

    setState(() {
      selectedCategory = index;
    });

    }
  }

  List<double>breakpoints = [];
  void createBreakPoints() {
    double firstBreakPoint = 
    RestaurantInfoHeight + 50 + (116 * demoCategoryMenus[0].items.length);

    breakpoints.add(firstBreakPoint);

    for (var i = 1; i < demoCategoryMenus.length; i++) {
      double breakPoints = breakpoints.last + 50 + (116 * demoCategoryMenus[i].items.length);
      breakpoints.add(breakPoints);
    }
  }

  void updateCategoryIndexOnScroll(double offset) {
    for (var i = 0; i < demoCategoryMenus.length; i++) {
      if (i == 0) {
        if ((offset < breakpoints.first) & (selectedCategory !=0)) {
          setState(() {
            selectedCategory = 0;
          });
        }
      }
    else if ((breakpoints[i - 1] <= offset) & (offset < breakpoints[i])) {
      if (selectedCategory != i) {
        setState(() {
          selectedCategory = i;
        });
      }
    }
    } 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: scrollController,
        slivers: [
          Restaurant_appbar(), 
          SliverToBoxAdapter(
            child: RestaurantInfo(),
          ),
          SliverPersistentHeader(
            delegate: Restaurant_categories(
              onChanged: scrollToCategory,
              selectedIndex: selectedCategory,
            ),
            pinned: true,
            ),
           SliverPadding(
             padding: const EdgeInsets.symmetric(horizontal: 16),
             sliver: SliverList(delegate: SliverChildBuilderDelegate((context, categoryIndex) {
                List<Menu> items = demoCategoryMenus[categoryIndex].items;
                return MenuCategoryItem(title: demoCategoryMenus[categoryIndex].category,
                items: List.generate(items.length, ((index) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: MenuCard(
                    title: items[index].title,
                    image: items[index].image,
                    price: items[index].price,
                    ),
                )
                ),
              )
          );
             },
             childCount: demoCategoryMenus.length,
             )
          ),
           )
        ],
      ),
    );
  }
}

