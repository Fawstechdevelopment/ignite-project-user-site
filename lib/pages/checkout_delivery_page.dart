// ignore_for_file: non_constant_identifier_names, deprecated_member_use

import 'package:flutter/material.dart';
import 'home_page.dart';

class CheckoutDeliveryPage extends StatefulWidget {
  const CheckoutDeliveryPage({super.key});

  @override
  State<CheckoutDeliveryPage> createState() => _CheckoutDeliveryPageState();
}

class _CheckoutDeliveryPageState extends State<CheckoutDeliveryPage> {
  int qty1 = 1;
  int qty2 = 2;
  int delivery = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF1E6FE6),
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Text(
                'IGNITE\nPROJECTS',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/cart');
            },
            icon: const Icon(Icons.shopping_cart_outlined),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => const HomePage()),
                );
              },
              child: const Text('Home'),
            ),
          ),
        ],
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF0F2A46),
        elevation: 0.5,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFF2E9FF), Color(0xFFE6F3FF)],
          ),
        ),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 24,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final isWide = constraints.maxWidth >= 900;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _CheckoutStepsHeader(active: CheckoutStep.delivery),
                        const SizedBox(height: 16),
                        isWide
                            ? Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(child: _OrderSummary(theme)),
                                  const SizedBox(width: 24),
                                  Expanded(
                                    flex: 2,
                                    child: _DeliveryOptions(theme),
                                  ),
                                ],
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _OrderSummary(theme),
                                  const SizedBox(height: 16),
                                  _DeliveryOptions(theme),
                                ],
                              ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _OrderSummary(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x33858585),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Order Summary',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 16),
          _CartItem(
            title: 'Pure set',
            price: 17000,
            qty: qty1,
            onInc: () => setState(() => qty1++),
            onDec: () => setState(() => qty1 = qty1 > 1 ? qty1 - 1 : 1),
          ),
          const SizedBox(height: 16),
          _CartItem(
            title: 'Glow Cream',
            price: 17000,
            qty: qty2,
            onInc: () => setState(() => qty2++),
            onDec: () => setState(() => qty2 = qty2 > 1 ? qty2 - 1 : 1),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Gift Card / Discount code',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Color(0xFFB1CFFF)),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              SizedBox(
                height: 40,
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF1A699B),
                    side: const BorderSide(color: Color(0xFF1A699B)),
                  ),
                  child: const Text('Apply'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _SummaryRow(label: 'Subtotal', value: '₹ 17000'),
          _SummaryRow(label: 'Sales tax (6.5%)', value: '₹ 450'),
          _SummaryRow(
            label: 'Shipping Fee',
            value: 'FREE',
            valueColor: const Color(0xFF27AE60),
          ),
          const Divider(height: 24),
          _SummaryRow(label: 'Total due', value: '₹ 17000', isBold: true),
        ],
      ),
    );
  }

  Widget _DeliveryOptions(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x33858585),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Delivery Options',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          RadioListTile<int>(
            value: 0,
            groupValue: delivery,
            onChanged: (v) => setState(() => delivery = v ?? 0),
            title: const Text('Pickup on site'),
            secondary: const Text('FREE'),
          ),
          RadioListTile<int>(
            value: 1,
            groupValue: delivery,
            onChanged: (v) => setState(() => delivery = v ?? 1),
            title: const Text('Courier Service'),
            secondary: const Text('+₹ 5'),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              SizedBox(
                height: 40,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Back'),
                ),
              ),
              const Spacer(),
              SizedBox(
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/checkout/payment');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1A699B),
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Continue'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CartItem extends StatelessWidget {
  final String title;
  final int price;
  final int qty;
  final VoidCallback onInc;
  final VoidCallback onDec;
  const _CartItem({
    required this.title,
    required this.price,
    required this.qty,
    required this.onInc,
    required this.onDec,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            'assets/Image Wrap (1).png',
            width: 48,
            height: 48,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 6),
              Row(
                children: [
                  IconButton(
                    onPressed: onDec,
                    icon: const Icon(Icons.remove_circle_outline, size: 20),
                  ),
                  Text('$qty'),
                  IconButton(
                    onPressed: onInc,
                    icon: const Icon(Icons.add_circle_outline, size: 20),
                  ),
                ],
              ),
            ],
          ),
        ),
        Text('₹ $price'),
      ],
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isBold;
  final Color? valueColor;
  const _SummaryRow({
    required this.label,
    required this.value,
    this.isBold = false,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    final styleLabel = Theme.of(context).textTheme.bodyMedium;
    final styleValue =
        (isBold
                ? Theme.of(context).textTheme.bodyLarge
                : Theme.of(context).textTheme.bodyMedium)
            ?.copyWith(color: valueColor);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(child: Text(label, style: styleLabel)),
          Text(value, style: styleValue),
        ],
      ),
    );
  }
}

enum CheckoutStep { shipping, delivery, payment }

class _CheckoutStepsHeader extends StatelessWidget {
  final CheckoutStep active;
  const _CheckoutStepsHeader({required this.active});

  @override
  Widget build(BuildContext context) {
    TextStyle activeStyle = const TextStyle(
      color: Color(0xFF1A699B),
      fontWeight: FontWeight.w600,
    );
    TextStyle inactiveStyle = const TextStyle(
      color: Colors.black54,
      fontWeight: FontWeight.w500,
    );
    Widget line = Expanded(
      child: Container(height: 1, color: const Color(0xFFB1CFFF)),
    );
    Widget dot = Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFB1CFFF)),
        shape: BoxShape.circle,
      ),
    );
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 16),
      child: Row(
        children: [
          Text(
            'Shipping',
            style: active == CheckoutStep.shipping
                ? activeStyle
                : inactiveStyle,
          ),
          const SizedBox(width: 12),
          line,
          const SizedBox(width: 8),
          dot,
          const SizedBox(width: 8),
          line,
          const SizedBox(width: 12),
          Text(
            'Delivery',
            style: active == CheckoutStep.delivery
                ? activeStyle
                : inactiveStyle,
          ),
          const SizedBox(width: 12),
          line,
          const SizedBox(width: 8),
          dot,
          const SizedBox(width: 8),
          line,
          const SizedBox(width: 12),
          Text(
            'Payment',
            style: active == CheckoutStep.payment ? activeStyle : inactiveStyle,
          ),
        ],
      ),
    );
  }
}
