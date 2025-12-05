import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

/// Avatar shape options
enum AvatarShape {
  /// Circular avatars
  circle,

  /// Square avatars
  square,

  /// Square avatars with rounded corners
  roundedSquare,

  /// Horizontal stack layout (overlapping from left to right)
  stack,
}

/// Group avatar that adapts layout by member count
/// - 1: single circle
/// - 2: two diagonal overlapped circles (top-right & bottom-left)
/// - 3: triangular pattern (top-center, bottom-left, bottom-right)
/// - 4+: 2x2 grid (no overlap, first 4)
/// - stack: horizontal overlapping layout
class GroupAvatar extends StatelessWidget {
  /// GroupAvatar constructor
  const GroupAvatar({
    required this.imageUrls,
    this.size = 138,
    this.borderColor,
    this.borderWidth = 2.0,
    this.placeholderIcon,
    this.backgroundColor,
    this.shape = AvatarShape.circle,
    this.maxVisible,
    this.showCounter = false,
    this.counterStyle,
    this.counterBackgroundColor,
    this.onTap,
    this.onLongPress,
    this.onAvatarTap,
    super.key,
  });

  /// Image URLs to display
  final List<String?> imageUrls;

  /// Size of the bounding box (default: 138)
  final double size;

  /// Border color (defaults to Theme's surface color)
  final Color? borderColor;

  /// Border width (default: 2.0)
  final double borderWidth;

  /// Custom placeholder icon widget
  /// If not provided, uses Icons.person
  final Widget? placeholderIcon;

  /// Background color for avatars
  /// If not provided, uses Theme's surface color
  final Color? backgroundColor;

  /// Avatar shape (default: circle)
  final AvatarShape shape;

  /// Maximum number of avatars to display
  /// If null, uses default behavior (4 for grid, all for stack)
  final int? maxVisible;

  /// Show counter badge for remaining avatars (default: false)
  final bool showCounter;

  /// Style for the counter text
  final TextStyle? counterStyle;

  /// Background color for the counter badge
  final Color? counterBackgroundColor;

  /// Callback when the group avatar is tapped
  final VoidCallback? onTap;

  /// Callback when the group avatar is long pressed
  final VoidCallback? onLongPress;

  /// Callback when an individual avatar is tapped
  /// Parameters: (index, url)
  final void Function(int index, String? url)? onAvatarTap;

  @override
  Widget build(BuildContext context) {
    Widget content;

    if (shape == AvatarShape.stack) {
      content = _stackLayout(context);
    } else {
      final count = imageUrls.length;
      final visibleCount = maxVisible ?? (count > 4 ? 4 : count);
      final visibleUrls = imageUrls.take(visibleCount).toList();
      final remainingCount = count > visibleCount ? count - visibleCount : 0;

      if (visibleUrls.isEmpty) {
        content = _buildSingleLayout(context, null);
      } else if (visibleUrls.length == 1) {
        content = _buildSingleLayout(context, visibleUrls.firstOrNull);
      } else if (visibleUrls.length == 2) {
        content = _buildDiagonalLayout(context, visibleUrls);
      } else if (visibleUrls.length == 3) {
        content = _buildTriangleLayout(context, visibleUrls);
      } else {
        content = _buildGridLayout(context, visibleUrls);
      }

      // Add counter badge if needed
      if (showCounter && remainingCount > 0) {
        content = Stack(
          clipBehavior: Clip.none,
          children: [
            content,
            Positioned(
              right: 0,
              bottom: 0,
              child: _buildCounter(context, remainingCount),
            ),
          ],
        );
      }
    }

    // Wrap with gesture detectors
    if (onTap != null || onLongPress != null) {
      content = GestureDetector(
        onTap: onTap,
        onLongPress: onLongPress,
        child: content,
      );
    }

    return content;
  }

  Widget _buildSingleLayout(BuildContext context, String? url) {
    return SizedBox(
      height: size,
      width: size,
      child: _buildAvatar(context, url, size, 0),
    );
  }

