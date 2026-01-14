import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/project_provider.dart';
import 'home_page.dart';
import 'project_detail_page.dart';

class ProjectPage extends StatefulWidget {
  const ProjectPage({super.key});

  @override
  State<ProjectPage> createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  @override
  void initState() {
    super.initState();

    // LOAD PROJECTS FROM API
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<ProjectProvider>().loadProjects();
    });
  }

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
          TextButton(onPressed: () {}, child: const Text('Projects')),
          TextButton(onPressed: () {}, child: const Text('About us')),
          TextButton(onPressed: () {}, child: const Text('3D Printing')),
          TextButton(onPressed: () {}, child: const Text('Gallery')),
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          IconButton(
            onPressed: () => Navigator.pushNamed(context, '/cart'),
            icon: const Icon(Icons.shopping_cart_outlined),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/login'),
              child: const Text('Login'),
            ),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.topRight,
            colors: [Color(0xFFE6F6F0), Color(0xFFFDE8F3)],
          ),
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1240),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  children: [
                    Text(
                      'All Categories Projects',
                      style: theme.textTheme.headlineLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0F2A46),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF27AE60),
                            foregroundColor: Colors.white,
                          ),
                          child: const Text('All Categories'),
                        ),
                        const Spacer(),
                        SizedBox(
                          width: 600,
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Search anything...',
                              prefixIcon: const Icon(Icons.search),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                            ),
                          ),
                        ),
                        const Spacer(),
                        OutlinedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/custom-project');
                          },
                          child: const Text('Custom Projects'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    const _ProjectsGrid(),
                    const SizedBox(height: 24),
                    OutlinedButton(
                      onPressed: () {},
                      child: const Text("Load More"),
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

class _ProjectsGrid extends StatelessWidget {
  const _ProjectsGrid();

  @override
  Widget build(BuildContext context) {
    return Consumer<ProjectProvider>(
      builder: (context, provider, _) {
        if (provider.loading) {
          return const Padding(
            padding: EdgeInsets.all(24),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (provider.projects.isEmpty) {
          if (provider.errorMessage != null) {
            return Padding(
              padding: const EdgeInsets.all(24),
              child: Text(
                provider.errorMessage!,
                style: const TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
            );
          }
          return const Center(child: Text("No projects found"));
        }

        return LayoutBuilder(
          builder: (context, constraints) {
            int count = 1;
            if (constraints.maxWidth >= 1100) {
              count = 3;
            } else if (constraints.maxWidth >= 800) {
              count = 2;
            }

            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: provider.projects.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: count,
                crossAxisSpacing: 24,
                mainAxisSpacing: 24,
                childAspectRatio: 1,
              ),
              itemBuilder: (context, i) {
                final p = provider.projects[i] as Map<String, dynamic>;
                final title = (p['title'] ?? p['name'] ?? 'No Title')
                    .toString();
                final tag = p['category']?.toString() ?? 'General';
                final priceStr = (p['price'] ?? '0').toString();

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

                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => ProjectDetailPage(project: p),
                      ),
                    );
                  },
                  child: _ProjectCard(
                    imagePath: img.isNotEmpty
                        ? img
                        : 'assets/Image Wrap (1).png',
                    title: title,
                    tag: tag,
                    price: '₹$priceStr',
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}

class _ProjectCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String tag;
  final String price;

  const _ProjectCard({
    required this.imagePath,
    required this.title,
    required this.tag,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    final isNetwork = imagePath.startsWith('http');
    final imageWidget = isNetwork
        ? Image.network(imagePath, fit: BoxFit.cover)
        : Image.asset(imagePath, fit: BoxFit.cover);
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(color: Color(0xFFE0EBFF)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: imageWidget,
              ),
            ),
            const SizedBox(height: 16),
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
                    tag,
                    style: const TextStyle(color: Color(0xFF1E6FE6)),
                  ),
                ),
                const Spacer(),
                Text(
                  price,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(title, style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
      ),
    );
  }
}
