import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:ignite_project_user_site/pages/project_detail_page.dart';
import 'package:ignite_project_user_site/pages/cart_page.dart';
import 'package:ignite_project_user_site/providers/project_provider.dart';

class FakeProjectProvider extends ChangeNotifier implements ProjectProvider {
  @override
  bool loading = false;
  @override
  List<dynamic> projects = [];
  @override
  List<dynamic> gallery = [];
  @override
  List<dynamic> cartItems = [];

  @override
  Future<void> loadProjects() async {}
  @override
  Future<void> loadGallery() async {}
  @override
  Future<void> loadCart() async {}
  @override
  Future<bool> addToCart({required int productId, int quantity = 1}) async {
    cartItems.add({'product': {'id': productId, 'name': 'P', 'price': '10'}});
    notifyListeners();
    return true;
  }
}

void main() {
  testWidgets('Timeline renders with fallback and add to cart navigates', (tester) async {
    final proj = {
      'id': 99,
      'name': 'Test Project',
      'category': 'AI',
      'price': '100',
      'default_stages': [],
    };

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<ProjectProvider>((_) => FakeProjectProvider()),
        ],
        child: MaterialApp(
          routes: {'/cart': (_) => const CartPage()},
          home: ProjectDetailPage(project: proj),
        ),
      ),
    );

    expect(find.text('Course Timeline'), findsOneWidget);
    expect(find.byIcon(Icons.add), findsWidgets);

    final addBtn = find.text('Add to cart');
    expect(addBtn, findsOneWidget);
    await tester.tap(addBtn);
    await tester.pumpAndSettle();

    expect(find.text('Your Cart'), findsOneWidget);
  });
}
