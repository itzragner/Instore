import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:instore/services/instagrameur.dart';
import 'package:instore/components/details.dart';
import 'package:instore/services/global.dart';

import '../add_product_screen.dart';
import 'home_screen.dart' as home;
import 'messages_screen.dart';
import 'profil_screen.dart';
import '../services/local_storage.dart';

class InstagramProduit extends StatefulWidget {
  const InstagramProduit({super.key});

  @override
  State<InstagramProduit> createState() => _InstagramProduitState();
}

class _InstagramProduitState extends State<InstagramProduit>
    with TickerProviderStateMixin {
  InstagrameurController instaController = Get.find<InstagrameurController>();
  bool isLoading = true;
  final List<String> names = <String>[
    'Vetement',
    'Sport',
    'Electronic',
    'Maison',
    'Accesoire',
    'Beauté',
    'Animaux',
  ];

  late List<Map<String, dynamic>> products = [];

  Map<String, dynamic>? userData;


  int _selectedIndex = 1;
  late FocusNode _searchFocusNode;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    getAllProducts();
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
  }

  @override
  void dispose() {
    _animationController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  String generateLink(int id) {
    return '$frontOfiiceUrl$id';
  }

  void showProductModal(BuildContext context, int id) {
    var link = generateLink(id);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Product Options"),
          content: TextField(
            controller: TextEditingController(text: link),
            readOnly: true,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Product Link",
            ),
          ),
          actions: [
            TextButton(
              child: const Text("View Details"),
              onPressed: () {
                Navigator.of(context).pop();
                Get.to(() => const Details(), arguments: {"id": id});
              },
            ),
            TextButton(
              child: const Text("Copy Link"),
              onPressed: () {
                Navigator.of(context).pop();
                Clipboard.setData(ClipboardData(text: link));
                Get.snackbar(
                  "Link Copied",
                  "The product link has been copied to the clipboard",
                  snackPosition: SnackPosition.BOTTOM,
                );
              },
            ),
          ],
        );
      },
    );
  }

  getAllProducts() async {
    setState(() {
      isLoading = true;
    });
    instaController.getStoreProducts().then((value) {
      Map<String, dynamic> product = {};
      List<Map<String, dynamic>> productsList = [];
      List<dynamic> data = value['data'];
      for (var element in data) {
        var p = element['product_id'];
        var image = p['images'][0]['path'];
        product = {
          ...p,
          "image": image,
          "price": element['price'],
        };
        productsList.add(product);
      }
      setState(() {
        products = productsList;
        isLoading = false;
      });
    });
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
          MaterialPageRoute(builder: (context) =>  home.HomeView()),
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

  Future<void> loadUserData() async {
    final user = await LocalStorageServices().getUser();
    setState(() {
      userData = user;
    });
  }
  void _updateIconStates() {}

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
                child:  CircleAvatar(
                  radius: 20, // Ajustez la taille du cercle
                  backgroundImage: userData!['image'] != null
                      ? NetworkImage(userData!['image'])
                      : const AssetImage('assets/user.png') as ImageProvider,
                ),
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Container(
                padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
                child: Column(
                  children: [
                    _searchTextFormField(),
                    const SizedBox(height: 20),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Mes Produits',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 20),
                    _gridViewProducts(),
                  ],
                ),
              ),
      ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddProductScreen(),
            ),
          );
        },
        backgroundColor: const Color(0xFFFA058C),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ), // Couleur du bouton
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.endFloat, // Position du bouton
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
      child: TextFormField(
        focusNode: _searchFocusNode,
        decoration: const InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(
            Icons.search,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _gridViewProducts() {
    return SizedBox(
      height: 400,
      child: GridView.builder(
        itemCount: products.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Nombre de colonnes
          mainAxisSpacing: 20.0,
          crossAxisSpacing: 20.0,
          childAspectRatio: 0.7, // Ajuster la hauteur des cartes
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => showProductModal(context, products[index]['id']),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey.shade100,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 100,
                    width: 250,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey.shade100,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        products[index]['image']!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          products[index]['name']!,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          products[index]['price']!,
                          style: const TextStyle(color: Colors.pink),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.green,
                        ),
                        onPressed: () {
                          // Ajouter votre logique de modification ici
                        },
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          // Ajouter votre logique de suppression ici
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}






//clipRRect for products

/*

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
        final imageUrl = brand['imageUrl'] ?? 'https://via.placeholder.com/150'; // Placeholder for missing image
        final name = brand['name'] ?? 'Unknown Brand';
        final description = brand['description'] ?? 'No description available';

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
            padding: const EdgeInsets.all(8.0),
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    imageUrl,
                    height: 80,
                    width: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      description,
                      style: const TextStyle(fontSize: 14),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ],
                ),
              ],
            ),
          ),
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
        title: Text(
          brand['name'] ?? 'Brand Name Unavailable',
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: brand['imageUrl'] != null
                ? Image.network(brand['imageUrl'])
                : Image.asset('assets/placeholder_image.png'), // Placeholder image
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  brand['name'] ?? 'Product Name Unavailable',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8.0),
                Text(
                  brand['price']?.toString() ?? 'Price Unavailable',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 8.0),
                Text(
                  brand['description'] ?? 'Description Unavailable',
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
} */


