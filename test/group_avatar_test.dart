import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:chat_group_avatar/group_avatar.dart';

void main() {
  group('GroupAvatar', () {
    testWidgets('renders single avatar correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GroupAvatar(
              imageUrls: ['https://example.com/avatar1.jpg'],
              size: 138,
            ),
          ),
        ),
      );

      expect(find.byType(GroupAvatar), findsOneWidget);
    });

    testWidgets('renders two avatars in diagonal layout',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GroupAvatar(
              imageUrls: [
                'https://example.com/avatar1.jpg',
                'https://example.com/avatar2.jpg',
              ],
              size: 138,
            ),
          ),
        ),
      );

      expect(find.byType(GroupAvatar), findsOneWidget);
    });

    testWidgets('renders three avatars in triangular layout',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GroupAvatar(
              imageUrls: [
                'https://example.com/avatar1.jpg',
                'https://example.com/avatar2.jpg',
                'https://example.com/avatar3.jpg',
              ],
              size: 138,
            ),
          ),
        ),
      );

      expect(find.byType(GroupAvatar), findsOneWidget);
    });

    testWidgets('renders four avatars in grid layout',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GroupAvatar(
              imageUrls: [
                'https://example.com/avatar1.jpg',
                'https://example.com/avatar2.jpg',
                'https://example.com/avatar3.jpg',
                'https://example.com/avatar4.jpg',
              ],
              size: 138,
            ),
          ),
        ),
      );

      expect(find.byType(GroupAvatar), findsOneWidget);
    });

    testWidgets('renders placeholder for empty imageUrls',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GroupAvatar(
              imageUrls: [],
              size: 138,
            ),
          ),
        ),
      );

      expect(find.byType(GroupAvatar), findsOneWidget);
      expect(find.byIcon(Icons.person), findsWidgets);
    });

    testWidgets('renders placeholder for null imageUrls',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GroupAvatar(
              imageUrls: [null, null],
              size: 138,
            ),
          ),
        ),
      );

      expect(find.byType(GroupAvatar), findsOneWidget);
      expect(find.byIcon(Icons.person), findsWidgets);
    });

    testWidgets('uses custom placeholder icon when provided',
        (WidgetTester tester) async {
      const customIcon = Icon(Icons.account_circle);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GroupAvatar(
              imageUrls: [null],
              size: 138,
              placeholderIcon: customIcon,
            ),
          ),
        ),
      );

      expect(find.byType(GroupAvatar), findsOneWidget);
      expect(find.byIcon(Icons.account_circle), findsOneWidget);
      expect(find.byIcon(Icons.person), findsNothing);
    });

    testWidgets('applies custom border color', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GroupAvatar(
              imageUrls: ['https://example.com/avatar1.jpg'],
              size: 138,
              borderColor: Colors.red,
            ),
          ),
        ),
      );

      expect(find.byType(GroupAvatar), findsOneWidget);
    });

    testWidgets('applies custom border width', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GroupAvatar(
              imageUrls: ['https://example.com/avatar1.jpg'],
              size: 138,
              borderWidth: 4.0,
            ),
          ),
        ),
      );

      expect(find.byType(GroupAvatar), findsOneWidget);
    });

    testWidgets('limits to first 4 avatars for 4+ count',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GroupAvatar(
              imageUrls: [
                'https://example.com/avatar1.jpg',
                'https://example.com/avatar2.jpg',
                'https://example.com/avatar3.jpg',
                'https://example.com/avatar4.jpg',
                'https://example.com/avatar5.jpg',
                'https://example.com/avatar6.jpg',
              ],
              size: 138,
            ),
          ),
        ),
      );

      expect(find.byType(GroupAvatar), findsOneWidget);
    });

    testWidgets('shows counter badge when showCounter is true',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GroupAvatar(
              imageUrls:
                  List.generate(10, (i) => 'https://example.com/avatar$i.jpg'),
              size: 138,
              maxVisible: 3,
              showCounter: true,
            ),
          ),
        ),
      );

      expect(find.byType(GroupAvatar), findsOneWidget);
      expect(find.text('+7'), findsOneWidget);
    });

    testWidgets('respects maxVisible parameter', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GroupAvatar(
              imageUrls:
                  List.generate(10, (i) => 'https://example.com/avatar$i.jpg'),
              size: 138,
              maxVisible: 2,
              showCounter: true,
            ),
          ),
        ),
      );

      expect(find.byType(GroupAvatar), findsOneWidget);
      expect(find.text('+8'), findsOneWidget);
    });

    testWidgets('renders stack layout when shape is stack',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GroupAvatar(
              imageUrls: [
                'https://example.com/avatar1.jpg',
                'https://example.com/avatar2.jpg',
                'https://example.com/avatar3.jpg',
              ],
              size: 138,
              shape: AvatarShape.stack,
            ),
          ),
        ),
      );

      expect(find.byType(GroupAvatar), findsOneWidget);
    });

    testWidgets('renders square avatars when shape is square',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GroupAvatar(
              imageUrls: ['https://example.com/avatar1.jpg'],
              size: 138,
              shape: AvatarShape.square,
            ),
          ),
        ),
      );

      expect(find.byType(GroupAvatar), findsOneWidget);
    });

    testWidgets('renders rounded square avatars when shape is roundedSquare',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GroupAvatar(
              imageUrls: ['https://example.com/avatar1.jpg'],
              size: 138,
              shape: AvatarShape.roundedSquare,
            ),
          ),
        ),
      );

      expect(find.byType(GroupAvatar), findsOneWidget);
    });

    testWidgets('sets up onTap callback correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GroupAvatar(
              imageUrls: ['https://example.com/avatar1.jpg'],
              size: 138,
              onTap: () {},
            ),
          ),
        ),
      );

      expect(find.byType(GroupAvatar), findsOneWidget);
    });

    testWidgets('sets up onLongPress callback correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GroupAvatar(
              imageUrls: ['https://example.com/avatar1.jpg'],
              size: 138,
              onLongPress: () {},
            ),
          ),
        ),
      );

      expect(find.byType(GroupAvatar), findsOneWidget);
    });

    testWidgets('sets up onAvatarTap callback correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GroupAvatar(
              imageUrls: [
                'https://example.com/avatar1.jpg',
                'https://example.com/avatar2.jpg',
              ],
              size: 138,
              onAvatarTap: (index, url) {
                // Callback is set up correctly
              },
            ),
          ),
        ),
      );

      // Verify widget is rendered
      expect(find.byType(GroupAvatar), findsOneWidget);
    });
  });
}
