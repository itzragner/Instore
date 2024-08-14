import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'product_screen.dart';
import 'home_screen.dart' as home;
import 'profil_screen.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> with SingleTickerProviderStateMixin {
  int _selectedIndex = 2;
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Message'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                MessageBubble(
                    message: 'Hello!', isMe: true, color: Colors.blue),
                MessageBubble(
                    message: 'Hi there!', isMe: false, color: Colors.green),
                // Add other message bubbles with different colors
              ],
            ),
          ),
          _buildMessageInput(),
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

  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          const Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Type your message...',
              ),
              // Add your controller and logic here for sending messages
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () {
              // Add your logic here for sending messages
            },
          ),
        ],
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final String message;
  final bool isMe;
  final Color color;

  MessageBubble({super.key, required this.message, required this.isMe, required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      child: Align(
        alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: isMe ? Colors.blue : color,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Text(
            message,
            style: TextStyle(
              color: isMe ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
