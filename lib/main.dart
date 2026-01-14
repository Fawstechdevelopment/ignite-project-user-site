import 'package:flutter/material.dart';
import 'package:ignite_project_user_site/providers/project_provider.dart';
import 'package:provider/provider.dart';
import 'package:ignite_project_user_site/providers/auth_provider.dart';
import 'package:ignite_project_user_site/providers/cart_provider.dart';
import 'package:ignite_project_user_site/providers/class_provider.dart';
import 'package:ignite_project_user_site/providers/product_provider.dart';
import 'package:ignite_project_user_site/providers/request_provider.dart';
import 'package:ignite_project_user_site/services/api_service.dart';
import 'pages/login_page.dart';
import 'pages/signup_page.dart';
import 'pages/home_page.dart';
import 'pages/project_page.dart';
import 'pages/custom_project_page.dart';
import 'pages/three_d_printing_page.dart';
import 'pages/gallery_page.dart';
import 'pages/cart_page.dart';
import 'pages/checkout_shipping_page.dart';
import 'pages/checkout_delivery_page.dart';
import 'pages/checkout_payment_page.dart';
import 'pages/checkout_confirmation_page.dart';
import 'pages/dashboard_page.dart';
import 'pages/project_details_page.dart';
import 'widgets/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ApiService.setApiKey(
    const String.fromEnvironment('API_KEY', defaultValue: ''),
  );
  await ApiService.init();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => RequestProvider()),
        ChangeNotifierProvider(create: (_) => ClassProvider()),
        ChangeNotifierProvider(create: (_) => ProjectProvider()),
      ],
      child: MyApp(), // your existing app
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ignite User Site',
      theme: getAppTheme(),
      routes: {
        '/home': (_) => const HomePage(),
        '/login': (_) => const LoginPage(),
        '/signup': (_) => const SignupPage(),
        '/projects': (_) => const ProjectPage(),
        '/custom-project': (_) => const CustomProjectPage(),
        '/3d-printing': (_) => const ThreeDPrintingPage(),
        '/gallery': (_) => const GalleryPage(),
        '/cart': (_) => const CartPage(),
        '/checkout/shipping': (_) => const CheckoutShippingPage(),
        '/checkout/delivery': (_) => const CheckoutDeliveryPage(),
        '/checkout/payment': (_) => const CheckoutPaymentPage(),
        '/checkout/confirmed': (_) => const CheckoutConfirmationPage(),
        '/dashboard': (_) => const DashboardPage(),
        '/project-details': (_) => const ProjectDetailsPage(),
      },
      home: const HomePage(),
    );
  }
}
