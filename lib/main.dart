import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screen/home.dart';
import 'routes/app_routes.dart';
import 'providers/cart_provider.dart';

void main() {
  runApp(const CoffeeShopApp());
}

class CoffeeShopApp extends StatelessWidget {
  const CoffeeShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CartProvider(),
      child: MaterialApp(
        title: 'Coffee Shop',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.brown,
          fontFamily: 'Sora',
          scaffoldBackgroundColor: Colors.black,
        ),
        routes: AppRoutes.routes,
      ),
    );
  }
}

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              const Spacer(),

              //Coffee Image at Center
              Image.asset(
                'assets/images/coffee_splash.png',
                height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.width * 0.8,
                fit: BoxFit.contain,
              ),

              const Spacer(),

              // Main Heading
              LayoutBuilder(
                builder: (context, constraints) {
                  // Calculate font size based on screen width
                  double fontSize = constraints.maxWidth < 350 ? 28 : 36;
                  return Text(
                    'Fall in Love with Coffee\nin Blissful Delight!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: fontSize,
                      fontWeight: FontWeight.w600,
                      height: 1.2,
                      fontFamily: 'Sora',
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),

              //Subtitle
              const Text(
                'Welcome to our cozy coffee corner,\nwhere every cup is a delightful for you.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFFA9A9A9),
                  fontSize: 14,
                  height: 1.5,
                  fontFamily: 'Sora',
                ),
              ),
              const SizedBox(height: 40),

              //Get Started Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CoffeeHomeScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFC67C4E),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'Get Started',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Sora',
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
