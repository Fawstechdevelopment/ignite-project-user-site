import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/project_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<ProjectProvider>().loadProjects();
      context.read<ProjectProvider>().loadGallery();
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
          TextButton(onPressed: () {}, child: const Text('Home')),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/projects');
            },
            child: const Text('Projects'),
          ),
          TextButton(onPressed: () {}, child: const Text('About us')),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/3d-printing');
            },
            child: const Text('3D Printing'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/gallery');
            },
            child: const Text('Gallery'),
          ),
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
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFF2E9FF), Color(0xFFE6F3FF)],
          ),
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1320),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 32,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _HeroSection(theme: theme),
                    const SizedBox(height: 40),
                    _WhyChooseSection(theme: theme),
                    const SizedBox(height: 40),
                    _UnlockProjectsSection(theme: theme),
                    const SizedBox(height: 40),
                    _InnovativeProjectsSection(theme: theme),
                    const SizedBox(height: 40),
                    _DiscoverSection(theme: theme),
                    const SizedBox(height: 40),
                    _ConsistentGrowthSection(theme: theme),
                    const SizedBox(height: 40),
                    _ProjectsGallerySection(theme: theme),
                    const SizedBox(height: 40),
                    _LowerBandSection(theme: theme),
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

class _HeroSection extends StatelessWidget {
  final ThemeData theme;
  const _HeroSection({required this.theme});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 900;
        final heroImage = ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset('assets/Hero Image Block.png', fit: BoxFit.cover),
        );
        final heroText = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Build Your Dream\nProject With Expert\nGuidance',
              style: theme.textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.w700,
                color: const Color(0xFF0F2A46),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Hands-on help for students to build high-quality projects and grow skills.',
              style: theme.textTheme.bodyLarge,
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Explore Projects'),
                ),
                OutlinedButton(
                  onPressed: () {},
                  child: const Text('3D Printing'),
                ),
              ],
            ),
          ],
        );
        if (isWide) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: heroText),
              const SizedBox(width: 24),
              Padding(
                padding: const EdgeInsets.only(left: 74),
                child: SizedBox(width: 486, height: 550, child: heroImage),
              ),
            ],
          );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 240, child: heroImage),
            const SizedBox(height: 16),
            heroText,
          ],
        );
      },
    );
  }
}

class _WhyChooseSection extends StatelessWidget {
  final ThemeData theme;
  const _WhyChooseSection({required this.theme});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 900;
        final image = ClipRRect(
          borderRadius: BorderRadius.circular(32),
          child: Image.asset(
            'assets/Feature Image → Feature Image.png',
            fit: BoxFit.cover,
          ),
        );
        final text = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Why Choose Us for Your Learning Journey',
              style: theme.textTheme.headlineMedium,
            ),
            const SizedBox(height: 12),
            Text(
              'Curated projects, mentorship, and resources to accelerate growth.',
              style: theme.textTheme.bodyLarge,
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 24,
              runSpacing: 12,
              children: const [
                _StatChip(label: '100,000+ Projects'),
                _StatChip(label: '20,000+ Students'),
              ],
            ),
            const SizedBox(height: 16),
            OutlinedButton(onPressed: () {}, child: const Text('Learn more')),
          ],
        );
        if (isWide) {
          return Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: SizedBox(width: 554.39, height: 670.48, child: image),
              ),
              const SizedBox(width: 24),
              Expanded(child: text),
            ],
          );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 220, child: image),
            const SizedBox(height: 16),
            text,
          ],
        );
      },
    );
  }
}