  Widget _buildDiagonalLayout(BuildContext context, List<String?> urls) {
    final bottomLeftUrl = urls.elementAtOrNull(0);
    final topRightUrl = urls.elementAtOrNull(1);
    final avatarSize = size * (90.0 / 138.0);

    return SizedBox(
      height: size,
      width: size,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            right: 0,
            top: 0,
            child: _buildAvatar(context, topRightUrl, avatarSize, 1),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: _buildAvatar(context, bottomLeftUrl, avatarSize, 0),
          ),
        ],
      ),
    );
  }

  Widget _buildTriangleLayout(BuildContext context, List<String?> urls) {
    final topUrl = urls.elementAtOrNull(0);
    final bottomLeftUrl = urls.elementAtOrNull(1);
    final bottomRightUrl = urls.elementAtOrNull(2);
    final avatarSize = size * (90.0 / 138.0);

    return SizedBox(
      height: size,
      width: size,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            child: _buildAvatar(context, bottomLeftUrl, avatarSize, 1),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: _buildAvatar(context, bottomRightUrl, avatarSize, 2),
          ),
          Positioned(
            left: (size - avatarSize) / 2,
            top: 0,
            child: _buildAvatar(context, topUrl, avatarSize, 0),
          ),
        ],
      ),
    );
  }

  Widget _buildGridLayout(BuildContext context, List<String?> urls) {
    final cellSize = size * (66.0 / 138.0);
    final gap = size - (cellSize * 2);

    return SizedBox(
      height: size,
      width: size,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: _buildAvatar(context, urls.elementAtOrNull(0), cellSize, 0),
          ),
          Positioned(
            left: cellSize + gap,
            top: 0,
            child: _buildAvatar(context, urls.elementAtOrNull(1), cellSize, 1),
          ),
          Positioned(
            left: 0,
            top: cellSize + gap,
            child: _buildAvatar(context, urls.elementAtOrNull(2), cellSize, 2),
          ),
          Positioned(
            left: cellSize + gap,
            top: cellSize + gap,
            child: _buildAvatar(context, urls.elementAtOrNull(3), cellSize, 3),
          ),
        ],
      ),
    );
  }

  Widget _stackLayout(BuildContext context) {
    final visibleCount = maxVisible ?? imageUrls.length;
    final visibleUrls = imageUrls.take(visibleCount).toList();
    final remainingCount =
        imageUrls.length > visibleCount ? imageUrls.length - visibleCount : 0;

    // Calculate avatar size and overlap
    final avatarSize = size * 0.7;
    final overlap = avatarSize * 0.3;
    final totalWidth =
        avatarSize + (visibleUrls.length - 1) * (avatarSize - overlap);

    return SizedBox(
      height: size,
      width: totalWidth > size ? size : totalWidth,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          ...visibleUrls.asMap().entries.map((entry) {
            final index = entry.key;
            final url = entry.value;
            return Positioned(
              left: index * (avatarSize - overlap),
              top: (size - avatarSize) / 2,
              child: _buildAvatar(context, url, avatarSize, index),
            );
          }),
          if (showCounter && remainingCount > 0)
            Positioned(
              left: visibleUrls.length * (avatarSize - overlap) - overlap,
              top: (size - avatarSize) / 2,
              child: _buildCounter(context, remainingCount, avatarSize),
            ),
        ],
      ),
    );
  }

  Widget _buildAvatar(
    BuildContext context,
    String? url,
    double diameter,
    int index,
  ) {
    Widget avatar;

    if (url != null && url.isNotEmpty) {
      avatar = CachedNetworkImage(
        errorWidget: (context, _, __) => _placeholder(context, diameter),
        imageBuilder: (context, provider) => Container(
          decoration: _getDecoration(context, diameter),
          height: diameter,
          width: diameter,
          child: ClipRRect(
            borderRadius: _getBorderRadius(diameter),
            child: Image(
              image: provider,
              fit: BoxFit.cover,
            ),
          ),
        ),
        imageUrl: '$url?w=${diameter.round()}',
        memCacheHeight:
            (diameter * MediaQuery.devicePixelRatioOf(context)).round(),
        memCacheWidth:
            (diameter * MediaQuery.devicePixelRatioOf(context)).round(),
      );
    } else {
      avatar = _placeholder(context, diameter);
    }

    // Wrap with gesture detector if onAvatarTap is provided
    if (onAvatarTap != null) {
      avatar = GestureDetector(
        onTap: () => onAvatarTap!(index, url),
        child: avatar,
      );
    }

    return avatar;
  }

  BoxDecoration _getDecoration(BuildContext context, double diameter) {
    final border = borderColor ?? Theme.of(context).colorScheme.surface;
    final bg = backgroundColor ?? Theme.of(context).colorScheme.surface;

    return BoxDecoration(
      border: Border.all(color: border, width: borderWidth),
      color: bg,
      borderRadius: _getBorderRadius(diameter),
    );
  }

  BorderRadius _getBorderRadius(double diameter) {
    switch (shape) {
      case AvatarShape.circle:
        return BorderRadius.circular(diameter / 2);
      case AvatarShape.square:
        return BorderRadius.zero;
      case AvatarShape.roundedSquare:
        return BorderRadius.circular(diameter * 0.2);
      case AvatarShape.stack:
        return BorderRadius.circular(diameter / 2);
    }
  }

  Widget _placeholder(BuildContext context, double diameter) {
    final border = borderColor ?? Theme.of(context).colorScheme.surface;
    final bg = backgroundColor ??
        Theme.of(context).colorScheme.surfaceContainerHighest;

    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(
          color: border,
          width: borderWidth,
        ),
        color: bg,
        borderRadius: _getBorderRadius(diameter),
      ),
      height: diameter,
      width: diameter,
      child: placeholderIcon ??
          Icon(
            Icons.person,
            size: diameter * 0.5,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
          ),
    );
  }

  Widget _buildCounter(BuildContext context, int count, [double? size]) {
    final counterSize = size ?? (this.size * 0.35);
    final textStyle = counterStyle ??
        TextStyle(
          color: Colors.white,
          fontSize: counterSize * 0.4,
          fontWeight: FontWeight.bold,
        );
    final bgColor =
        counterBackgroundColor ?? Theme.of(context).colorScheme.primary;

    return Container(
      width: counterSize,
      height: counterSize,
      decoration: BoxDecoration(
        color: bgColor,
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor ?? Theme.of(context).colorScheme.surface,
          width: borderWidth,
        ),
      ),
      alignment: Alignment.center,
      child: Text(
        '+$count',
        style: textStyle,
        textAlign: TextAlign.center,
      ),
    );
  }
}
