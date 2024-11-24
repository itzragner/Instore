import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instore/screens/Auth/login_instascreen.dart';
import 'package:instore/widgets/image_picker.dart';
import '../components/controllers/Auth_controller.dart';

class DonnesScreen extends StatefulWidget {
  const DonnesScreen({super.key});

  @override
  _DonnesScreenState createState() => _DonnesScreenState();
}

class _DonnesScreenState extends State<DonnesScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  final TextEditingController _nomInstagrammeurController =
  TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _numeroTelephoneController =
  TextEditingController();
  final TextEditingController _matriculeFiscaleController =
  TextEditingController();
  final TextEditingController _lienInstagramController =
  TextEditingController();
  final TextEditingController _motDePasseController = TextEditingController();
  final TextEditingController _confirmMotDePasseController =
  TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _postCodeController = TextEditingController();
  final TextEditingController _cinController = TextEditingController();
  final TextEditingController _companyNameController = TextEditingController();

  bool _companyUnderConstruction = false;
  final AuthController _signUpController = AuthController();
  late File _image;

  void togglePasswordVisibility() {
    setState(() {
      obscurePassword = !obscurePassword;
    });
  }

  void toggleConfirmPasswordVisibility() {
    setState(() {
      obscureConfirmPassword = !obscureConfirmPassword;
    });
  }

  void resetFields() {
    _nomInstagrammeurController.clear();
    _emailController.clear();
    _numeroTelephoneController.clear();
    _matriculeFiscaleController.clear();
    _lienInstagramController.clear();
    _motDePasseController.clear();
    _confirmMotDePasseController.clear();
    _streetController.clear();
    _cityController.clear();
    _postCodeController.clear();
    _cinController.clear();
    _companyNameController.clear();
    setState(() {
      _companyUnderConstruction = false;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Mes Données',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20.0),
              CustomTextField(
                controller: _nomInstagrammeurController,
                labelText: 'Nom Instagrammeur',
              ),
              const SizedBox(height: 10.0),
              CustomTextField(
                controller: _numeroTelephoneController,
                labelText: 'Numéro de téléphone',
                keyboardType: TextInputType.phone,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                ],
              ),
              const SizedBox(height: 10.0),
              CustomTextField(
                controller: _cinController,
                labelText: 'CIN',
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                ],
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Veuillez entrer votre CIN';
                  }
                  if (value.length < 8) {
                    return 'Le CIN doit avoir au moins 8 chiffres';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10.0),
              CustomTextField(
                controller: _emailController,
                labelText: 'Email',
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Veuillez entrer votre adresse email';
                  }
                  if (!RegExp(
                      r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b')
                      .hasMatch(value)) {
                    return 'Veuillez entrer une adresse email valide';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10.0),
              CustomTextField(
                controller: _streetController,
                labelText: 'Adresse',
              ),
              const SizedBox(height: 10.0),
              CustomTextField(
                controller: _cityController,
                labelText: 'Ville',
              ),
              const SizedBox(height: 10.0),
              CustomTextField(
                  controller: _postCodeController,
                  labelText: 'Code Postale',
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Veuillez entrer votre code postale';
                    }
                    if (value.length < 4) {
                      return 'Le code postale doit avoir au moins 4 chiffres';
                    }
                    return null;
                  }),
              const SizedBox(height: 10.0),
              CustomTextField(
                controller: _lienInstagramController,
                labelText: 'Lien du compte Instagram',
              ),
              const SizedBox(height: 10.0),
              CustomTextField(
                controller: _companyNameController,
                labelText: 'Nom de l\'entreprise',
              ),
              const SizedBox(height: 10.0),
              Row(
                children: [
                  const Text(
                    'L\'entreprise est en construction?',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Checkbox(
                    value: _companyUnderConstruction,
                    onChanged: (value) {
                      setState(() {
                        _companyUnderConstruction = value!;
                      });
                    },
                  ),
                ],
              ),
             
              const SizedBox(height: 10.0),
              ElevatedButton(
                onPressed: () {
                },
                child: const Text('Enregistrer'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final FormFieldValidator<String>? validator;
  final bool obscureText;
  final Widget? suffixIcon;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.labelText,
    this.keyboardType,
    this.inputFormatters,
    this.validator,
    this.obscureText = false,
    this.suffixIcon,
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      inputFormatters: widget.inputFormatters,
      obscureText: widget.obscureText,
      decoration: InputDecoration(
        labelText: widget.labelText,
        labelStyle: const TextStyle(fontWeight: FontWeight.bold),
        suffixIcon: widget.suffixIcon,
        errorStyle: const TextStyle(color: Colors.red),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.green),
          borderRadius: BorderRadius.circular(10.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      validator: widget.validator,
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: DonnesScreen(),
  ));
}
