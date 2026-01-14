import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'home_page.dart';

class ThreeDPrintingPage extends StatelessWidget {
  const ThreeDPrintingPage({super.key});

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
          TextButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const HomePage()),
              );
            },
            child: const Text('Home'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/projects');
            },
            child: const Text('Projects'),
          ),
          TextButton(onPressed: () {}, child: const Text('About us')),
          TextButton(onPressed: () {}, child: const Text('3D Printing')),
          TextButton(onPressed: () {}, child: const Text('Gallery')),
          Row(
            children: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
              IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/cart');
                },
                icon: const Icon(Icons.shopping_cart_outlined),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/login');
              },
              child: const Text('Login'),
            ),
          ),
        ],
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF0F2A46),
        elevation: 0.5,
      ),
      body: Container(
        color: const Color(0xFFFFFFFF),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1390),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 32,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        'Request 3D Model Quote',
                        style: theme.textTheme.headlineLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF0F2A46),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Center(
                      child: Text(
                        'Tell us about your project requirements and we\'ll build a custom solution for you',
                        style: TextStyle(color: Color(0xFF6C6C6C)),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      width: 1142,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 28,
                        vertical: 28,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFFFFF),
                        border: Border.all(
                          color: const Color(0xFF1A699B).withValues(alpha: 0.3),
                        ),
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
                        children: const [_ThreeDForm()],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ThreeDForm extends StatefulWidget {
  const _ThreeDForm();
  @override
  State<_ThreeDForm> createState() => _ThreeDFormState();
}

class _ThreeDFormState extends State<_ThreeDForm> {
  String material = 'Resin';
  String colour = 'Medium';
  final _formKey = GlobalKey<FormState>();
  final _modelNameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _contactController = TextEditingController();
  final _budgetController = TextEditingController();

  @override
  void dispose() {
    _modelNameController.dispose();
    _descriptionController.dispose();
    _contactController.dispose();
    _budgetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Color(0xFFB1CFFF)),
    );
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              '3D model',
              style: theme.textTheme.headlineMedium?.copyWith(
                color: const Color(0xFF0F2A46),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 8),
          const Center(
            child: Text(
              "Let's start with the requirements for your 3D model",
              style: TextStyle(color: Color(0xFF6C6C6C)),
            ),
          ),
          const SizedBox(height: 24),
          const Text('Upload 3D Model File'),
          const SizedBox(height: 12),
          Container(
            width: 1142,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFFEFEFE),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFB1CFFF)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.upload_file,
                  size: 28,
                  color: Color(0xFF767676),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Upload Model Files',
                  style: TextStyle(color: Color(0xFF6C6C6C)),
                ),
                const SizedBox(height: 8),
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF1A699B),
                    side: const BorderSide(color: Color(0xFF1A699B)),
                    shape: const StadiumBorder(),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                  ),
                  child: const Text('Choose Files'),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Supported: stl, obj, step, iges, dae formats',
                  style: TextStyle(color: Color(0xFF767676), fontSize: 12),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _modelNameController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a model design name';
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: 'Model Design Name',
              hintText: 'eg: Robotic arm',
              border: inputBorder,
              enabledBorder: inputBorder,
              focusedBorder: inputBorder,
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _descriptionController,
            maxLines: 5,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter design requirements';
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: 'Design Requirements (optional)',
              hintText: 'Description',
              border: inputBorder,
              enabledBorder: inputBorder,
              focusedBorder: inputBorder,
            ),
          ),
          const SizedBox(height: 16),
          LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth >= 800;
              final left = Expanded(
                child: DropdownButtonFormField<String>(
                  initialValue: material,
                  items: const [
                    DropdownMenuItem(value: 'Resin', child: Text('Resin')),
                    DropdownMenuItem(value: 'PLA', child: Text('PLA')),
                    DropdownMenuItem(value: 'ABS', child: Text('ABS')),
                  ],
                  onChanged: (v) => setState(() => material = v ?? material),
                  decoration: InputDecoration(
                    labelText: 'Material',
                    border: inputBorder,
                    enabledBorder: inputBorder,
                    focusedBorder: inputBorder,
                  ),
                ),
              );
              final right = Expanded(
                child: DropdownButtonFormField<String>(
                  initialValue: colour,
                  items: const [
                    DropdownMenuItem(value: 'Medium', child: Text('Medium')),
                    DropdownMenuItem(value: 'Black', child: Text('Black')),
                    DropdownMenuItem(value: 'White', child: Text('White')),
                  ],
                  onChanged: (v) => setState(() => colour = v ?? colour),
                  decoration: InputDecoration(
                    labelText: 'Material Colour',
                    border: inputBorder,
                    enabledBorder: inputBorder,
                    focusedBorder: inputBorder,
                  ),
                ),
              );
              if (isWide) {
                return Row(children: [left, const SizedBox(width: 16), right]);
              }
              return Column(
                children: [left, const SizedBox(height: 16), right],
              );
            },
          ),
          const SizedBox(height: 16),
          LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth >= 800;
              final fields = [
                Expanded(
                  child: TextFormField(
                    controller: _contactController,
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter contact number';
                      }
                      if (!RegExp(r'^[0-9]{10,}$').hasMatch(value)) {
                        return 'Please enter valid contact number';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Contact Number',
                      border: inputBorder,
                      enabledBorder: inputBorder,
                      focusedBorder: inputBorder,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    controller: _budgetController,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter budget';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Model Budget',
                      border: inputBorder,
                      enabledBorder: inputBorder,
                      focusedBorder: inputBorder,
                    ),
                  ),
                ),
              ];
              if (isWide) return Row(children: fields);
              return Column(
                children: [fields[0], const SizedBox(height: 16), fields[1]],
              );
            },
          ),
          const SizedBox(height: 24),
          Center(
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _showSubmittedDialog(context);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1A699B),
                foregroundColor: Colors.white,
                shape: const StadiumBorder(),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 14,
                ),
              ),
              child: const Text('Submit Request'),
            ),
          ),
        ],
      ),
    );
  }
}

void _showSubmittedDialog(BuildContext context) {
  showGeneralDialog(
    context: context,
    barrierLabel: 'Submission Success',
    barrierDismissible: true,
    barrierColor: Colors.transparent,
    transitionDuration: const Duration(milliseconds: 200),
    pageBuilder: (context, anim1, anim2) {
      return Material(
        color: Colors.transparent,
        child: Stack(
          children: [
            Positioned.fill(
              child: BackdropFilter(
                filter: ui.ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                child: Container(color: Colors.black.withValues(alpha: 0.3)),
              ),
            ),
            Center(child: _SubmissionSuccessDialog()),
          ],
        ),
      );
    },
  );
}

class _SubmissionSuccessDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 452,
      height: 462,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF1A699B).withValues(alpha: 0.4),
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x33000000),
            blurRadius: 16,
            offset: Offset(0, 8),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: const Color(0xFFE6F9EC),
            child: const Icon(
              Icons.check_circle,
              color: Color(0xFF27AE60),
              size: 40,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Request Submitted Successfully',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Color(0xFF0F2A46),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'We have received your custom project request. Our team will review it and get back to you within 24 hours',
            textAlign: TextAlign.center,
            style: TextStyle(color: Color(0xFF6C6C6C)),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: 260,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => const HomePage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1A699B),
                foregroundColor: Colors.white,
                shape: const StadiumBorder(),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
              ),
              child: const Text('Go to Dashboard'),
            ),
          ),
        ],
      ),
    );
  }
}
