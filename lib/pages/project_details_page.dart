// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

void showScheduleClassDialog(BuildContext context) {
  showGeneralDialog(
    context: context,
    barrierLabel: 'Schedule Class',
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.1),
    transitionDuration: const Duration(milliseconds: 200),
    pageBuilder: (context, anim1, anim2) {
      return const Center(child: _ScheduleClassDialog());
    },
  );
}

class ProjectDetailsPage extends StatelessWidget {
  const ProjectDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
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
              onPressed: () {},
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
                  _Tabs(active: 1, onChange: (_) {}),
                  const SizedBox(height: 16),
                  _HeaderCard(),
                  const SizedBox(height: 16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: _AboutProject()),
                      const SizedBox(width: 24),
                      Expanded(child: _ProjectFeatures()),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const _TimelineSection(),
                ],
              ),
            ),
          ),
        ),
      ),
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

class _HeaderCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                        const Expanded(
                          child: Text(
                            'AI-Powered E - Commerce Platform',
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: const [
                            Text(
                              '₹ 15,999',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            SizedBox(height: 4),
                            Text(
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
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE6F9EC),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            'Completed',
                            style: TextStyle(color: Color(0xFF27AE60)),
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Text('Project Progress'),
                        const Spacer(),
                        const Text('100%'),
                      ],
                    ),
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: const LinearProgressIndicator(
                        minHeight: 8,
                        value: 1.0,
                        backgroundColor: Color(0xFFEAF4FF),
                        color: Color(0xFF1A699B),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
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
                    children: const [
                      Icon(
                        Icons.insert_drive_file,
                        size: 18,
                        color: Colors.black54,
                      ),
                      SizedBox(width: 8),
                      Expanded(child: Text('Project Requirement .pdf')),
                      Icon(Icons.file_download_outlined),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              OutlinedButton(
                onPressed: () => showScheduleClassDialog(context),
                child: const Text('Schedule Class'),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Project Details'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AboutProject extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFB1CFFF)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('About Project', style: TextStyle(fontWeight: FontWeight.w700)),
          SizedBox(height: 12),
          Text('Covers pretty much everything you need to know about UX'),
          SizedBox(height: 8),
          Text('Details:'),
          SizedBox(height: 6),
          Text(
            'This module will teach you everything you need to know about it, including design, content coding and how you\'ll grow the brand or group. It doesn\'t matter whether you\'re starting or publishing, it\'s designed for everyone.',
          ),
          SizedBox(height: 6),
          Text(
            'You\'ll be exposed to desktop design layouts. But more importantly, you\'ll learn how to make design layouts for your group using different styles to differentiate them from other groups.',
          ),
          SizedBox(height: 6),
          Text('Under UI components, you\'ll learn to:'),
          SizedBox(height: 6),
          Text('• Modern elements for input selection'),
          Text('• User dashboard elements'),
          Text('• Page creation elements'),
          Text(
            '• How to use CSS with website, static sites and ecommerce site',
          ),
          SizedBox(height: 8),
          Text('Read More...'),
        ],
      ),
    );
  }
}

class _ProjectFeatures extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget feature(IconData icon, String title, String subtitle) {
      return Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFFF8FAFF),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFB1CFFF)),
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: const Color(0xFFEAF4FF),
              child: Icon(icon, color: const Color(0xFF1A699B)),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 4),
                  Text(subtitle, style: const TextStyle(color: Colors.black54)),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        feature(
          Icons.description,
          'Project Documents',
          'Documents that describe the project requirements',
        ),
        const SizedBox(height: 12),
        feature(
          Icons.cloud_outlined,
          'Online Class',
          'Classes to support project work',
        ),
        const SizedBox(height: 12),
        feature(
          Icons.accessibility_new,
          'Free Accessbility',
          'Accessibility support for all users',
        ),
        const SizedBox(height: 12),
        feature(
          Icons.light_mode_outlined,
          'Light Weight',
          'Lightweight implementation',
        ),
        const SizedBox(height: 12),
        feature(
          Icons.subscriptions_outlined,
          'Subscribe Support',
          'Support via subscription service',
        ),
      ],
    );
  }
}

class _TimelineSection extends StatelessWidget {
  const _TimelineSection();
  @override
  Widget build(BuildContext context) {
    Widget item(String label, String days, {bool done = false}) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFFB1CFFF)),
        ),
        child: Row(
          children: [
            Expanded(child: Text(label)),
            Text(
              days,
              style: TextStyle(
                color: done ? const Color(0xFF27AE60) : Colors.black54,
              ),
            ),
          ],
        ),
      );
    }

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
          Row(
            children: const [
              Expanded(
                child: Text(
                  'Project Timeline',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
              Text('1 Day Left', style: TextStyle(color: Colors.black54)),
            ],
          ),
          const SizedBox(height: 12),
          item('Order Placed', '1 Day', done: true),
          const SizedBox(height: 8),
          item('Project planning', '2 Days'),
          const SizedBox(height: 8),
          item('Definition: Ranking for Success Part 02', '3 Days'),
          const SizedBox(height: 8),
          item(
            'Information Architecture: Creating a Solid foundation',
            '7 Days',
          ),
        ],
      ),
    );
  }
}

class _ScheduleClassDialog extends StatefulWidget {
  const _ScheduleClassDialog();

  @override
  State<_ScheduleClassDialog> createState() => _ScheduleClassDialogState();
}