class _UnlockProjectsSection extends StatelessWidget {
  final ThemeData theme;
  const _UnlockProjectsSection({required this.theme});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 900;
        final rightPortrait = ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(
            'assets/Image Mask Right → Image → FqOcK9akSMnBaj4e39zgqC6m8.png.png',
            fit: BoxFit.cover,
          ),
        );
        final leftThumb = ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            'assets/Image Mask Left_mask-group.png',
            fit: BoxFit.cover,
          ),
        );
        final textBlock = Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Unlock Custom\n',
                      style: theme.textTheme.headlineLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0F2A46),
                      ),
                    ),
                    TextSpan(
                      text: 'Projects ',
                      style: theme.textTheme.headlineLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0F2A46),
                      ),
                    ),
                    TextSpan(
                      text: 'Today',
                      style: theme.textTheme.headlineLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF1E6FE6),
                        decoration: TextDecoration.underline,
                        decorationStyle: TextDecorationStyle.dotted,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            Center(
              child: Text(
                '               Choose a topic and get expert guidance to build standout projects.',
                style: theme.textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              alignment: WrapAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Get a quote'),
                ),
                OutlinedButton(
                  onPressed: () {},
                  child: const Text('Explore Projects'),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        );
        final container = Container(
          padding: const EdgeInsets.all(24),
          width: 1320,
          height: 545.56,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(40),
            boxShadow: const [
              BoxShadow(
                color: Color(0x1F000000),
                blurRadius: 16,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: isWide
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 144, top: 120),
                        child: SizedBox(
                          width: 1032,
                          height: 209.56,
                          child: textBlock,
                        ),
                      ),
                    ),
                    const SizedBox(width: 24),
                    Transform.translate(
                      offset: const Offset(-16, -16),
                      child: SizedBox(
                        width: 290.39,
                        height: 340.63,
                        child: rightPortrait,
                      ),
                    ),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    textBlock,
                    const SizedBox(height: 16),
                    SizedBox(height: 240, child: rightPortrait),
                  ],
                ),
        );
        return Stack(
          clipBehavior: Clip.none,
          children: [
            container,
            Positioned(
              left: 0,
              top: 275.49,
              child: SizedBox(width: 303.59, height: 270.08, child: leftThumb),
            ),
          ],
        );
      },
    );
  }
}

class _InnovativeProjectsSection extends StatelessWidget {
  final ThemeData theme;
  const _InnovativeProjectsSection({required this.theme});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Innovative Projects', style: theme.textTheme.headlineMedium),
        const SizedBox(height: 16),
        Consumer<ProjectProvider>(
          builder: (context, provider, _) {
            if (provider.loading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (provider.projects.isEmpty) {
              return const Text('No projects available');
            }
            return LayoutBuilder(
              builder: (context, constraints) {
                final width = constraints.maxWidth;
                int count = 1;
                if (width >= 1100) {
                  count = 3;
                } else if (width >= 700) {
                  count = 2;
                }
                return GridView.builder(
                  itemCount: provider.projects.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: count,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 1.2,
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
                    return _ProjectCard(
                      imagePath: img.isNotEmpty
                          ? img
                          : 'assets/Image Wrap (1).png',
                      title: title,
                      tag: tag,
                      price: '₹$priceStr',
                    );
                  },
                );
              },
            );
          },
        ),
        const SizedBox(height: 16),
        Center(
          child: OutlinedButton(
            onPressed: () {},
            child: const Text('Explore Courses'),
          ),
        ),
      ],
    );
  }
}

class _DiscoverSection extends StatelessWidget {
  final ThemeData theme;
  const _DiscoverSection({required this.theme});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Discover, Enroll & Learn', style: theme.textTheme.headlineMedium),
        const SizedBox(height: 16),
        Wrap(
          spacing: 24,
          runSpacing: 24,
          children: const [
            _StepCard(
              icon: Icons.explore,
              title: 'Explore all courses',
              desc: 'Choose from a wide range of curated topics.',
            ),
            _StepCard(
              icon: Icons.shopping_bag_outlined,
              title: 'Purchase Desired Course',
              desc: 'Secure checkout and instant access.',
            ),
            _StepCard(
              icon: Icons.history_toggle_off,
              title: 'Start Learning Anytime',
              desc: 'Lifetime access and updates.',
            ),
          ],
        ),
      ],
    );
  }
}

class _ConsistentGrowthSection extends StatelessWidget {
  final ThemeData theme;
  const _ConsistentGrowthSection({required this.theme});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 900;
        final image = ClipRRect(
          borderRadius: BorderRadius.circular(32),
          child: Image.asset(
            'assets/Feature Image → Feature Image.png',
            fit: BoxFit.cover,
          ),
        );
        final text = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Consistent Growth,\nEndless Possibilities',
              style: theme.textTheme.headlineLarge?.copyWith(
                fontWeight: FontWeight.w700,
                color: const Color(0xFF0F2A46),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Learn by doing, present confidently, and showcase your skills.',
              style: theme.textTheme.bodyLarge,
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 24,
              runSpacing: 12,
              children: const [
                _Bullet(label: 'Customised Projects'),
                _Bullet(label: 'Expert Makers'),
              ],
            ),
          ],
        );
        if (isWide) {
          return Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: SizedBox(width: 554.39, height: 670.48, child: image),
              ),
              const SizedBox(width: 24),
              Expanded(child: text),
            ],
          );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 220, child: image),
            const SizedBox(height: 16),
            text,
          ],
        );
      },
    );
  }
}

class _ProjectsGallerySection extends StatelessWidget {
  final ThemeData theme;
  const _ProjectsGallerySection({required this.theme});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,

