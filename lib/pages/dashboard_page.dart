// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'home_page.dart';
import 'project_details_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int tab = 1; // 0: Profile, 1: My Projects, 2: Classes, 3: Custom Request

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFF1E6FE6),
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Text(
                'LOGO',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: OutlinedButton.icon(
              onPressed: () {
                Navigator.of(context).pushNamed('/cart');
              },
              icon: const Icon(Icons.shopping_cart_outlined, size: 18),
              label: const Text('Cart'),
              style: OutlinedButton.styleFrom(
                shape: const StadiumBorder(),
                side: const BorderSide(color: Color(0xFF1A699B)),
                foregroundColor: const Color(0xFF1A699B),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: OutlinedButton(
              onPressed: () {
                _showMoreMenu(context);
              },
              style: OutlinedButton.styleFrom(
                shape: const StadiumBorder(),
                side: const BorderSide(color: Color(0xFF1A699B)),
                foregroundColor: const Color(0xFF1A699B),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
              ),
              child: const Icon(Icons.menu),
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
          padding: const EdgeInsets.all(24),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextButton.icon(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.arrow_back),
                    label: const Text('Back'),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Welcome Back',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text('Abhay sunil'),
                  const SizedBox(height: 12),
                  _Tabs(active: tab, onChange: (i) => setState(() => tab = i)),
                  const SizedBox(height: 16),
                  Container(
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
                    child: tab == 0
                        ? const _ProfileSection()
                        : tab == 2
                        ? Column(
                            children: [
                              _ClassCard(
                                title: 'AI-Powered E - Commerce Platform',
                                desc:
                                    "Learn to design, build and publish using the platform",
                                tags: const ['new', 'upcoming'],
                                showJoin: true,
                              ),
                              const SizedBox(height: 12),
                              const _ClassCard(
                                title: 'AI-Powered E - Commerce Platform',
                                desc:
                                    "Learn to design, build and publish using the platform",
                                tags: ['basic', 'recorded'],
                              ),
                              const SizedBox(height: 12),
                              const _ClassCard(
                                title: 'AI-Powered E - Commerce Platform',
                                desc:
                                    "Learn to design, build and publish using the platform",
                                tags: ['basic', 'recorded'],
                              ),
                              const SizedBox(height: 12),
                              const _ClassCard(
                                title: 'AI-Powered E - Commerce Platform',
                                desc:
                                    "Learn to design, build and publish using the platform",
                                tags: ['basic', 'recorded'],
                              ),
                            ],
                          )
                        : tab == 3
                        ? const _CustomRequestSection()
                        : Column(
                            children: const [
                              _ProjectCard(
                                title: 'AI-Powered E - Commerce Platform',
                                desc:
                                    "Team project documentation, takes the algorithmic test used in project design and publishing to the platform.",
                                price: '₹ 15,999',
                                status: 'Building',
                                progress: 0.75,
                                docName: 'Project Requirement .pdf',
                              ),
                              SizedBox(height: 16),
                              _ProjectCard(
                                title: 'AI-Powered E - Commerce Platform',
                                desc:
                                    "Team project documentation, takes the algorithmic test used in project design and publishing to the platform.",
                                price: '₹ 15,999',
                                status: 'Completed',
                                progress: 1.0,
                                docName: 'Project Requirement .pdf',
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
    );
  }

  void _showMoreMenu(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierLabel: 'More Menu',
      barrierDismissible: true,
      barrierColor: Colors.transparent,
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (context, anim1, anim2) {
        return Material(
          color: Colors.transparent,
          child: Stack(
            children: [
              Positioned.fill(
                child: Container(color: Colors.black.withOpacity(0.06)),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(top: 90, right: 24),
                  child: Container(
                    width: 254,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFB1CFFF)),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x33000000),
                          blurRadius: 16,
                          offset: Offset(0, 8),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Abhay Sunil',
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          height: 40,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              setState(() => tab = 0);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF1A699B),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Row(
                              children: const [
                                Expanded(child: Text('Account info')),
                                Icon(Icons.arrow_right_alt),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        _MenuItem(
                          label: 'Change password',
                          onTap: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).pushNamed('/login');
                          },
                        ),
                        const SizedBox(height: 8),
                        _MenuItem(
                          label: 'Home',
                          onTap: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (_) => const HomePage(),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 8),
                        _MenuItem(
                          label: 'Logout',
                          onTap: () {
                            Navigator.of(context).pop();
                            Navigator.of(
                              context,
                            ).pushReplacementNamed('/login');
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _Tabs extends StatelessWidget {
  final int active;
  final ValueChanged<int> onChange;
  const _Tabs({required this.active, required this.onChange});

  @override
  Widget build(BuildContext context) {
    final items = ['Profile', 'My Projects', 'Classes', 'Custom Request'];
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFEFF6FF),
        borderRadius: BorderRadius.circular(24),
      ),
      padding: const EdgeInsets.all(6),
      child: Row(
        children: [
          for (int i = 0; i < items.length; i++) ...[
            Expanded(
              child: InkWell(
                onTap: () => onChange(i),
                child: Container(
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: active == i ? Colors.white : Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: active == i
                        ? const [
                            BoxShadow(
                              color: Color(0x11000000),
                              blurRadius: 6,
                              offset: Offset(0, 3),
                            ),
                          ]
                        : null,
                  ),
                  child: Text(
                    items[i],
                    style: TextStyle(
                      color: active == i
                          ? const Color(0xFF1A699B)
                          : Colors.black87,
                    ),
                  ),
                ),
              ),
            ),
            if (i < items.length - 1) const SizedBox(width: 6),
          ],
        ],
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const _MenuItem({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: const Color(0xFFF8FAFF),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFFB1CFFF)),
        ),
        child: Row(
          children: [
            Expanded(child: Text(label)),
            const Icon(Icons.arrow_right_alt, color: Colors.black54),
          ],
        ),
      ),
    );
  }
}

class _ClassCard extends StatelessWidget {
  final String title;
  final String desc;
  final List<String> tags;
  final bool showJoin;
  const _ClassCard({
    required this.title,
    required this.desc,
    required this.tags,
    this.showJoin = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFB1CFFF)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              for (final t in tags) ...[
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFF),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFB1CFFF)),
                  ),
                  child: Text(
                    t,
                    style: const TextStyle(color: Colors.black54, fontSize: 12),
                  ),
                ),
                const SizedBox(width: 8),
              ],
              const Spacer(),
              if (showJoin)
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Join Class'),
                ),
              const SizedBox(width: 8),
              OutlinedButton(
                onPressed: () {
                  showScheduleClassDialog(context);
                },
                child: const Text('Schedule'),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 4),
          Text(desc, style: const TextStyle(color: Colors.black54)),
        ],
      ),
    );
  }
}

