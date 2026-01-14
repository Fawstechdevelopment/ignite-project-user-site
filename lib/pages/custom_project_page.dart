import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'home_page.dart';

class CustomProjectPage extends StatelessWidget {
  const CustomProjectPage({super.key});

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
                        'Request Project',
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
                        children: [
                          Center(
                            child: Column(
                              children: [
                                Text(
                                  'Project Overview',
                                  style: theme.textTheme.headlineMedium
                                      ?.copyWith(
                                        color: const Color(0xFF0F2A46),
                                        fontWeight: FontWeight.w700,
                                      ),
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  "Let's start with the basics of your project",
                                  style: TextStyle(color: Color(0xFF6C6C6C)),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),
                          _FormFields(),
                          const SizedBox(height: 24),
                          Row(
                            children: const [
                              Text(
                                'Reference Documents',
                                style: TextStyle(
                                  color: Color(0xFF0F2A46),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(width: 6),
                              Text(
                                '(Optional)',
                                style: TextStyle(color: Color(0xFF6C6C6C)),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Container(
                            width: 1088,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFEFEFE),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: const Color(0xFFB1CFFF),
                              ),
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
                                  'Upload Reference Files',
                                  style: TextStyle(color: Color(0xFF6C6C6C)),
                                ),
                                const SizedBox(height: 8),
                                OutlinedButton(
                                  onPressed: () {},
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: const Color(0xFF1A699B),
                                    side: const BorderSide(
                                      color: Color(0xFF1A699B),
                                    ),
                                    shape: const StadiumBorder(),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 12,
                                    ),
                                  ),
                                  child: const Text('Choose File'),
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  'Supported format: PDF, DOC, DOCX, PNG, JPG, ZIP (Max 10MB)',
                                  style: TextStyle(
                                    color: Color(0xFF767676),
                                    fontSize: 12,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),
                          Center(
                            child: ElevatedButton(
                              onPressed: () {
                                _showSubmittedDialog(context);
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

class _FormFields extends StatefulWidget {
  @override
  State<_FormFields> createState() => _FormFieldsState();
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

class _FormFieldsState extends State<_FormFields> {
  String category = 'IoT solution';
  String timeline = 'Medium';

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Color(0xFFB1CFFF)),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          decoration: InputDecoration(
            labelText: 'Project Title',
            hintText: 'eg: Robotic arm',
            border: inputBorder,
            enabledBorder: inputBorder,
            focusedBorder: inputBorder,
          ),
        ),
        const SizedBox(height: 16),
        TextFormField(
          maxLines: 5,
          decoration: InputDecoration(
            labelText: 'Project Description',
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
                initialValue: category,
                items: const [
                  DropdownMenuItem(
                    value: 'IoT solution',
                    child: Text('IoT solution'),
                  ),
                  DropdownMenuItem(
                    value: 'Web development',
                    child: Text('Web development'),
                  ),
                  DropdownMenuItem(
                    value: '3D printing',
                    child: Text('3D printing'),
                  ),
                ],
                onChanged: (v) => setState(() => category = v ?? category),
                decoration: InputDecoration(
                  labelText: 'Project Category',
                  border: inputBorder,
                  enabledBorder: inputBorder,
                  focusedBorder: inputBorder,
                ),
              ),
            );
            final right = Expanded(
              child: DropdownButtonFormField<String>(
                initialValue: timeline,
                items: const [
                  DropdownMenuItem(value: 'Short', child: Text('Short')),
                  DropdownMenuItem(value: 'Medium', child: Text('Medium')),
                  DropdownMenuItem(value: 'Long', child: Text('Long')),
                ],
                onChanged: (v) => setState(() => timeline = v ?? timeline),
                decoration: InputDecoration(
                  labelText: 'Project Timeline',
                  border: inputBorder,
                  enabledBorder: inputBorder,
                  focusedBorder: inputBorder,
                ),
              ),
            );
            if (isWide) {
              return Row(children: [left, const SizedBox(width: 16), right]);
            }
            return Column(children: [left, const SizedBox(height: 16), right]);
          },
        ),
        const SizedBox(height: 16),
        LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth >= 800;
            final fields = [
              Expanded(
                child: TextFormField(
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
                  decoration: InputDecoration(
                    labelText: 'Project Budget',
                    border: inputBorder,
                    enabledBorder: inputBorder,
                    focusedBorder: inputBorder,
                  ),
                ),
              ),
            ];
            if (isWide) return Row(children: fields);
            return Column(
              children: [fields[0], const SizedBox(height: 16), fields[2]],
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
                  decoration: InputDecoration(
                    labelText: 'College Name',
                    border: inputBorder,
                    enabledBorder: inputBorder,
                    focusedBorder: inputBorder,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'State',
                    border: inputBorder,
                    enabledBorder: inputBorder,
                    focusedBorder: inputBorder,
                  ),
                ),
              ),
            ];
            if (isWide) return Row(children: fields);
            return Column(
              children: [fields[0], const SizedBox(height: 16), fields[2]],
            );
          },
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
