import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/chapter.dart';
import '../providers/chapter_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/neon_card.dart';
import 'reader_screen.dart';

/// Home/Library screen showing list of available chapters
class LibraryScreen extends ConsumerStatefulWidget {
  const LibraryScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends ConsumerState<LibraryScreen>
    with SingleTickerProviderStateMixin {
  String _selectedCategory = 'All';
  late AnimationController _headerController;
  late Animation<double> _headerAnimation;

  @override
  void initState() {
    super.initState();
    _headerController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _headerAnimation = CurvedAnimation(
      parent: _headerController,
      curve: Curves.easeOut,
    );
    _headerController.forward();
  }

  @override
  void dispose() {
    _headerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final categories = ref.watch(categoriesProvider);
    final chapters = ref.watch(chaptersByCategoryProvider(_selectedCategory));

    return Scaffold(
      backgroundColor: SynthwaveColors.deepPurple,
      body: CustomScrollView(
        slivers: [
          // Animated header
          SliverToBoxAdapter(
            child: FadeTransition(
              opacity: _headerAnimation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, -0.5),
                  end: Offset.zero,
                ).animate(_headerAnimation),
                child: Container(
                  padding: const EdgeInsets.fromLTRB(24, 60, 24, 24),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        SynthwaveColors.darkPurple,
                        SynthwaveColors.deepPurple,
                      ],
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Text(
                        'LEXICON',
                        style: theme.textTheme.displayLarge?.copyWith(
                          shadows: AppTheme.neonTextShadow(
                            color: SynthwaveColors.neonPink,
                            blurRadius: 15,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Your Cyberpunk Reading Library',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: SynthwaveColors.neonCyan,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Stats
                      _buildStatsRow(chapters.length),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Category filters
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'CATEGORIES',
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: SynthwaveColors.electricPurple,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildCategoryFilters(categories),
                ],
              ),
            ),
          ),

          // Chapter count
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: Text(
                '${chapters.length} ${chapters.length == 1 ? 'Chapter' : 'Chapters'}',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: SynthwaveColors.textSecondary,
                ),
              ),
            ),
          ),

          // Chapter list
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final chapter = chapters[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: _buildChapterItem(context, chapter, index),
                  );
                },
                childCount: chapters.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsRow(int chapterCount) {
    return Row(
      children: [
        _buildStatCard(
          icon: Icons.library_books,
          label: 'Chapters',
          value: chapterCount.toString(),
          color: SynthwaveColors.neonPink,
        ),
        const SizedBox(width: 12),
        _buildStatCard(
          icon: Icons.auto_stories,
          label: 'Reading',
          value: '0',
          color: SynthwaveColors.neonCyan,
        ),
        const SizedBox(width: 12),
        _buildStatCard(
          icon: Icons.bookmark,
          label: 'Saved',
          value: '0',
          color: SynthwaveColors.electricPurple,
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: SynthwaveColors.darkPurple,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: color.withOpacity(0.3),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.2),
              blurRadius: 10,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 6),
            Text(
              value,
              style: TextStyle(
                color: color,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                color: SynthwaveColors.textSecondary,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryFilters(List<String> categories) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: categories.map((category) {
          final isSelected = category == _selectedCategory;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: _CategoryChip(
              label: category,
              isSelected: isSelected,
              onTap: () {
                setState(() {
                  _selectedCategory = category;
                });
              },
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildChapterItem(BuildContext context, Chapter chapter, int index) {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 300 + (index * 100)),
      tween: Tween(begin: 0.0, end: 1.0),
      curve: Curves.easeOut,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 50 * (1 - value)),
            child: child,
          ),
        );
      },
      child: ChapterCard(
        title: chapter.title,
        author: chapter.author,
        category: chapter.category,
        readingTime: chapter.readingTimeEstimate,
        publishedDate: chapter.formattedDate,
        isLocked: chapter.isLocked,
        onTap: () {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  ReaderScreen(chapterId: chapter.id),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                const begin = Offset(1.0, 0.0);
                const end = Offset.zero;
                const curve = Curves.easeInOut;
                var tween = Tween(begin: begin, end: end).chain(
                  CurveTween(curve: curve),
                );
                var offsetAnimation = animation.drive(tween);
                return SlideTransition(
                  position: offsetAnimation,
                  child: FadeTransition(
                    opacity: animation,
                    child: child,
                  ),
                );
              },
              transitionDuration: const Duration(milliseconds: 400),
            ),
          );
        },
      ),
    );
  }
}

class _CategoryChip extends StatefulWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _CategoryChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<_CategoryChip> createState() => _CategoryChipState();
}

class _CategoryChipState extends State<_CategoryChip> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = widget.isSelected
        ? SynthwaveColors.neonPink
        : SynthwaveColors.textDimmed;

    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) => _controller.reverse(),
      onTapCancel: () => _controller.reverse(),
      onTap: widget.onTap,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: child,
          );
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: widget.isSelected
                ? color.withOpacity(0.15)
                : SynthwaveColors.darkPurple,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: color.withOpacity(widget.isSelected ? 0.5 : 0.2),
              width: widget.isSelected ? 2 : 1,
            ),
            boxShadow: widget.isSelected
                ? [
                    BoxShadow(
                      color: color.withOpacity(0.3),
                      blurRadius: 12,
                      spreadRadius: 2,
                    ),
                  ]
                : null,
          ),
          child: Text(
            widget.label,
            style: TextStyle(
              color: color,
              fontSize: 14,
              fontWeight: widget.isSelected ? FontWeight.bold : FontWeight.w500,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ),
    );
  }
}
