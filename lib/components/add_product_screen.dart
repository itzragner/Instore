import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../components/category.dart';
import '../models/product_model.dart' as ProductModel;

class AddProductScreen extends StatefulWidget {
  // final List<Brand> brands;

  final List<String> names = <String>[
    'Vetement',
    'Sport',
    'Electronic',
    'Maison',
    'Accesoire',
    'Beauté',
    'Animaux',
  ];

  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController brandNameController = TextEditingController();
  // Brand? selectedBrand;
  Category? selectedCategory;
  List<File> _images = [];
  int _selectedImageIndex = 0;
  bool isNameValid = false;
  bool isDescriptionValid = false;
  bool isPriceValid = false;
  bool isBrandValid = false;
  bool isCategoryValid = false;
  bool isImageSelected = false;

  final ImagePicker _picker = ImagePicker();

  Future<void> _addNewBrand() async {
    String? newBrandName = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Ajouter une nouvelle marque'),
          content: TextField(
            controller: brandNameController,
            decoration: const InputDecoration(hintText: 'Nom de la marque'),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Annuler'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Ajouter'),
              onPressed: () {
                String newBrandName = brandNameController.text;
                Navigator.of(context).pop(newBrandName);
              },
            ),
          ],
        );
      },
    );

    // if (newBrandName != null && newBrandName.isNotEmpty) {
    //   setState(() {
    //     selectedBrand = Brand(name: newBrandName);
    //     widget.brands.add(selectedBrand!);
    //     isBrandValid = true;
    //   });
    // }
  }

  Future<void> _pickImage() async {
    List<XFile>? pickedFiles = await _picker.pickMultiImage();

    if (pickedFiles != null && pickedFiles.isNotEmpty) {
      setState(() {
        List<File> images = [];
        pickedFiles.forEach((file) {
          images.add(File(file.path));
        });
        _images = images;
        isImageSelected = true;
      });
    }
  }

  InputDecoration _buildInputDecoration(String labelText, bool isValid) {
    Color borderColor = isValid ? Colors.green : Colors.red;
    return InputDecoration(
      labelText: labelText,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(color: borderColor),
      ),
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink.shade200,
        title: const Text(
          'Add Product',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: Colors.black,
            height: 1.0,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Product Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: isNameValid ? Colors.green : Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: isNameValid ? Colors.green : Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    isNameValid = value.isNotEmpty;
                  });
                },
              ),
              const SizedBox(height: 16),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: isDescriptionValid ? Colors.green : Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: isDescriptionValid ? Colors.green : Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    isDescriptionValid = value.isNotEmpty;
                  });
                },
              ),
              const SizedBox(height: 16),
              TextField(
                controller: priceController,
                decoration: InputDecoration(
                  labelText: 'Price',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: isPriceValid ? Colors.green : Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: isPriceValid ? Colors.green : Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    isPriceValid = value.isNotEmpty;
                  });
                },
              ),
              // SizedBox(height: 16),
              // Container(
              //   padding: EdgeInsets.symmetric(horizontal: 12),
              //   decoration: BoxDecoration(
              //     border: Border.all(
              //         color: isBrandValid ? Colors.green : Colors.grey),
              //     borderRadius: BorderRadius.circular(50.0),
              //   ),
              //   child: DropdownButton<Brand>(
              //     hint: Text('Select Brand'),
              //     value: selectedBrand,
              //     isExpanded: true,
              //     underline: SizedBox(),
              //     onChanged: (Brand? newValue) {
              //       setState(() {
              //         if (newValue != null) {
              //           selectedBrand = newValue!;
              //           isBrandValid = true;
              //         } else {
              //           _addNewBrand();
              //         }
              //       });
              //     },
              //     items: [
              //       ...widget.brands
              //           .map<DropdownMenuItem<Brand>>((Brand brand) {
              //         return DropdownMenuItem<Brand>(
              //           value: brand,
              //           child: Text(brand.name),
              //         );
              //       }).toList(),
              //       DropdownMenuItem<Brand>(
              //         value: null,
              //         child: Text(
              //           'Créer une nouvelle marque',
              //           style: TextStyle(
              //               color: Colors
              //                   .grey.shade600), // Ajout de la couleur grise
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              const SizedBox(height: 16),
              // Container(
              //   padding: EdgeInsets.symmetric(horizontal: 12),
              //   decoration: BoxDecoration(
              //     border: Border.all(
              //         color: isBrandValid ? Colors.green : Colors.grey),
              //     borderRadius: BorderRadius.circular(50.0),
              //   ),
              //   child: DropdownButton<Category>(
              //     hint: Text('Select Category'),
              //     value: selectedCategory,
              //     isExpanded: true,
              //     underline: SizedBox(),
              //     onChanged: (Category? newValue) {
              //       setState(() {
              //         selectedCategory = newValue!;
              //         isCategoryValid = true;
              //       });
              //     },
              //     items: widget.names
              //         .map<DropdownMenuItem<Category>>((Category category) {
              //       return DropdownMenuItem<Category>(
              //         value: category,
              //         child: Text(category.name),
              //       );
              //     }).toList(),
              //   ),
              // ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: isImageSelected ? Colors.green : Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: isImageSelected ? Colors.green : Colors.grey),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          isImageSelected ? 'Image Selected' : 'Select Image',
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(width: 10),
                        Icon(
                          Icons.camera_alt,
                          color: Colors.grey[800],
                          size: 35,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              if (_images.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 5),
                    const Text(
                      'Selected Images',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                              child: Container(
                                width: 450,
                                height: 450,
                                child: Image.file(
                                  _images[_selectedImageIndex],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: Container(
                        width: 300,
                        height: 300,
                        child: Image.file(
                          _images[_selectedImageIndex],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 4.0,
                      runSpacing: 4.0,
                      children: _images.asMap().entries.map((entry) {
                        int index = entry.key;
                        File image = entry.value;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedImageIndex = index;
                            });
                          },
                          child: Container(
                            width: 100,
                            height: 100,
                            child: Image.file(
                              image,
                              fit: BoxFit.contain,
                            ),
                            alignment: Alignment.center,
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (nameController.text.isNotEmpty &&
                      descriptionController.text.isNotEmpty &&
                      priceController.text.isNotEmpty &&
                      // selectedBrand != null &&
                      selectedCategory != null &&
                      _images.isNotEmpty) {
                    List<ProductModel.Product> newProducts = [];
                    _images.forEach((image) {
                      ProductModel.Product newProduct = ProductModel.Product(
                        name: nameController.text,
                        description: descriptionController.text,
                        price: double.parse(priceController.text),
                        // brand: selectedBrand!,
                        image: image,
                      );
                      newProducts.add(newProduct);
                    });
                    Navigator.pop(context, {
                      'products': newProducts,
                      'category': selectedCategory
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                            'Veuillez remplir tous les champs correctement.'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  backgroundColor: isNameValid &&
                          isDescriptionValid &&
                          isPriceValid &&
                          isBrandValid &&
                          isCategoryValid &&
                          isImageSelected
                      ? Colors.green
                      : null,
                ),
                child: const Text(
                  'Add Product',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
