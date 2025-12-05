## 0.1.0

**Breaking Changes:**

- Separated `AvatarShape` and `GroupAvatarLayout` enums for better API design
- `AvatarShape.stack` is now `GroupAvatarLayout.stack`
- Migration: Change `shape: AvatarShape.stack` to `layout: GroupAvatarLayout.stack`

**New Features:**

- Added `GroupAvatarLayout` enum (auto, stack) for layout control
- Added `overlapRatio` parameter (0.0 to 1.0) for customizable stack overlap
- Added `stackDirection` parameter (Axis.horizontal, Axis.vertical) for vertical stacking
- All shapes (circle, square, roundedSquare) now work with stack layout
- Improved documentation with comprehensive parameter descriptions

**Improvements:**

- Fixed stack layout counter position (no longer overlaps last avatar)
- Better separation of concerns between shape and layout
- More flexible and intuitive API

## 0.0.3

- Fix screenshot URLs to use GitHub raw URLs for proper display on pub.dev
- Remove unnecessary screenshot files (reduced package size by 45%)

## 0.0.2

- Fix screenshot display on pub.dev by converting HTML to markdown format

## 0.0.1

- Initial release
- Support for adaptive group avatar layouts:
  - Single avatar (1 member)
  - Two avatars with diagonal overlap (2 members)
  - Three avatars in triangular pattern (3 members)
  - Four or more avatars in 2x2 grid (4+ members)
  - Stack layout (horizontal overlapping)
- Multiple avatar shapes: circle, square, rounded square, stack
- Counter badge support (+N) for remaining members
- Gesture callbacks: onTap, onLongPress, onAvatarTap
- Customizable size, border color, border width
- Placeholder support for missing or failed images
- Theme-aware design
- Cached network image support
- maxVisible parameter to control number of displayed avatars
