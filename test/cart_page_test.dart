import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:ignite_project_user_site/pages/cart_page.dart';
import 'package:ignite_project_user_site/providers/project_provider.dart';

class FakeProjectProvider2 extends ChangeNotifier implements ProjectProvider {
  @override
  bool loading = false;
  @override
  List<dynamic> projects = [];
  @override
  List<dynamic> gallery = [];
  @override
  List<dynamic> cartItems = [
    {
      'product': {'name': 'Smart CAR', 'price': '12000.00', 'cover_image': ''},
      'quantity': 1
    }
  ];

  @override
  Future<void> loadProjects() async {}
  @override
  Future<void> loadGallery() async {}
  @override
  Future<void> loadCart() async {}
  @override
  Future<bool> addToCart({required int productId, int quantity = 1}) async => true;
}

void main() {
  testWidgets('Cart page shows items and total', (tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<ProjectProvider>((_) => FakeProjectProvider2()),
        ],
        child: const MaterialApp(home: CartPage()),
      ),
    );

    expect(find.text('Your Cart'), findsOneWidget);
    expect(find.text('Smart CAR'), findsOneWidget);
    expect(find.textContaining('Total'), findsOneWidget);
  });
}
