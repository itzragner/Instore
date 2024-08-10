import 'package:flutter/material.dart';

class BottomNavigation extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;

  BottomNavigation({
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation:
          Listenable.merge([AnimationController(vsync: ScrollableState())]),
      builder: (context, child) {
        return AnimatedContainer(
          duration: Duration(milliseconds: 300),
          transform: Matrix4.translationValues(0.0, 0.0, 0.0),
          child: AnimatedOpacity(
            opacity: 1.0,
            duration: Duration(milliseconds: 300),
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.black, width: 1.0),
                ),
              ),
              child: BottomAppBar(
                child: Container(
                  height: 50.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        icon: selectedIndex == 0
                            ? Icon(Icons.home)
                            : Icon(Icons.home_outlined),
                        onPressed: () => onItemTapped(0),
                      ),
                      IconButton(
                        icon: selectedIndex == 1
                            ? Icon(Icons.shopping_bag)
                            : Icon(Icons.shopping_bag_outlined),
                        onPressed: () => onItemTapped(1),
                      ),
                      IconButton(
                        icon: selectedIndex == 2
                            ? Icon(Icons.message)
                            : Icon(Icons.message_outlined),
                        onPressed: () => onItemTapped(2),
                      ),
                      IconButton(
                        icon: selectedIndex == 3
                            ? Icon(Icons.account_circle)
                            : Icon(Icons.account_circle_outlined),
                        onPressed: () => onItemTapped(3),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}