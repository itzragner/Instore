import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:instore/components/controllers/instagrameur.dart';
import 'package:instore/components/details.dart';
import 'package:instore/services/global.dart';

import '../components/add_product_screen.dart';
import '../components/home_screen.dart' as home;
import '../components/messages_screen.dart';
import '../components/profil_screen.dart';

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

  int _selectedIndex = 0;
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
          MaterialPageRoute(builder: (context) => const home.HomeView()),
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

  void _updateIconStates() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                'assets/instore.png',
                height: 50,
              ),
              const CircleAvatar(
                radius: 20, // Ajustez la taille du cercle
                backgroundImage: AssetImage('assets/marwa.jpg'),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
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
            duration: const Duration(milliseconds: 500),
            transform: Matrix4.translationValues(
                0.0, 50.0 * (1.0 - _animation.value), 0.0), // Move up and down
            child: AnimatedOpacity(
              opacity: _animation.value,
              duration: const Duration(milliseconds: 500),
              child: Container(
                decoration: const BoxDecoration(
                  border: Border(
                      top: BorderSide(
                          color: Colors.black, width: 1.0)), // Add top border
                ),
                child: BottomAppBar(
                  child: SizedBox(
                    height: 50.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          icon: _selectedIndex == 0
                              ? const Icon(Icons.home_outlined)
                              : const Icon(Icons.home_outlined),
                          onPressed: () {
                            _onItemTapped(0);
                          },
                        ),
                        IconButton(
                          icon: _selectedIndex == 1
                              ? const Icon(Icons.shopping_bag)
                              : const Icon(Icons.shopping_bag),
                          onPressed: () {
                            _onItemTapped(1);
                          },
                        ),
                        IconButton(
                          icon: _selectedIndex == 2
                              ? const Icon(Icons.message)
                              : const Icon(Icons.message_outlined),
                          onPressed: () {
                            _onItemTapped(2);
                          },
                        ),
                        IconButton(
                          icon: _selectedIndex == 3
                              ? const Icon(Icons.account_circle)
                              : const Icon(Icons.account_circle_outlined),
                          onPressed: () {
                            _onItemTapped(3);
                          },
                        ),
                      ],
                    ),
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