class _ScheduleClassDialogState extends State<_ScheduleClassDialog> {
  int activeClass = 1;
  DateTime selectedDate = DateTime(2025, 5, 18);
  int? selectedSlotIndex = 2;

  final List<String> slots = [
    '08:30am',
    '08:30am',
    '08:30am',
    '08:30am',
    '08:30am',
    '08:30am',
    '08:30am',
    '08:30am',
    '08:30am',
    '08:30am',
    '08:30am',
    '08:30am',
    '08:30am',
    '08:30am',
    '08:30am',
  ];

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        width: 782,
        margin: const EdgeInsets.symmetric(horizontal: 24),
        padding: const EdgeInsets.all(16),
        constraints: BoxConstraints(
          maxWidth: 782,
          maxHeight: MediaQuery.of(context).size.height - 120,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Color(0x33000000),
              blurRadius: 20,
              offset: Offset(0, 8),
            ),
          ],
          border: Border.all(color: const Color(0xFFB1CFFF)),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 8),
              const Center(
                child: Text(
                  'Shedule Date of Class',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(height: 16),
              const Text('Select Date'),
              const SizedBox(height: 8),
              Center(
                child: SizedBox(
                  width: 625,
                  height: 103,
                  child: Row(
                    children: [
                      for (int i = 0; i < 4; i++) ...[
                        Expanded(
                          child: InkWell(
                            onTap: () => setState(() => activeClass = i),
                            child: Container(
                              height: 48,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: activeClass == i
                                    ? const Color(0xFF1A699B)
                                    : const Color(0xFFF8FAFF),
                                borderRadius: BorderRadius.circular(18),
                                border: Border.all(
                                  color: const Color(0xFFB1CFFF),
                                ),
                              ),
                              child: Text(
                                'Class ${i + 1}',
                                style: TextStyle(
                                  color: activeClass == i
                                      ? Colors.white
                                      : const Color(0xFF1A699B),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                        if (i < 3) const SizedBox(width: 8),
                      ],
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text('Select Date'),
              const SizedBox(height: 8),
              Center(
                child: SizedBox(
                  width: 587,
                  height: 567,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8FAFF),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFB1CFFF)),
                    ),
                    padding: const EdgeInsets.all(12),
                    child: _MonthCalendar(
                      month: DateTime(2025, 5, 1),
                      selected: selectedDate,
                      onSelect: (d) => setState(() => selectedDate = d),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Select time slot',
                style: TextStyle(
                  color: Color(0xFFE74C3C),
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: SizedBox(
                  width: 690,
                  height: 282,
                  child: GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 5,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    children: List.generate(slots.length, (i) {
                      final isUnavailable = i == 0;
                      final isSelected = selectedSlotIndex == i;
                      final bg = isUnavailable
                          ? const Color(0xFFFFECEC)
                          : isSelected
                          ? Colors.white
                          : const Color(0xFFF8FAFF);
                      final border = isUnavailable
                          ? const Color(0xFFE74C3C)
                          : isSelected
                          ? const Color(0xFF27AE60)
                          : const Color(0xFFB1CFFF);
                      final text = isUnavailable
                          ? Colors.white
                          : isSelected
                          ? const Color(0xFF27AE60)
                          : const Color(0xFF1A699B);
                      return InkWell(
                        onTap: () => setState(() => selectedSlotIndex = i),
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: bg,
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(color: border),
                          ),
                          child: Text(
                            slots[i],
                            style: TextStyle(
                              color: text,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: 160,
                  height: 44,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1A699B),
                      shape: const StadiumBorder(),
                    ),
                    child: const Text(
                      'Save',
                      style: TextStyle(color: Colors.white),
                    ),
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

class _MonthCalendar extends StatelessWidget {
  final DateTime month;
  final DateTime selected;
  final ValueChanged<DateTime> onSelect;
  const _MonthCalendar({
    required this.month,
    required this.selected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final year = month.year;
    final m = month.month;
    final first = DateTime(year, m, 1);
    final daysInMonth = DateTime(year, m + 1, 0).day;
    final startWeekday = (first.weekday % 7); // Monday=1..Sunday=7 -> 0..6

    Widget header() {
      const names = ['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su'];
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: const [
              Icon(Icons.chevron_left),
              Expanded(
                child: Center(
                  child: Text(
                    'May 2025',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              Icon(Icons.chevron_right),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              for (final n in names)
                Expanded(
                  child: Center(
                    child: Text(
                      n,
                      style: const TextStyle(color: Colors.black54),
                    ),
                  ),
                ),
            ],
          ),
        ],
      );
    }

    List<Widget> grid() {
      final cells = <Widget>[];
      for (int i = 0; i < startWeekday; i++) {
        cells.add(const SizedBox());
      }
      for (int d = 1; d <= daysInMonth; d++) {
        final date = DateTime(year, m, d);
        final isSelected =
            selected.year == year && selected.month == m && selected.day == d;
        cells.add(
          GestureDetector(
            onTap: () => onSelect(date),
            child: Container(
              height: 40,
              margin: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFF1A699B)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Center(
                child: Text(
                  '$d',
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black87,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        );
      }
      // Ensure full 6 rows
      while (cells.length < 42) {
        cells.add(const SizedBox());
      }
      return cells;
    }

    return Column(
      children: [
        header(),
        const SizedBox(height: 8),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 7,
          children: grid(),
        ),
      ],
    );
  }
}
