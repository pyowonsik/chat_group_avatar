import 'package:flutter/material.dart';
import 'package:chat_group_avatar/group_avatar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Group Avatar Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const GroupAvatarExamplePage(),
    );
  }
}

class GroupAvatarExamplePage extends StatefulWidget {
  const GroupAvatarExamplePage({super.key});

  @override
  State<GroupAvatarExamplePage> createState() => _GroupAvatarExamplePageState();
}

class _GroupAvatarExamplePageState extends State<GroupAvatarExamplePage> {
  // Sample image URLs (using placeholder service)
  static const List<String> sampleImages = [
    'https://i.pravatar.cc/150?img=1',
    'https://i.pravatar.cc/150?img=2',
    'https://i.pravatar.cc/150?img=3',
    'https://i.pravatar.cc/150?img=4',
    'https://i.pravatar.cc/150?img=5',
    'https://i.pravatar.cc/150?img=6',
    'https://i.pravatar.cc/150?img=7',
    'https://i.pravatar.cc/150?img=8',
    'https://i.pravatar.cc/150?img=9',
    'https://i.pravatar.cc/150?img=10',
  ];

  void _showModal(String title, String message, {String? url}) {
    if (mounted) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(message),
                  if (url != null) ...[
                    const SizedBox(height: 16),
                    const Text(
                      'URL:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      width: double.infinity,
                      child: SelectableText(
                        url,
                        style: const TextStyle(
                          fontSize: 12,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Group Avatar Examples'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSection(
            context,
            title: 'Single Avatar (1 member)',
            child: GroupAvatar(
              imageUrls: [sampleImages[0]],
              size: 138,
            ),
          ),
          const SizedBox(height: 32),
          _buildSection(
            context,
            title: 'Two Avatars (2 members)',
            subtitle: 'Diagonal overlap layout',
            child: GroupAvatar(
              imageUrls: sampleImages.take(2).toList(),
              size: 138,
            ),
          ),
          const SizedBox(height: 32),
          _buildSection(
            context,
            title: 'Three Avatars (3 members)',
            subtitle: 'Triangular layout',
            child: GroupAvatar(
              imageUrls: sampleImages.take(3).toList(),
              size: 138,
            ),
          ),
          const SizedBox(height: 32),
          _buildSection(
            context,
            title: 'Four Avatars (4 members)',
            subtitle: '2x2 grid layout',
            child: GroupAvatar(
              imageUrls: sampleImages.take(4).toList(),
              size: 138,
            ),
      ),
          const SizedBox(height: 32),
          _buildSection(
            context,
            title: 'Counter Badge (+N)',
            subtitle: '10 members, show 3 + counter',
            child: const GroupAvatar(
              imageUrls: sampleImages,
              size: 138,
              maxVisible: 3,
              showCounter: true,
            ),
          ),
          const SizedBox(height: 32),
          _buildSection(
            context,
            title: 'Stack Layout',
            subtitle: 'Horizontal overlapping layout',
            child: GroupAvatar(
              imageUrls: sampleImages.take(5).toList(),
              size: 138,
              layout: GroupAvatarLayout.stack,
            ),
          ),
          const SizedBox(height: 32),
          _buildSection(
            context,
            title: 'Stack with Counter',
            subtitle: 'Stack layout with counter badge',
            child: const GroupAvatar(
              imageUrls: sampleImages,
              size: 138,
              layout: GroupAvatarLayout.stack,
              maxVisible: 4,
              showCounter: true,
            ),
          ),
          const SizedBox(height: 32),
          _buildSection(
            context,
            title: 'Square Shape - 2 members',
            subtitle: 'Square avatars with 2 members',
            child: GroupAvatar(
              imageUrls: sampleImages.take(2).toList(),
              size: 138,
              shape: AvatarShape.square,
            ),
          ),
          const SizedBox(height: 32),
          _buildSection(
            context,
            title: 'Square Shape - 3 members',
            subtitle: 'Square avatars with 3 members',
            child: GroupAvatar(
              imageUrls: sampleImages.take(3).toList(),
              size: 138,
              shape: AvatarShape.square,
            ),
          ),
          const SizedBox(height: 32),
          _buildSection(
            context,
            title: 'Square Shape - 4 members',
            subtitle: 'Square avatars with 4 members',
            child: GroupAvatar(
              imageUrls: sampleImages.take(4).toList(),
              size: 138,
              shape: AvatarShape.square,
            ),
          ),
          const SizedBox(height: 32),
          _buildSection(
            context,
            title: 'Rounded Square - 2 members',
            subtitle: 'Rounded square avatars with 2 members',
            child: GroupAvatar(
              imageUrls: sampleImages.take(2).toList(),
              size: 138,
              shape: AvatarShape.roundedSquare,
            ),
          ),
          const SizedBox(height: 32),
          _buildSection(
            context,
            title: 'Rounded Square - 3 members',
            subtitle: 'Rounded square avatars with 3 members',
            child: GroupAvatar(
              imageUrls: sampleImages.take(3).toList(),
              size: 138,
              shape: AvatarShape.roundedSquare,
            ),
          ),
          const SizedBox(height: 32),
          _buildSection(
            context,
            title: 'Rounded Square - 4 members',
            subtitle: 'Rounded square avatars with 4 members',
            child: GroupAvatar(
              imageUrls: sampleImages.take(4).toList(),
              size: 138,
              shape: AvatarShape.roundedSquare,
            ),
          ),
          const SizedBox(height: 32),
          _buildSection(
            context,
            title: 'Gesture Events',
            subtitle: 'Tap, long press, and individual avatar tap',
            child: GroupAvatar(
              imageUrls: sampleImages.take(3).toList(),
              size: 138,
              onTap: () =>
                  _showModal('Group Tapped', 'Group avatar was tapped!'),
              onLongPress: () => _showModal(
                  'Group Long Pressed', 'Group avatar was long pressed!'),
              onAvatarTap: (index, url) {
                _showModal(
                  'Avatar Tapped',
                  'Avatar $index was tapped!',
                  url: url,
                );
              },
            ),
          ),
          const SizedBox(height: 32),
          _buildSection(
            context,
            title: 'Custom Border',
            subtitle: 'Blue border, width 4.0',
            child: GroupAvatar(
              imageUrls: sampleImages.take(3).toList(),
              size: 138,
              borderColor: Colors.blue,
              borderWidth: 4.0,
            ),
          ),
          const SizedBox(height: 32),
          _buildSection(
            context,
            title: 'Custom Counter Style',
            subtitle: 'Custom counter background and text color',
            child: const GroupAvatar(
              imageUrls: sampleImages,
              size: 138,
              maxVisible: 3,
              showCounter: true,
              counterBackgroundColor: Colors.purple,
              counterStyle: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 32),
          _buildSection(
            context,
            title: 'Custom Placeholder',
            subtitle: 'Custom icon for missing images',
            child: const GroupAvatar(
              imageUrls: [null, null],
              size: 138,
              placeholderIcon: Icon(
                Icons.account_circle,
                size: 50,
                color: Colors.grey,
              ),
            ),
          ),
          const SizedBox(height: 32),
          _buildSection(
            context,
            title: 'Different Sizes',
            subtitle: 'Small (80), Medium (138), Large (200)',
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GroupAvatar(
                    imageUrls: sampleImages.take(3).toList(),
                    size: 80,
            ),
                  const SizedBox(width: 16),
                  GroupAvatar(
                    imageUrls: sampleImages.take(3).toList(),
                    size: 138,
                  ),
                  const SizedBox(width: 16),
                  GroupAvatar(
                    imageUrls: sampleImages.take(3).toList(),
                    size: 200,
            ),
          ],
        ),
      ),
          ),
          const SizedBox(height: 32),
          _buildSection(
            context,
            title: 'Vertical Stack Layout',
            subtitle: 'Stack layout in vertical direction',
            child: GroupAvatar(
              imageUrls: sampleImages.take(4).toList(),
              size: 138,
              layout: GroupAvatarLayout.stack,
              stackDirection: Axis.vertical,
              showCounter: true,
            ),
          ),
          const SizedBox(height: 32),
          _buildSection(
            context,
            title: 'Custom Overlap Ratio',
            subtitle: 'Different overlap ratios (0.1, 0.3, 0.5)',
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      GroupAvatar(
                        imageUrls: sampleImages.take(4).toList(),
                        size: 100,
                        layout: GroupAvatarLayout.stack,
                        overlapRatio: 0.1,
                      ),
                      const SizedBox(height: 8),
                      const Text('0.1', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                  const SizedBox(width: 16),
                  Column(
                    children: [
                      GroupAvatar(
                        imageUrls: sampleImages.take(4).toList(),
                        size: 100,
                        layout: GroupAvatarLayout.stack,
                        overlapRatio: 0.3,
                      ),
                      const SizedBox(height: 8),
                      const Text('0.3', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                  const SizedBox(width: 16),
                  Column(
                    children: [
                      GroupAvatar(
                        imageUrls: sampleImages.take(4).toList(),
                        size: 100,
                        layout: GroupAvatarLayout.stack,
                        overlapRatio: 0.5,
                      ),
                      const SizedBox(height: 8),
                      const Text('0.5', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 32),
          _buildSection(
            context,
            title: 'Stack with Different Shapes',
            subtitle: 'Stack layout works with all shapes',
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      GroupAvatar(
                        imageUrls: sampleImages.take(3).toList(),
                        size: 100,
                        layout: GroupAvatarLayout.stack,
                        shape: AvatarShape.circle,
                      ),
                      const SizedBox(height: 8),
                      const Text('Circle', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                  const SizedBox(width: 16),
                  Column(
                    children: [
                      GroupAvatar(
                        imageUrls: sampleImages.take(3).toList(),
                        size: 100,
                        layout: GroupAvatarLayout.stack,
                        shape: AvatarShape.square,
                      ),
                      const SizedBox(height: 8),
                      const Text('Square', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                  const SizedBox(width: 16),
                  Column(
                    children: [
                      GroupAvatar(
                        imageUrls: sampleImages.take(3).toList(),
                        size: 100,
                        layout: GroupAvatarLayout.stack,
                        shape: AvatarShape.roundedSquare,
                      ),
                      const SizedBox(height: 8),
                      const Text('Rounded', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required String title,
    String? subtitle,
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.grey[600],
                ),
          ),
        ],
        const SizedBox(height: 16),
        Center(child: child),
      ],
    );
  }
}
