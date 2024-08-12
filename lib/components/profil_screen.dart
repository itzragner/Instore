import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instore/services/auth.dart';
import '../components/produit.dart';
import '../components/messages_screen.dart';
import '../components/home_screen.dart';

class ProfilScreen extends StatefulWidget {
  const ProfilScreen({super.key});

  @override
  State<ProfilScreen> createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 3;
  late AnimationController _animationController;
  late Animation<double> _animation;

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
            MaterialPageRoute(builder: (context) => HomeView()),
          );
          break;
        case 1:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => InstagramProduit()),
          );
          break;
        case 2:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => MessageScreen()),
          );
          break;
        case 3:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => ProfilScreen()),
          );
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 60,
            backgroundImage: AssetImage('assets/user.png'),
          ),
          SizedBox(height: 20),
          Text(
            'Hana Slouma',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            'Hana.Slouma@gmail.com',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 40),
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
            duration: Duration(milliseconds: 300),
            transform: Matrix4.translationValues(
                0.0, 50.0 * (1.0 - _animation.value), 0.0), // Move up and down
            child: AnimatedOpacity(
              opacity: _animation.value,
              duration: Duration(milliseconds: 300),
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                        color: Colors.black, width: 1.0), // Add top border
                  ),
                ),
                child: BottomAppBar(
                  child: Container(
                    height: 50.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          icon: _selectedIndex == 0
                              ? Icon(Icons.home)
                              : Icon(Icons.home_outlined),
                          onPressed: () {
                            _onItemTapped(0);
                          },
                        ),
                        IconButton(
                          icon: _selectedIndex == 1
                              ? Icon(Icons.shopping_bag)
                              : Icon(Icons.shopping_bag_outlined),
                          onPressed: () {
                            _onItemTapped(1);
                          },
                        ),
                        IconButton(
                          icon: _selectedIndex == 2
                              ? Icon(Icons.message)
                              : Icon(Icons.message_outlined),
                          onPressed: () {
                            _onItemTapped(2);
                          },
                        ),
                        IconButton(
                          icon: _selectedIndex == 3
                              ? Icon(Icons.account_circle)
                              : Icon(Icons.account_circle_outlined),
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
}

class VerticalButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;

  const VerticalButton({
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
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
