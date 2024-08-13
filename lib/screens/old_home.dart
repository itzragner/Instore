
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:instore/components/controllers/instagrameur.dart';
import 'package:instore/components/details.dart';

import 'messages_screen.dart';
import '../components/produit.dart';
import 'profil_screen.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}


class _HomeViewState extends State<HomeView> with TickerProviderStateMixin {
  InstagrameurController instaController = Get.find<InstagrameurController>();
  int _selectedCategoryIndex = 0;
  final List<String> names = <String>[
    'Vetement',
    'Sport',
    'Electronic',
    'Maison',
    'Accesoire',
    'Beauté',
    'Animaux',
  ];

  final List<Map<String, String>> products = [
    {
      'name': 'Pull',
      'price': '90DT',
      'image': 'assets/YELLOW.png',
    },
    {
      'name': 'Chemise',
      'price': '100DT',
      'image': 'assets/chemise2.jpg',
    },
    {
      'name': 'Cargo',
      'price': '150DT',
      'image': 'assets/kargou.jpg',
    },
    {
      'name': 'Trenche',
      'price': '250DT',
      'image': 'assets/trenchesW.jpg',
    },
  ];

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
  }


  @override
  void dispose() {
    _animationController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _updateIconStates();
    });
    // Ajouter votre logique de navigation ici
    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeView()),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const InstagramProduit()),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MessageScreen()),
        );
        break;
      case 3:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ProfilScreen()),
        );
        break;
    }
  }

  void _updateIconStates() {
    _isMessageSelected = _selectedIndex == 2;
    _isAccountSelected = _selectedIndex == 3;
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ProfilScreen()),
                  );
                },
                child: const CircleAvatar(
                  radius: 20, // Ajustez la taille du cercle
                  backgroundImage: AssetImage('assets/user.png'),
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
            ImageListView(),
            const SizedBox(height: 20),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('Other Content Below the List'),
            ),
            const SizedBox(height: 20),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('Other Content Below the List'),
            ),
            const SizedBox(height: 20),
            const SizedBox(height: 20),
            const Padding(
              padding:  EdgeInsets.all(16.0),
              child: Text('Other Content Below the List'),
            ),
            const SizedBox(height: 20),
            const SizedBox(height: 20),
            const Padding(
              padding:  EdgeInsets.all(16.0),
              child: Text('Other Content Below the List'),
            ),


            //Expanded(
            //  child: _gridViewProduct(),
            //),
          ],
        ),
      ),
      bottomNavigationBar: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            transform: Matrix4.translationValues(
                0.0, 50.0 * (1.0 - _animation.value), 0.0), // Move up and down
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
                            ? const FaIcon(FontAwesomeIcons.house, color: Color(0xFFFA058C),)
                            : const FaIcon(FontAwesomeIcons.house,),
                        onPressed: () {
                          _onItemTapped(0);
                        },
                      ),
                      IconButton(
                        icon: _selectedIndex == 1
                            ? const FaIcon(FontAwesomeIcons.bagShopping, color: Color(0xFFFA058C),)
                            : const FaIcon(FontAwesomeIcons.bagShopping,),
                        onPressed: () {
                          _onItemTapped(1);
                        },
                      ),
                      IconButton(
                        icon: _selectedIndex == 2
                            ?const FaIcon(FontAwesomeIcons.solidMessage, color: Color(0xFFFA058C),)
                            : const FaIcon(FontAwesomeIcons.solidMessage),
                        onPressed: () {
                          _onItemTapped(2);
                        },
                      ),
                      IconButton(
                        icon: _selectedIndex == 3
                            ?const FaIcon(FontAwesomeIcons.solidCircleUser, color: Color(0xFFFA058C),)
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
            contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          ),
        ),
      ),
    );
  }


  Widget _listViewCategory() {
    return SizedBox(
      height: 35, // Adjust height according to your need
      child: ListView.separated(
        itemCount: names.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: index == 0
                  ? const Color(0xFFFA058C)
                  : const Color(0xFFffebf7), // Change color for the first item
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: Text(
                names[index],
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(width: 20),
      ),
    );
  }


  Widget _gridViewProduct() {
    return FutureBuilder(
      future: instaController.getProducts(),
      builder: (context, snapshot) {
        if (snapshot.hasData &&
            snapshot.data != null &&
            snapshot.data!.isNotEmpty) {
          return GridView.builder(
            shrinkWrap: true,
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: snapshot.data!.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Number of columns
              mainAxisSpacing: 20.0,
              crossAxisSpacing: 20.0,
              childAspectRatio: 0.7, // Adjust height of the cards
            ),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Get.to(const Details(),
                      arguments: {'id': snapshot.data![index].id});
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey.shade100,
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.grey.shade100,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            snapshot.data![index].image,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        snapshot.data![index].name,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        snapshot.data![index].priceSale.toString(),
                        style: const TextStyle(color: Colors.pink),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }


}

class ImageListView extends StatefulWidget {
  @override
  _ImageListViewState createState() => _ImageListViewState();
}

class _ImageListViewState extends State<ImageListView> {
  List<String> _imageUrls = [];
  int _currentPage = 0;
  final int _itemsPerPage = 3;
  bool _isLoading = false;
  bool _hasMore = true;

  @override
  void initState() {
    super.initState();
    _loadMoreItems();
  }

  Future<void> _loadMoreItems() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    // Simulate a backend call with a delay
    await Future.delayed(const Duration(milliseconds: 50));

    // Simulate fetched items from backend
    List<String> fetchedItems = List.generate(
      _itemsPerPage,
          (index) => 'assets/image${_currentPage * _itemsPerPage + index}.jpg',
    );

    // Check if we fetched less than the requested number of items
    if (fetchedItems.length < _itemsPerPage) {
      _hasMore = false;
    }

    setState(() {
      _imageUrls.addAll(fetchedItems);
      _currentPage++;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListView.builder(
          shrinkWrap: true, // Make ListView wrap its content
          physics: const NeverScrollableScrollPhysics(), // Disable ListView scrolling
          itemCount: _imageUrls.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: ImageContainer(imageUrl: _imageUrls[index]),
            );
          },
        ),
        if (_hasMore && !_isLoading)
          ElevatedButton(
            onPressed: _loadMoreItems,
            child: const Center(
              child: Text('Show More'),
            ),
          ),
        if (_isLoading)
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(child: CircularProgressIndicator()),
          ),
      ],
    );
  }
}

class ImageContainer extends StatelessWidget {
  final String imageUrl;

  const ImageContainer({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    return Container(
      width: deviceWidth,
      height: 150,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imageUrl),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}