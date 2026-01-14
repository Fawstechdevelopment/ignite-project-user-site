import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/project_provider.dart';
import 'home_page.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({super.key});

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
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
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.topRight,
            colors: [Color(0xFFE6F6F0), Color(0xFFFDE8F3)],
            stops: [0.0, 1.0],
          ),
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1920),
            child: SingleChildScrollView(
              child: SizedBox(
                width: 1920,
                height: 1571.64,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 32,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Our Projects Gallery',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.headlineLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF1E6FE6),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Consumer<ProjectProvider>(
                        builder: (context, provider, _) {
                          final items = provider.gallery;
                          String urlAt(int idx) {
                            if (idx < 0 || idx >= items.length) return '';
                            final m = items[idx];
                            if (m is Map && m['image'] != null) {
                              return m['image']
                                  .toString()
                                  .replaceAll('`', '')
                                  .trim();
                            }
                            return '';
                          }

                          return LayoutBuilder(
                            builder: (context, constraints) {
                              final isWide = constraints.maxWidth >= 1100;
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

                              if (isWide) {
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
                              final defaults = [
                                'assets/unsplash_VieM9BdZKFo.png',
                                'assets/unsplash_pxoZSTdAzeU.png',
                                'assets/unsplash_x2Tmfd1-SgA.png',
                                'assets/unsplash_9Z1KRIfpBTM.png',
                                'assets/unsplash_nDd3dIkkOLo.png',
                                'assets/unsplash_9IcKPSQ9G5Q.png',
                              ];
                              int count = constraints.maxWidth >= 700 ? 2 : 2;
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
                                      : Image.asset(
                                          defaults[i],
                                          fit: BoxFit.cover,
                                        );
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
                      const SizedBox(height: 24),
                      Center(
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.arrow_forward, size: 18),
                          label: const Text('Explore More'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1E6FE6),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                            shape: const StadiumBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
