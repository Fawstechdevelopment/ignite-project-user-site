import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/project_provider.dart';
import 'cart_page.dart';

class ProjectDetailPage extends StatefulWidget {
  final Map<String, dynamic> project;
  const ProjectDetailPage({super.key, required this.project});

  @override
  State<ProjectDetailPage> createState() => _ProjectDetailPageState();
}

class _ProjectDetailPageState extends State<ProjectDetailPage> {
  bool expandAllStages = false;
  final Set<int> _expandedStages = {};
  bool addingToCart = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final provider = context.read<ProjectProvider>();
      if (provider.projects.isEmpty) {
        provider.loadProjects();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final project = widget.project;
    final title = (project['title'] ?? project['name'] ?? 'No Title')
        .toString();
    final category = project['category']?.toString() ?? 'General';
    final priceStr = (project['price'] ?? '0').toString();
    String cover = '';
    if (project['cover_image'] != null) {
      cover = project['cover_image'].toString();
    } else if (project['image'] != null) {
      cover = project['image'].toString();
    } else if (project['images'] is List &&
        (project['images'] as List).isNotEmpty) {
      final first = (project['images'] as List).first;
      if (first is Map && first['image'] != null) {
        cover = first['image'].toString();
      }
    }
    cover = cover.replaceAll('`', '').trim();
    final isNetwork = cover.startsWith('http');
    final heroImage = isNetwork
        ? Image.network(cover, fit: BoxFit.cover, height: 280)
        : Image.asset(
            cover.isNotEmpty ? cover : 'assets/Image Wrap (1).png',
            fit: BoxFit.cover,
            height: 280,
          );
    final description =
        (project['about_description'] ?? project['description'] ?? '')
            .toString();
    final rawStages = (project['default_stages'] is List)
        ? (project['default_stages'] as List)
        : const [];
    final List<Map<String, dynamic>> stages = [
      for (int i = 0; i < rawStages.length; i++)
        if (rawStages[i] is Map)
          Map<String, dynamic>.from(rawStages[i] as Map)
        else
          {
            'stage_name': rawStages[i]?.toString() ?? 'Stage ${i + 1}',
            'description': '',
            'sequence_order': i + 1,
          },
    ];
    stages.sort((a, b) {
      int ai = int.tryParse((a['sequence_order'] ?? '').toString()) ?? 0;
      int bi = int.tryParse((b['sequence_order'] ?? '').toString()) ?? 0;
      return ai.compareTo(bi);
    });
    final List<Map<String, dynamic>> stagesEffective = stages.isNotEmpty
        ? stages
        : [
            {
              'stage_name': 'Order Placed',
              'description': 'Order received and verified',
              'sequence_order': 1,
            },
            {
              'stage_name': 'Project planning',
              'description': 'Initial planning and scope definition',
              'sequence_order': 3,
            },
            {
              'stage_name': 'Definition: Planning for Success Part 02',
              'description': 'Detailed requirements and milestones',
              'sequence_order': 5,
            },
            {
              'stage_name':
                  'Information Architecture: Creating a Solid Foundation',
              'description': 'Setup and foundational structure',
              'sequence_order': 7,
            },
          ];
    final brochure = project['brochure']?.toString();
    final gallery = (project['images'] is List)
        ? (project['images'] as List)
        : const [];

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1240),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.home,
                        size: 18,
                        color: Color(0xFF1E6FE6),
                      ),
                      const SizedBox(width: 6),
                      Text('Home', style: theme.textTheme.labelLarge),
                      const SizedBox(width: 6),
                      const Text('>'),
                      const SizedBox(width: 6),
                      Text('Projects', style: theme.textTheme.labelLarge),
                      const SizedBox(width: 6),
                      const Text('>'),
                      const SizedBox(width: 6),
                      Text(category, style: theme.textTheme.labelLarge),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x11000000),
                          blurRadius: 8,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(title, style: theme.textTheme.headlineSmall),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFE6F0FF),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      category,
                                      style: const TextStyle(
                                        color: Color(0xFF1E6FE6),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    '₹$priceStr',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  Tooltip(
                                    message: 'Add this project to your cart',
                                    child: OutlinedButton(
                                      onPressed: addingToCart
                                          ? null
                                          : () async {
                                              setState(
                                                () => addingToCart = true,
                                              );
                                              final messenger =
                                                  ScaffoldMessenger.of(context);
                                              final navigator = Navigator.of(
                                                context,
                                              );
                                              final id = int.tryParse(
                                                project['id']?.toString() ?? '',
                                              );
                                              if (id == null) {
                                                messenger.showSnackBar(
                                                  const SnackBar(
                                                    content: Text(
                                                      'Invalid product id',
                                                    ),
                                                  ),
                                                );
                                                setState(
                                                  () => addingToCart = false,
                                                );
                                                return;
                                              }
                                              final ok = await context
                                                  .read<ProjectProvider>()
                                                  .addToCart(
                                                    productId: id,
                                                    quantity: 1,
                                                  );
                                              if (!mounted) return;
                                              if (ok) {
                                                messenger.showSnackBar(
                                                  const SnackBar(
                                                    content: Text(
                                                      'Added to cart',
                                                    ),
                                                  ),
                                                );
                                                navigator.push(
                                                  MaterialPageRoute(
                                                    builder: (_) =>
                                                        const CartPage(),
                                                  ),
                                                );
                                              } else {
                                                messenger.showSnackBar(
                                                  const SnackBar(
                                                    content: Text(
                                                      'Add to cart failed. Please login',
                                                    ),
                                                  ),
                                                );
                                              }
                                              setState(
                                                () => addingToCart = false,
                                              );
                                            },
                                      child: addingToCart
                                          ? const SizedBox(
                                              width: 18,
                                              height: 18,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                              ),
                                            )
                                          : const Text('Add to cart'),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Tooltip(
                                    message: 'Proceed to buy this project now',
                                    child: ElevatedButton(
                                      onPressed: () {},
                                      child: const Text('Buy Now'),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        SizedBox(
                          width: 360,
                          height: 220,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: heroImage,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height: 280,
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFF2F6),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.play_circle_fill,
                        size: 64,
                        color: Color(0xFF1E6FE6),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 100,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: gallery.length >= 5 ? 5 : gallery.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 12),
                      itemBuilder: (context, i) {
                        final g = gallery[i];
                        String u = '';
                        if (g is Map && g['image'] != null) {
                          u = g['image'].toString();
                        }
                        u = u.replaceAll('`', '').trim();
                        final w = u.startsWith('http')
                            ? Image.network(u, fit: BoxFit.cover)
                            : Image.asset(
                                'assets/Image Wrap (1).png',
                                fit: BoxFit.cover,
                              );
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: SizedBox(width: 160, child: w),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              project['about_title']?.toString() ?? 'Overview',
                              style: theme.textTheme.titleLarge,
                            ),
                            const SizedBox(height: 8),
                            if (description.isNotEmpty) Text(description),
                            const SizedBox(height: 12),
                            OutlinedButton(
                              onPressed: () {},
                              child: const Text('Read more'),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x11000000),
                                blurRadius: 8,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              ListTile(
                                leading: Icon(
                                  Icons.widgets_outlined,
                                  color: Color(0xFF1E6FE6),
                                ),
                                title: Text('Project Components'),
                                subtitle: Text('Core materials and modules'),
                              ),
                              ListTile(
                                leading: Icon(
                                  Icons.video_camera_front_outlined,
                                  color: Color(0xFF1E6FE6),
                                ),
                                title: Text('Online Classes'),
                                subtitle: Text('Guided sessions and support'),
                              ),
                              ListTile(
                                leading: Icon(
                                  Icons.location_on_outlined,
                                  color: Color(0xFF1E6FE6),
                                ),
                                title: Text('Live Availability'),
                                subtitle: Text('In-store assistance'),
                              ),
                              ListTile(
                                leading: Icon(
                                  Icons.build_outlined,
                                  color: Color(0xFF1E6FE6),
                                ),
                                title: Text('Hardware Support'),
                                subtitle: Text('Help with setup'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  if (stages.isNotEmpty)
                    Text('Course Timeline', style: theme.textTheme.titleLarge),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x11000000),
                          blurRadius: 8,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          child: Row(
                            children: [
                              Text(
                                '${(project['project_days'] ?? '').toString()} days  Compilation Time',
                                style: theme.textTheme.labelLarge,
                              ),
                              const Spacer(),
                              TextButton(
                                onPressed: () => setState(() {
                                  expandAllStages = !expandAllStages;
                                  _expandedStages.clear();
                                  if (expandAllStages) {
                                    for (
                                      int i = 0;
                                      i < stagesEffective.length;
                                      i++
                                    ) {
                                      _expandedStages.add(i);
                                    }
                                  }
                                }),
                                child: const Text('Expand All Stages'),
                              ),
                            ],
                          ),
                        ),
                        const Divider(height: 1),
                        for (int i = 0; i < stagesEffective.length; i++)
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 56,
                                  child: Row(
                                    children: [
                                      InkWell(
                                        onTap: () => setState(() {
                                          if (_expandedStages.contains(i)) {
                                            _expandedStages.remove(i);
                                          } else {
                                            _expandedStages.add(i);
                                          }
                                          expandAllStages =
                                              _expandedStages.length ==
                                              stagesEffective.length;
                                        }),
                                        child: Icon(
                                          _expandedStages.contains(i)
                                              ? Icons.remove
                                              : Icons.add,
                                          color: i < 2
                                              ? const Color(0xFF27AE60)
                                              : const Color(0xFF9AA6B2),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Text(
                                          (stagesEffective[i]['stage_name'] ??
                                                  '')
                                              .toString(),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Text(
                                        'Day ${int.tryParse((stagesEffective[i]['sequence_order'] ?? '').toString()) ?? (i + 1)}',
                                      ),
                                    ],
                                  ),
                                ),
                                if (_expandedStages.contains(i))
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 12,
                                        left: 28,
                                        right: 8,
                                      ),
                                      child: Text(
                                        (stagesEffective[i]['description'] ??
                                                '')
                                            .toString(),
                                      ),
                                    ),
                                  ),
                                const Divider(height: 1),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Most latest project ideas',
                    style: theme.textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Consumer<ProjectProvider>(
                    builder: (context, provider, _) {
                      final items = provider.projects;
                      if (items.isEmpty) {
                        return const SizedBox.shrink();
                      }
                      return SizedBox(
                        height: 220,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: items.length > 10 ? 10 : items.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(width: 12),
                          itemBuilder: (context, i) {
                            final p = items[i] as Map<String, dynamic>;
                            final t = (p['title'] ?? p['name'] ?? 'No Title')
                                .toString();
                            final pr = (p['price'] ?? '0').toString();
                            String img = '';
                            if (p['cover_image'] != null) {
                              img = p['cover_image'].toString();
                            } else if (p['image'] != null) {
                              img = p['image'].toString();
                            } else if (p['images'] is List &&
                                (p['images'] as List).isNotEmpty) {
                              final first = (p['images'] as List).first;
                              if (first is Map && first['image'] != null) {
                                img = first['image'].toString();
                              }
                            }
                            img = img.replaceAll('`', '').trim();
                            final isNet = img.startsWith('http');
                            final w = isNet
                                ? Image.network(img, fit: BoxFit.cover)
                                : Image.asset(
                                    'assets/Image Wrap (1).png',
                                    fit: BoxFit.cover,
                                  );
                            return InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        ProjectDetailPage(project: p),
                                  ),
                                );
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: SizedBox(
                                  width: 280,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Expanded(
                                        child: ClipRRect(
                                          borderRadius:
                                              const BorderRadius.vertical(
                                                top: Radius.circular(12),
                                              ),
                                          child: w,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(12),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                t,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            Text(
                                              '₹$pr',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
