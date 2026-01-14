import 'package:flutter/material.dart';
import 'home_page.dart';

class CheckoutShippingPage extends StatelessWidget {
  const CheckoutShippingPage({super.key});

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
                    final double contentWidth = constraints.maxWidth >= 640
                        ? 640
                        : constraints.maxWidth;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _CheckoutStepsHeader(),
                        const SizedBox(height: 16),
                        Center(
                          child: Container(
                            width: contentWidth,
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: const Color(0xFFB1CFFF),
                              ),
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
                                  'Contact Details',
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                _TwoColumn(
                                  isWide: isWide,
                                  left: _LabeledInput(label: 'First Name'),
                                  right: _LabeledInput(label: 'Last Name'),
                                ),
                                const SizedBox(height: 12),
                                _LabeledInput(label: 'Email'),
                                const SizedBox(height: 12),
                                Text(
                                  'Phone Number',
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 120,
                                      child: DropdownButtonFormField<String>(
                                        isDense: true,
                                        items: const [
                                          DropdownMenuItem(
                                            value: '+91',
                                            child: Text('+91'),
                                          ),
                                          DropdownMenuItem(
                                            value: '+1',
                                            child: Text('+1'),
                                          ),
                                        ],
                                        onChanged: (_) {},
                                        decoration: _inputDecoration(),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    const Expanded(child: _Input(hint: '')),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  'Shipping Details',
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                _LabeledInput(label: 'Flat/House no.'),
                                const SizedBox(height: 12),
                                _LabeledInput(label: 'Address'),
                                const SizedBox(height: 12),
                                _TwoColumn(
                                  isWide: isWide,
                                  left: _LabeledInput(label: 'City'),
                                  right: _LabeledInput(label: 'State'),
                                ),
                                const SizedBox(height: 12),
                                _TwoColumn(
                                  isWide: isWide,
                                  left: _LabeledInput(label: 'Postal Code'),
                                  right: _LabeledInput(
                                    label: 'Famous Landmark',
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  children: [
                                    Checkbox(value: true, onChanged: (_) {}),
                                    const SizedBox(width: 6),
                                    const Expanded(
                                      child: Text(
                                        'My shipping and Billing address are the same',
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                                    const SizedBox(width: 16),
                                    SizedBox(
                                      height: 40,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(
                                            context,
                                          ).pushNamed('/checkout/delivery');
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color(
                                            0xFF1A699B,
                                          ),
                                          foregroundColor: Colors.white,
                                        ),
                                        child: const Text('Continue'),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
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
}

class _Input extends StatelessWidget {
  final String hint;
  const _Input({required this.hint});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: _inputDecoration().copyWith(hintText: hint),
    );
  }
}

class _LabeledInput extends StatelessWidget {
  final String label;
  const _LabeledInput({required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(color: Colors.black54),
        ),
        const SizedBox(height: 6),
        TextFormField(decoration: _inputDecoration()),
      ],
    );
  }
}

class _TwoColumn extends StatelessWidget {
  final bool isWide;
  final Widget left;
  final Widget right;
  const _TwoColumn({
    required this.isWide,
    required this.left,
    required this.right,
  });

  @override
  Widget build(BuildContext context) {
    if (!isWide) {
      return Column(children: [left, const SizedBox(height: 12), right]);
    }
    return Row(
      children: [
        Expanded(child: left),
        const SizedBox(width: 12),
        Expanded(child: right),
      ],
    );
  }
}

InputDecoration _inputDecoration() {
  return InputDecoration(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: Color(0xFFB1CFFF)),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: Color(0xFFB1CFFF)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: Color(0xFF1A699B)),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
  );
}

class _CheckoutStepsHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextStyle active = const TextStyle(
      color: Color(0xFF1A699B),
      fontWeight: FontWeight.w600,
    );
    TextStyle inactive = const TextStyle(
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
          Text('Shipping', style: active),
          const SizedBox(width: 12),
          line,
          const SizedBox(width: 8),
          dot,
          const SizedBox(width: 8),
          line,
          const SizedBox(width: 12),
          Text('Delivery', style: inactive),
          const SizedBox(width: 12),
          line,
          const SizedBox(width: 8),
          dot,
          const SizedBox(width: 8),
          line,
          const SizedBox(width: 12),
          Text('Payment', style: inactive),
        ],
      ),
    );
  }
}
