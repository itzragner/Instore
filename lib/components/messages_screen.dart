import 'package:flutter/material.dart';
import '../components/produit.dart';
import '../components/home_screen.dart' as home;
import '../components/profil_screen.dart';

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
            MaterialPageRoute(builder: (context) => home.HomeView()),
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
        title: Text('Message'),
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

  Widget _buildMessageInput() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Type your message...',
              ),
              // Add your controller and logic here for sending messages
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
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

  MessageBubble({required this.message, required this.isMe, required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      child: Align(
        alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          padding: EdgeInsets.all(10.0),
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
