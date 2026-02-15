import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:registerpage/model/ui_model/service_provider_chatbot.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Success Animation',
      home: SuccessScreen(),
    );
  }
}

class SuccessScreen extends StatefulWidget {
  const SuccessScreen({super.key});
  @override
  State createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  bool _showCheckmark = false;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    // Define the scaling animation
    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );

    // Start the animation with a delay
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        _showCheckmark = true;
      });
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Animated Checkmark
            AnimatedOpacity(
              opacity: _showCheckmark ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 500),
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromRGBO(27, 48, 101, 1),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: const Icon(
                    Icons.check_circle,
                    color: Colors.white,
                    size: 100,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Success Text
            AnimatedOpacity(
              opacity: _showCheckmark ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 800),
              child: Text(
                'Request has been sent',
                style: GoogleFonts.quicksand(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromRGBO(27, 48, 101, 1),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const ServiceProviderChatBot(
                            recipientName: '',
                            recipientPhone: '',
                          )));
                },
                child: Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width - 300,
                  decoration: BoxDecoration(
                      color: const Color.fromRGBO(233, 237, 248, 1),
                      border: Border.all(
                        color: const Color.fromRGBO(27, 48, 101, 1),
                      ),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Contact",
                        style: GoogleFonts.aleo(
                            color: const Color.fromRGBO(27, 48, 101, 1),
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      const Icon(
                        Icons.message,
                        color: Color.fromRGBO(27, 48, 101, 1),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
