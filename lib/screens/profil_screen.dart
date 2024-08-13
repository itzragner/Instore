import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../services/auth.dart';
import 'produit.dart';
import 'messages_screen.dart';
import 'home_screen.dart';
import '../widgets/image_picker.dart';
import '../services/local_storage.dart';

class ProfilScreen extends StatefulWidget {
  const ProfilScreen({super.key});

  @override
  State<ProfilScreen> createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> with SingleTickerProviderStateMixin {


  int _selectedIndex = 3;
  late AnimationController _animationController;
  late Animation<double> _animation;

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
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
      });
      switch (index) {
        case 0:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) =>  HomeView()),
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
          const SizedBox(height: 20),
          Text(
            userData!['name'],
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Text(
            'Hana.Slouma@gmail.com',
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 40),
          VerticalButton(
            title: 'Données personnelles profil',
            onPressed: () {
              // Action à effectuer lors du clic sur ce bouton
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
                            ? const FaIcon(
                                FontAwesomeIcons.house,
                                color: Color(0xFFFA058C),
                              )
                            : const FaIcon(
                                FontAwesomeIcons.house,
                              ),
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
                            : const FaIcon(
                                FontAwesomeIcons.bagShopping,
                              ),
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