class _ProfileSection extends StatelessWidget {
  const _ProfileSection();

  @override
  Widget build(BuildContext context) {
    InputDecoration deco(String label) => InputDecoration(
      labelText: label,
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
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              'Account Details',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            const Spacer(),
            OutlinedButton(
              onPressed: () {
                showGeneralDialog(
                  context: context,
                  barrierLabel: 'Edit Profile',
                  barrierDismissible: true,
                  barrierColor: Colors.black.withOpacity(0.06),
                  transitionDuration: const Duration(milliseconds: 200),
                  pageBuilder: (context, a, b) {
                    return const _EditProfileDialog();
                  },
                );
              },
              child: const Text('Edit'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(child: TextFormField(decoration: deco('First Name'))),
            const SizedBox(width: 12),
            Expanded(child: TextFormField(decoration: deco('Last Name'))),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: TextFormField(decoration: deco('Email'))),
            const SizedBox(width: 12),
            Expanded(child: TextFormField(decoration: deco('Phone Number'))),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: TextFormField(decoration: deco('Online Name'))),
            const SizedBox(width: 12),
            Expanded(
              child: TextFormField(
                decoration: deco('Password'),
                obscureText: true,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Text(
          'Shipping Details',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 12),
        TextFormField(maxLines: 3, decoration: deco('Address line')),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: TextFormField(decoration: deco('City'))),
            const SizedBox(width: 12),
            Expanded(child: TextFormField(decoration: deco('State'))),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: TextFormField(decoration: deco('Pin code'))),
            const SizedBox(width: 12),
            Expanded(child: TextFormField(decoration: deco('Country'))),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: const [
            Checkbox(value: true, onChanged: null),
            SizedBox(width: 8),
            Expanded(child: Text('I agree to the terms and privacy policy')),
          ],
        ),
      ],
    );
  }
}

