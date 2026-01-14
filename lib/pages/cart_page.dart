import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/project_provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<ProjectProvider>().loadCart();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Your Cart')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Consumer<ProjectProvider>(
          builder: (context, provider, _) {
            final items = provider.cartItems;
            if (items.isEmpty) {
              return const Center(child: Text('Your cart is empty'));
            }
            double total = 0;
            for (final it in items) {
              if (it is Map) {
                final p = it['product'] ?? it['item'] ?? it;
                final priceStr =
                    (p is Map ? (p['price'] ?? it['price']) : it['price'])
                        ?.toString() ??
                    '0';
                final price =
                    double.tryParse(priceStr.replaceAll(',', '')) ?? 0;
                final qty =
                    int.tryParse((it['quantity'] ?? '1').toString()) ?? 1;
                total += price * qty;
              }
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: ListView.separated(
                    itemCount: items.length,
                    separatorBuilder: (_, __) => const Divider(height: 1),
                    itemBuilder: (context, i) {
                      final it = items[i];
                      Map<String, dynamic> p = {};
                      if (it is Map) {
                        if (it['product'] is Map) {
                          p = Map<String, dynamic>.from(it['product']);
                        } else if (it['item'] is Map)
                          p = Map<String, dynamic>.from(it['item']);
                        else
                          p = Map<String, dynamic>.from(it);
                      }
                      final title = (p['title'] ?? p['name'] ?? 'Untitled')
                          .toString();
                      final priceStr = (p['price'] ?? it['price'] ?? '0')
                          .toString();
                      String img = '';
                      if (p['cover_image'] != null) {
                        img = p['cover_image'].toString();
                      } else if (p['image'] != null)
                        img = p['image'].toString();
                      img = img.replaceAll('`', '').trim();
                      final isNet = img.startsWith('http');
                      final w = isNet
                          ? Image.network(img, fit: BoxFit.cover)
                          : Image.asset(
                              'assets/Image Wrap (1).png',
                              fit: BoxFit.cover,
                            );
                      final qty =
                          int.tryParse((it['quantity'] ?? '1').toString()) ?? 1;
                      return ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: SizedBox(width: 56, height: 56, child: w),
                        ),
                        title: Text(title),
                        subtitle: Text('Qty: $qty'),
                        trailing: Text('₹$priceStr'),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x11000000),
                        blurRadius: 6,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Total',
                          style: theme.textTheme.titleMedium,
                        ),
                      ),
                      Text(
                        '₹${total.toStringAsFixed(2)}',
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                ElevatedButton(onPressed: () {}, child: const Text('Checkout')),
              ],
            );
          },
        ),
      ),
    );
  }
}
