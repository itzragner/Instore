import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:instore/services/instagrameur.dart';
import 'package:instore/components/details.dart';
import 'package:instore/routes.dart';

import '../services/local_storage.dart';
import 'messages_screen.dart';
import 'product_screen.dart';
import 'profil_screen.dart';

class HomeView2 extends StatefulWidget {
  const HomeView2({super.key});

  @override
  State<HomeView2> createState() => _HomeView2State();
}

class _HomeView2State extends State<HomeView2> with TickerProviderStateMixin {
  InstagrameurController instaController = Get.find<InstagrameurController>();
  int _selectedCategoryIndex = 0;
  List<dynamic> categoriesList = [];
  List<dynamic> brandsList = [];
  List<dynamic> filteredBrandsList = [];

  // User data
  Map<String, dynamic>? userData;

  int _selectedIndex = 0;
  late FocusNode _searchFocusNode;
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool _isMessageSelected = false;
  bool _isAccountSelected = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _animationController.forward();
    _searchFocusNode = FocusNode();
    loadUserData();
    getCategories();
    getBrands();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  Future<void> loadUserData() async {
    final user = await LocalStorageServices().getUser();
    setState(() {
      userData = user;
    });
  }

  Future<void> getCategories() async {
    final res = await instaController.getCategories();
    setState(() {
      categoriesList = res;
    });
  }

  Future<void> getBrands() async {
    final res = await instaController.getBrands();
    setState(() {
      brandsList = res;
      _filterBrandsByCategory();
    });
  }

  void _filterBrandsByCategory() {
    if (_selectedCategoryIndex < categoriesList.length) {
      final selectedCategory = categoriesList[_selectedCategoryIndex];

      if (selectedCategory != null) {
        setState(() {
          filteredBrandsList = brandsList.where((brand) {
            final categories = brand['categories'] as List<dynamic>?;
            return categories?.any((category) => category['id'] == selectedCategory['id']) ?? false;
          }).toList();
        });
      }
    }
  }


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _updateIconStates();
    });
    switch (index) {
      case 0:
        Get.offNamed('/home');
        break;
      case 1:
        Get.offNamed('/product');
        break;
      case 2:
        Get.offNamed('/messages');
        break;
      case 3:
        Get.offNamed('/profile');
        break;
    }
  }

  void _updateIconStates() {
    _isMessageSelected = _selectedIndex == 2;
    _isAccountSelected = _selectedIndex == 3;
  }

  Widget _searchTextFormField() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey.shade200,
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: TextFormField(
          focusNode: _searchFocusNode,
          decoration: const InputDecoration(
            border: InputBorder.none,
            prefixIcon: Icon(
              Icons.search,
              color: Color(0xFFBBBBBB),
            ),
            hintText: 'Rechercher sur Instore',
            hintStyle: TextStyle(color: Color(0xFFBBBBBB)),
            contentPadding:
            EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          ),
        ),
      ),
    );
  }

  Widget _listViewCategory() {
    return SizedBox(
      height: 35,
      child: ListView.separated(
        itemCount: categoriesList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          bool isSelected = index == _selectedCategoryIndex;
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedCategoryIndex = index;
              });
              _filterBrandsByCategory();
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: isSelected
                    ? const Color(0xFFFA058C)
                    : const Color(0xFFffebf7),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Center(
                child: Text(
                  categoriesList.isNotEmpty
                      ? categoriesList[index]['name']
                      : "Loading...",
                  style: TextStyle(
                    color: isSelected
                        ? Colors.white
                        : const Color.fromARGB(255, 222, 210, 210),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(width: 20),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFEF7FF),
        title: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                'assets/instore.png',
                height: 50,
              ),
              GestureDetector(
                onTap: () {
                  Get.offNamed('/profile');
                },
                child: CircleAvatar(
                  radius: 20,
                  backgroundImage: userData?['image'] != null
                      ? NetworkImage(userData!['image'])
                      : const AssetImage('assets/user.png') as ImageProvider,
                ),
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 10, left: 0, right: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  _searchTextFormField(),
                  const SizedBox(height: 10),
                  _listViewCategory(),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            ImageListView(filteredBrandsList: filteredBrandsList),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('Other Content Below the List'),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('Other Content Below the List'),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('Other Content Below the List'),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('Other Content Below the List'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            transform: Matrix4.translationValues(
                0.0, 50.0 * (1.0 - _animation.value), 0.0),
            child: AnimatedOpacity(
              opacity: _animation.value,
              duration: const Duration(milliseconds: 50),
              child: BottomAppBar(
                height: 70,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        icon: _selectedIndex == 0
                            ? const FaIcon(
                          FontAwesomeIcons.house,
                          color: Color(0xFFFA058C),
                        )
                            : const FaIcon(FontAwesomeIcons.house),
                        onPressed: () {
                          _onItemTapped(0);
                        },
                      ),
                      IconButton(
                        icon: _selectedIndex == 1
                            ? const FaIcon(
                          FontAwesomeIcons.bagShopping,
                          color: Color(0xFFFA058C),
                        )
                            : const FaIcon(FontAwesomeIcons.bagShopping),
                        onPressed: () {
                          _onItemTapped(1);
                        },
                      ),
                      IconButton(
                        icon: _selectedIndex == 2
                            ? const FaIcon(
                          FontAwesomeIcons.solidMessage,
                          color: Color(0xFFFA058C),
                        )
                            : const FaIcon(FontAwesomeIcons.solidMessage),
                        onPressed: () {
                          _onItemTapped(2);
                        },
                      ),
                      IconButton(
                        icon: _selectedIndex == 3
                            ? const FaIcon(
                          FontAwesomeIcons.solidCircleUser,
                          color: Color(0xFFFA058C),
                        )
                            : const FaIcon(FontAwesomeIcons.solidCircleUser),
                        onPressed: () {
                          _onItemTapped(3);
                        },
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

class ImageListView extends StatelessWidget {
  final List<dynamic> filteredBrandsList;

  const ImageListView({super.key, required this.filteredBrandsList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: filteredBrandsList.length,
      itemBuilder: (context, index) {
        final brand = filteredBrandsList[index];
        return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailScreen(brand: brand),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 5.0), // Space between images
              child: Image.network(
                brand['image'] ?? 'https://via.placeholder.com/150',
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            )
        );
      },
    );
  }
}


class DetailScreen extends StatelessWidget {
  final dynamic brand;

  const DetailScreen({super.key, required this.brand});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image.network(
              brand['image'] ?? 'https://via.placeholder.com/150',
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  brand['name'] ?? 'Product Name',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8.0),
                Text(
                  brand['price'] ?? 'Product Price',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 8.0),
                Text(
                  brand['description'] ?? 'Product Description',
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