      children: [
        SizedBox(height: 20),
        Center(
          child: Text(
            'Our Projects Gallery',
            textAlign: TextAlign.center,
            style: theme.textTheme.headlineLarge?.copyWith(
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1E6FE6),
            ),
          ),
        ),
        Consumer<ProjectProvider>(
          builder: (context, provider, _) {
            final items = provider.gallery;
            String urlAt(int idx) {
              if (idx < 0 || idx >= items.length) return '';
              final m = items[idx];
              if (m is Map && m['image'] != null) {
                return m['image'].toString().replaceAll('`', '').trim();
              }
              return '';
            }

            return LayoutBuilder(
              builder: (context, constraints) {
                final isWide = constraints.maxWidth >= 1100;
                if (isWide) {
                  Widget galleryImg(String assetPath, int idx) {
                    final u = urlAt(idx);
                    final w = u.isNotEmpty
                        ? Image.network(u, fit: BoxFit.cover)
                        : Image.asset(assetPath, fit: BoxFit.cover);
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: w,
                    );
                  }

                  return Center(
                    child: SizedBox(
                      width: 1320,
                      height: 820,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Positioned(
                            left: 26,
                            top: 163,
                            child: SizedBox(
                              width: 623,
                              height: 200,
                              child: galleryImg(
                                'assets/unsplash_XtUd5SiX464.png',
                                0,
                              ),
                            ),
                          ),
                          Positioned(
                            left: 672,
                            top: 163,
                            child: SizedBox(
                              width: 300,
                              height: 200,
                              child: galleryImg(
                                'assets/unsplash_x2Tmfd1-SgA.png',
                                1,
                              ),
                            ),
                          ),
                          Positioned(
                            left: 995,
                            top: 163,
                            child: SizedBox(
                              width: 300,
                              height: 200,
                              child: galleryImg(
                                'assets/unsplash_VieM9BdZKFo.png',
                                2,
                              ),
                            ),
                          ),
                          Positioned(
                            left: 26,
                            top: 387,
                            child: SizedBox(
                              width: 300,
                              height: 200,
                              child: galleryImg(
                                'assets/unsplash_pxoZSTdAzeU.png',
                                3,
                              ),
                            ),
                          ),
                          Positioned(
                            left: 26,
                            top: 598,
                            child: SizedBox(
                              width: 300,
                              height: 200,
                              child: galleryImg(
                                'assets/unsplash_CBh4D3l0EwM.png',
                                4,
                              ),
                            ),
                          ),
                          Positioned(
                            left: 349,
                            top: 387,
                            child: SizedBox(
                              width: 300,
                              height: 421,
                              child: galleryImg(
                                'assets/unsplash_d2zvqp3fpro.png',
                                5,
                              ),
                            ),
                          ),
                          Positioned(
                            left: 672,
                            top: 387,
                            child: SizedBox(
                              width: 623,
                              height: 200,
                              child: galleryImg(
                                'assets/unsplash_9IcKPSQ9G5Q.png',
                                6,
                              ),
                            ),
                          ),
                          Positioned(
                            left: 672,
                            top: 611,
                            child: SizedBox(
                              width: 300,
                              height: 200,
                              child: galleryImg(
                                'assets/unsplash_nDd3dIkkOLo.png',
                                7,
                              ),
                            ),
                          ),
                          Positioned(
                            left: 995,
                            top: 611,
                            child: SizedBox(
                              width: 300,
                              height: 200,
                              child: galleryImg(
                                'assets/unsplash_9Z1KRIfpBTM.png',
                                8,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                // Narrow layout: keep original simple grid look
                int count = constraints.maxWidth >= 700 ? 2 : 2;
                final defaults = [
                  'assets/unsplash_VieM9BdZKFo.png',
                  'assets/unsplash_pxoZSTdAzeU.png',
                  'assets/unsplash_x2Tmfd1-SgA.png',
                  'assets/unsplash_9Z1KRIfpBTM.png',
                  'assets/unsplash_nDd3dIkkOLo.png',
                  'assets/unsplash_9IcKPSQ9G5Q.png',
                ];
                return GridView.count(
                  crossAxisCount: count,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 1.3,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: List.generate(defaults.length, (i) {
                    final u = urlAt(i);
                    final w = u.isNotEmpty
                        ? Image.network(u, fit: BoxFit.cover)
                        : Image.asset(defaults[i], fit: BoxFit.cover);
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: w,
                    );
                  }),
                );
              },
            );
          },
        ),
        const SizedBox(height: 16),
        Center(
          child: ElevatedButton.icon(
            onPressed: () {
              Navigator.of(context).pushNamed('/gallery');
            },
            icon: const Icon(Icons.arrow_forward, size: 18),
            label: const Text('Explore More'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1E6FE6),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: const StadiumBorder(),
            ),
          ),
        ),
      ],
    );
  }
}

