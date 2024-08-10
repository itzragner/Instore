import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instore/components/controllers/instagrameur.dart';
import 'package:instore/components/home_screen.dart';

class Details extends StatefulWidget {
  const Details({super.key});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  final int id = Get.arguments['id'];

  final InstagrameurController controller = Get.find<InstagrameurController>();
  List<dynamic> sizes = [];
  String selectedSize = 'M';
  List<dynamic> colors = [];
  Map<String, dynamic> data = {};
  bool isLoading = true;
  Color selectedColor = Colors.red;
  final selectedPriceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Call fetchData with the provided productId
    fetchData();
  }

  fetchData() async {
    await controller.fetchData(id).then((value) {
      setState(() {
        isLoading = false;
        data = value;
        sizes = value['sizes'];
        colors = value['colors'];
        selectedColor = getColorFromName(value['colors'][0]["name"]);
        selectedSize = value['sizes'][0]["name"];
      });
    });
  }

  addProductProvider() {
    var payload = {"price": selectedPriceController.text, "product_id": id};
    controller.addProductProvider(payload).then(
      (value) {
        if (value['status'] == 201) {
          Navigator.pop(context, 'Annuler');
          Get.to(const HomeView());
        }
      },
    );
  }

  Color hexToColor(String hex) {
    hex = hex.replaceFirst('#', '');
    if (hex.length == 6) {
      hex = 'FF$hex'; // Add alpha if missing
    }
    return Color(int.parse(hex, radix: 16));
  }

  // Function to get Color object from color name
  Color getColorFromName(String colorName) {
    switch (colorName.toLowerCase()) {
      case 'red':
        return Colors.red;
      case 'green':
        return Colors.green;
      case 'blue':
        return Colors.blue;
      case 'yellow':
        return Colors.yellow;
      case 'purple':
        return Colors.purple;
      case 'orange':
        return Colors.orange;
      case 'black':
        return Colors.black;
      case 'white':
        return Colors.white;
      case 'grey':
        return Colors.grey;
      default:
        return Colors
            .transparent; // default color if the name is not recognized
    }
  }

  Widget _buildColorButtons() {
    return isLoading || colors.isEmpty
        ? const CircularProgressIndicator()
        : Wrap(
            spacing: 8.0,
            children: colors.map((color) {
              var colorName = color['name'];

              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedColor = getColorFromName(colorName);
                  });
                },
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: getColorFromName(colorName),
                    border: Border.all(
                      color: selectedColor == color
                          ? const Color(0xFFFA058C)
                          : Colors.transparent,
                      width: 2.0,
                    ),
                  ),
                ),
              );
            }).toList(),
          );
  }

  Widget _buildSizeButtons() {
    return isLoading || sizes.isEmpty
        ? const CircularProgressIndicator()
        : Wrap(
            spacing: 8.0,
            children: sizes.map((size) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedSize = size["name"];
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: selectedSize == size["name"]
                        ? const Color(0xFFFA058C)
                        : const Color(0xFFffebf7),
                  ),
                  child: Text(
                    size["name"],
                    style: TextStyle(
                      color: selectedSize == size["name"]
                          ? Colors.white
                          : const Color(0xFFFA058C),
                    ),
                  ),
                ),
              );
            }).toList(),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(' Details'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: isLoading || data.isEmpty || colors.isEmpty || sizes.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Image.network(
                      data['images'][0]['path'],
                      height: 200,
                      width: 700,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    children: [
                      Text(
                        data['name'],
                        style: const TextStyle(
                            fontSize: 24.0, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 160.0),
                      Text(
                        data['priceSale'],
                        style: const TextStyle(
                            fontSize: 20.0,
                            color: Color(0xFFFA058C),
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5.0),
                  Text(
                    data['status'],
                    style:
                        TextStyle(fontSize: 15.0, color: Colors.green.shade300),
                  ),
                  const SizedBox(height: 8.0),
                  const Text(
                    'Description:',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    data['description'],
                    style:
                        TextStyle(fontSize: 12.0, color: Colors.grey.shade500),
                  ),
                  const SizedBox(height: 8.0),
                  const Text(
                    'Couleur:',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  _buildColorButtons(),
                  const SizedBox(height: 8.0),
                  const Text(
                    'Taille:',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  _buildSizeButtons(),
                  const SizedBox(height: 10.0),
                  const Row(
                    children: [
                      Text(
                        'Echantillon:',
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 145.0),
                      Text(
                        'Gratuit',
                        style: TextStyle(fontSize: 20.0, color: Colors.green),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    children: [
                      MaterialButton(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: const Color(0xFFFA058C),
                        onPressed: () => showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('Demande Echantillon'),
                            content: const Text(
                                'Ce produit est disponible en échantillon gratuit. Êtes-vous sûr(e) de vouloir passer une demande échantillon ?'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () =>
                                    Navigator.pop(context, 'Annuler'),
                                child: const Text('Annuler'),
                              ),
                              TextButton(
                                onPressed: () =>
                                    Navigator.pop(context, 'Confirmer'),
                                child: const Text('Confirmer'),
                              ),
                            ],
                          ),
                        ),
                        height: 45,
                        child: const Text(
                          'Demander Echantillon ',
                          style: TextStyle(color: Colors.white, fontSize: 13),
                        ),
                      ),
                      const SizedBox(
                        width: 60,
                      ),
                      MaterialButton(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: const Color(0xFFFA058C),
                        onPressed: () => showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('Ajouter un produit'),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: <Widget>[
                                  const Text(
                                      'Entrez le prix auquel vous souhaitez vendre :'),
                                  TextField(
                                    controller: selectedPriceController,
                                    decoration: const InputDecoration(
                                      border:
                                          OutlineInputBorder(), // Bordure autour du champ de texte
                                      labelText:
                                          'Prix', // Étiquette du champ de texte
                                    ),
                                  ),
                                  const Text(
                                      'La marge de prix conseillée est:'),
                                  Row(
                                    children: [
                                      Text(
                                        'Max: ${data['priceMax']}DT',
                                        style: const TextStyle(
                                          color: Colors.red,
                                        ),
                                      ),
                                      const SizedBox(
                                          width:
                                              20), // Espace entre les deux textes
                                      Text(
                                        'Favorable:  ${data['priceMax']}DT',
                                        style: const TextStyle(
                                          color: Colors.green,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () =>
                                    Navigator.pop(context, 'Annuler'),
                                child: const Text('Annuler'),
                              ),
                              TextButton(
                                onPressed: () => addProductProvider(),
                                // Navigator.pop(context, 'Confirmer'),
                                child: const Text('Confirmer'),
                              ),
                            ],
                          ),
                        ),
                        height: 45,
                        child: const Text(
                          'Ajouter ',
                          style: TextStyle(color: Colors.white, fontSize: 13),
                        ),
                      ),
                    ],
                  )
                ],
              )),
    );
  }
}
