import 'package:flutter/material.dart';

class Category {
  final String name;
  final IconData icon;
  final Color color;

  Category({
    required this.name,
    required this.icon,
    required this.color,
  });
}

class CategoryWidget extends StatelessWidget {
  final List<Category> categories;
  final Function(int) onCategoryTap;

  CategoryWidget({
    required this.categories,
    required this.onCategoryTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: kToolbarHeight + 60), // Adjusted margin
      color: Colors.transparent,
      height: 40.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 3.0),
            child: Container(
              decoration: BoxDecoration(
                color: categories[index].color.withOpacity(0.2),
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: GestureDetector(
                onTap: () {
                  onCategoryTap(index);
                },
                child: Padding(
                  padding: EdgeInsets.all(9.0),
                  child: Row(
                    children: [
                      Icon(categories[index].icon, size: 18),
                      SizedBox(width: 5),
                      Text(
                        categories[index].name,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
