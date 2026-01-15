import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// A card with neon glow effects
class NeonCard extends StatefulWidget {
  final Widget child;
  final Color glowColor;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;
  final bool enableHoverEffect;

  const NeonCard({
    Key? key,
    required this.child,
    this.glowColor = SynthwaveColors.neonPink,
    this.onTap,
    this.padding,
    this.borderRadius = 16,
    this.enableHoverEffect = true,
  }) : super(key: key);

  @override
  State<NeonCard> createState() => _NeonCardState();
}

class _NeonCardState extends State<NeonCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _glowAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _glowAnimation = Tween<double>(begin: 1.0, end: 1.5).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleHover(bool isHovered) {
    if (!widget.enableHoverEffect) return;

    setState(() {
      _isHovered = isHovered;
    });

    if (isHovered) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _handleHover(true),
      onExit: (_) => _handleHover(false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedBuilder(
          animation: _glowAnimation,
          builder: (context, child) {
            return Container(
              padding: widget.padding ?? const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: SynthwaveColors.darkPurple,
                borderRadius: BorderRadius.circular(widget.borderRadius),
                border: Border.all(
                  color: widget.glowColor.withOpacity(_isHovered ? 0.6 : 0.3),
                  width: _isHovered ? 2 : 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: widget.glowColor.withOpacity(0.2 * _glowAnimation.value),
                    blurRadius: 20 * _glowAnimation.value,
                    spreadRadius: 2 * _glowAnimation.value,
                  ),
                  if (_isHovered)
                    BoxShadow(
                      color: widget.glowColor.withOpacity(0.1),
                      blurRadius: 30,
                      spreadRadius: 5,
                    ),
                ],
              ),
              child: widget.child,
            );
          },
        ),
      ),
    );
  }
}

/// A card specifically for displaying chapter information
class ChapterCard extends StatelessWidget {
  final String title;
  final String author;
  final String category;
  final String readingTime;
  final String publishedDate;
  final bool isLocked;
  final VoidCallback? onTap;

  const ChapterCard({
    Key? key,
    required this.title,
    required this.author,
    required this.category,
    required this.readingTime,
    required this.publishedDate,
    this.isLocked = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return NeonCard(
      glowColor: isLocked ? SynthwaveColors.textDimmed : SynthwaveColors.electricPurple,
      onTap: isLocked ? null : onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: theme.textTheme.headlineMedium?.copyWith(
                    color: isLocked
                        ? SynthwaveColors.textDimmed
                        : SynthwaveColors.neonPink,
                    shadows: isLocked ? null : AppTheme.neonTextShadow(
                      color: SynthwaveColors.neonPink,
                      blurRadius: 8,
                    ),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (isLocked) ...[
                const SizedBox(width: 8),
                Icon(
                  Icons.lock,
                  color: SynthwaveColors.textDimmed,
                  size: 20,
                ),
              ],
            ],
          ),
          const SizedBox(height: 12),

          // Author
          Row(
            children: [
              Icon(
                Icons.person_outline,
                size: 16,
                color: SynthwaveColors.neonCyan,
              ),
              const SizedBox(width: 6),
              Text(
                author,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: SynthwaveColors.neonCyan,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Category and reading time
          Wrap(
            spacing: 12,
            runSpacing: 8,
            children: [
              _InfoChip(
                icon: Icons.category_outlined,
                label: category,
                color: SynthwaveColors.electricPurple,
              ),
              _InfoChip(
                icon: Icons.access_time,
                label: readingTime,
                color: SynthwaveColors.neonPink,
              ),
              _InfoChip(
                icon: Icons.calendar_today,
                label: publishedDate,
                color: SynthwaveColors.neonCyan,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _InfoChip({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