class _EditProfileDialog extends StatefulWidget {
  const _EditProfileDialog();

  @override
  State<_EditProfileDialog> createState() => _EditProfileDialogState();
}

class _EditProfileDialogState extends State<_EditProfileDialog> {
  bool enabled = true;

  InputDecoration deco(String label) => InputDecoration(
    labelText: label,
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
  );

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Center(
        child: Container(
          width: 720,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFB1CFFF)),
            boxShadow: const [
              BoxShadow(
                color: Color(0x33000000),
                blurRadius: 16,
                offset: Offset(0, 8),
              ),
            ],
          ),
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      'Account Details',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                    const Spacer(),
                    Switch(
                      value: enabled,
                      onChanged: (v) => setState(() => enabled = v),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: deco('First Name'),
                        enabled: enabled,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextFormField(
                        decoration: deco('Last Name'),
                        enabled: enabled,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: deco('Email'),
                        enabled: enabled,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextFormField(
                        decoration: deco('Phone Number'),
                        enabled: enabled,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: deco('Online Name'),
                        enabled: enabled,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextFormField(
                        decoration: deco('Password'),
                        obscureText: true,
                        enabled: enabled,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Text(
                  'Shipping Details',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  maxLines: 3,
                  decoration: deco('Address line'),
                  enabled: enabled,
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: deco('City'),
                        enabled: enabled,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextFormField(
                        decoration: deco('State'),
                        enabled: enabled,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: deco('Pin code'),
                        enabled: enabled,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextFormField(
                        decoration: deco('Country'),
                        enabled: enabled,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Cancel'),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Confirm'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CustomRequestSection extends StatelessWidget {
  const _CustomRequestSection();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1137),
        child: Container(
          height: 184,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFF1A699B)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Ready to Build Something Amazing?',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 8),
              const Text(
                'Join thousands of students and companies who trust us for their tech\nsolutions. Get started today with our expert team.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black54),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 36,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/custom-project');
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    backgroundColor: const Color(0xFF1A699B),
                  ),
                  child: const Text(
                    'Request Custom Project',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProjectCard extends StatelessWidget {
  final String title;
  final String desc;
  final String price;
  final String status;
  final double progress;
  final String docName;
  const _ProjectCard({
    required this.title,
    required this.desc,
    required this.price,
    required this.status,
    required this.progress,
    required this.docName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFB1CFFF)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  'assets/Image Wrap (1).png',
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            style: const TextStyle(fontWeight: FontWeight.w700),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              price,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'Purchased 12/02/25',
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(desc, style: const TextStyle(color: Colors.black54)),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: status == 'Completed'
                                ? const Color(0xFFE6F9EC)
                                : const Color(0xFFFFF4E6),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            status,
                            style: TextStyle(
                              color: status == 'Completed'
                                  ? const Color(0xFF27AE60)
                                  : const Color(0xFFB37A00),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Text('Project Progress'),
                        const Spacer(),
                        Text('${(progress * 100).round()}%'),
                      ],
                    ),
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: LinearProgressIndicator(
                        minHeight: 8,
                        value: progress,
                        backgroundColor: const Color(0xFFEAF4FF),
                        color: const Color(0xFF1A699B),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text('Project Documents'),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFF),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFB1CFFF)),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.insert_drive_file,
                        size: 18,
                        color: Colors.black54,
                      ),
                      const SizedBox(width: 8),
                      Expanded(child: Text(docName)),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.file_download_outlined),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              OutlinedButton(
                onPressed: () {
                  showScheduleClassDialog(context);
                },
                child: const Text('Schedule Class'),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/project-details');
                },
                child: const Text('Project Details'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