class _LowerBandSection extends StatelessWidget {
  final ThemeData theme;
  const _LowerBandSection({required this.theme});

  @override
  Widget build(BuildContext context) {
    final testimonials = const [
      _TestimonialCard(
        name: 'Student A',
        text: 'Great guidance and practical steps.',
      ),
      _TestimonialCard(
        name: 'Student B',
        text: 'Helped me present with confidence.',
      ),
      _TestimonialCard(
        name: 'Student C',
        text: 'Projects that boosted my portfolio.',
      ),
    ];
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFE3EBF5),
            Color(0xFF3B65A8),
            Color(0xFF092F6D),
            Color(0xFF010C1E),
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 16),
        child: Column(
          children: [
            Text(
              'What our students says.',
              textAlign: TextAlign.center,
              style: theme.textTheme.headlineLarge?.copyWith(
                fontWeight: FontWeight.w700,
                color: const Color(0xFF0F2A46),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'At Edux, our courses are meticulously curated and delivered by a network of highly skilled trainers who are experts in their respective fields. Each trainer at Edux.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: const Color(0xFF3B65A8),
              ),
            ),
            const SizedBox(height: 24),
            LayoutBuilder(
              builder: (context, constraints) {
                final width = constraints.maxWidth;
                int count = 1;
                if (width >= 1100) {
                  count = 3;
                } else if (width >= 700) {
                  count = 2;
                }
                return GridView.count(
                  crossAxisCount: count,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 2.2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: testimonials,
                );
              },
            ),
            const SizedBox(height: 40),
            Text(
              'Ready to Build Something Amazing?',
              textAlign: TextAlign.center,
              style: theme.textTheme.headlineLarge?.copyWith(
                fontWeight: FontWeight.w700,
                color: Colors.white.withValues(alpha: 0.92),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Join thousands of students and companies who trust us for their tech solutions. Get started today with our expert team.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              alignment: WrapAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1A699B),
                    foregroundColor: Colors.white,
                    shape: const StadiumBorder(),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                  ),
                  child: const Text('Request Custom Project'),
                ),
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Colors.white70),
                    shape: const StadiumBorder(),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                  ),
                  child: const Text('Schedule Consultation'),
                ),
              ],
            ),
            const SizedBox(height: 40),
            const Text(
              'IGNITE PROJECTS',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 16,
              children: const [
                _FooterLink(label: 'Home'),
                _FooterLink(label: 'Projects'),
                _FooterLink(label: 'About'),
                _FooterLink(label: 'Products'),
                _FooterLink(label: 'Contact'),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              '© 2025 Ignite Projects. All rights reserved.',
              style: TextStyle(color: Colors.white70),
            ),
          ],
        ),
      ),
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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
              child: imageWidget,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
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
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(title, style: Theme.of(context).textTheme.bodyLarge),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StepCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String desc;
  const _StepCard({
    required this.icon,
    required this.title,
    required this.desc,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 320,
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: const Color(0xFF1E6FE6), size: 28),
              const SizedBox(height: 12),
              Text(title, style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              Text(desc),
            ],
          ),
        ),
      ),
    );
  }
}

class _Bullet extends StatelessWidget {
  final String label;
  const _Bullet({required this.label});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.check_circle_outline, color: Color(0xFF1E6FE6)),
        const SizedBox(width: 8),
        Text(label),
      ],
    );
  }
}

class _FooterLink extends StatelessWidget {
  final String label;
  const _FooterLink({required this.label});
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: Text(label, style: const TextStyle(color: Colors.white)),
    );
  }
}

class _StatChip extends StatelessWidget {
  final String label;
  const _StatChip({required this.label});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFE6F0FF),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Text(label, style: const TextStyle(color: Color(0xFF1E6FE6))),
    );
  }
}

class _TestimonialCard extends StatelessWidget {
  final String name;
  final String text;
  const _TestimonialCard({required this.name, required this.text});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: const AssetImage(
                    'assets/unsplash_nDd3dIkkOLo.png',
                  ),
                ),
                const SizedBox(width: 12),
                Text(name, style: Theme.of(context).textTheme.titleMedium),
              ],
            ),
            const SizedBox(height: 12),
            Text(text),
          ],
        ),
      ),
    );
  }
}
