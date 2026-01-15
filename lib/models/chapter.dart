/// Represents a chapter/post from Patreon
class Chapter {
  final String id;
  final String title;
  final String author;
  final String content;
  final DateTime publishedDate;
  final int wordCount;
  final String category;
  final bool isLocked;
  final String? coverImageUrl;

  const Chapter({
    required this.id,
    required this.title,
    required this.author,
    required this.content,
    required this.publishedDate,
    required this.wordCount,
    required this.category,
    this.isLocked = false,
    this.coverImageUrl,
  });

  /// Copy with method for creating modified copies
  Chapter copyWith({
    String? id,
    String? title,
    String? author,
    String? content,
    DateTime? publishedDate,
    int? wordCount,
    String? category,
    bool? isLocked,
    String? coverImageUrl,
  }) {
    return Chapter(
      id: id ?? this.id,
      title: title ?? this.title,
      author: author ?? this.author,
      content: content ?? this.content,
      publishedDate: publishedDate ?? this.publishedDate,
      wordCount: wordCount ?? this.wordCount,
      category: category ?? this.category,
      isLocked: isLocked ?? this.isLocked,
      coverImageUrl: coverImageUrl ?? this.coverImageUrl,
    );
  }

  /// Format reading time estimate
  String get readingTimeEstimate {
    final minutes = (wordCount / 200).ceil(); // Average reading speed
    if (minutes < 60) {
      return '$minutes min read';
    } else {
      final hours = (minutes / 60).floor();
      final remainingMinutes = minutes % 60;
      return '$hours hr ${remainingMinutes} min read';
    }
  }

  /// Format published date
  String get formattedDate {
    final now = DateTime.now();
    final difference = now.difference(publishedDate);

    if (difference.inDays == 0) {
      return 'Today';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays < 30) {
      final weeks = (difference.inDays / 7).floor();
      return '$weeks ${weeks == 1 ? 'week' : 'weeks'} ago';
    } else {
      final months = (difference.inDays / 30).floor();
      return '$months ${months == 1 ? 'month' : 'months'} ago';
    }
  }
}
