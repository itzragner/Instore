import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:instore/screens/donnes_screen.dart';
import '../services/auth.dart';
import 'product_screen.dart';
import 'messages_screen.dart';
import 'home_screen.dart';
import '../widgets/image_picker.dart';
import '../services/local_storage.dart';

class ProfilScreen extends StatefulWidget {
  const ProfilScreen({super.key});

  @override
  State<ProfilScreen> createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen>  with SingleTickerProviderStateMixin {
  int _selectedIndex = 3;
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool _isMessageSelected = false;
  bool _isAccountSelected = false;

  //userdata
  Map<String, dynamic>? userData;

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

    loadUserData();
  }

  Future<void> loadUserData() async {
    final user = await LocalStorageServices().getUser();
    setState(() {
      userData = user;
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0), // Add left and right padding
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Mon Compte',
                  style: TextStyle(
                    fontSize: 29,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Image.asset(
                  'assets/instore.png', // Path to your logo image
                  height: 80,
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.04,
          ),
          //update prfile picture
          GestureDetector(
            onTap: () async {
              final selectedImage = await selectAndUploadImage();
              if (selectedImage != null) {
                // Update the user's profile picture
              }
            },
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 100,
                  backgroundImage: userData!['image'] != null
                      ? NetworkImage(userData!['image'])
                      : const AssetImage('assets/user.png') as ImageProvider,
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Image.asset(
                    'assets/Iconcam.png', // Path to your camera icon
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Text(
            userData!['name'],
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            userData!['email'],
            style: const TextStyle(fontSize: 18),
          ),

           SizedBox(
            height: MediaQuery.of(context).size.height * 0.04,
          ),
          VerticalButton(
            title: 'Données personnelles profil',
            onPressed: () {
              Get.toNamed('/Donnes');
            },
          ),
          VerticalButton(
            title: 'Mes commandes',
            onPressed: () {
              // Action à effectuer lors du clic sur ce bouton
            },
          ),
          VerticalButton(
            title: 'Mes échantillons',
            onPressed: () {
              // Action à effectuer lors du clic sur ce bouton
            },
          ),
          VerticalButton(
            title: 'Logout',
            onPressed: () async {
              // Action à effectuer lors du clic sur ce bouton
              await AuthService.logout();

              /*if (res.statusCode == 200) {
               pref.setString("token", "");
               pref.setString("role", "");
               controller.setToken("");
               controller.setRole(""); */

              Get.offAllNamed("/");
            },
          ),
        ],
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

class VerticalButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;

  const VerticalButton({
    super.key,
    required this.title,
    this.onPressed,
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Text(
            title,
            style: const TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
