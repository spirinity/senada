import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:senada/screens/library_screen.dart';
import 'package:senada/theme/theme.dart';
import 'package:senada/widgets/library_search_bar.dart';

void main() {
  testWidgets('LibraryScreen renders overview with mainstream album assets', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.darkTheme,
        home: const LibraryScreen(),
      ),
    );

    // Only top title has "Library" (bottom navbar removed)
    expect(find.text('Library'), findsOneWidget);
    expect(find.text('Your playlist'), findsOneWidget);
    expect(find.text('You recently viewed'), findsNothing);
    expect(find.text('Favorite Artists'), findsNothing);

    // Search bar is present
    expect(find.byType(LibrarySearchBar), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);

    // Verify playlist cards are visible with dark text
    expect(find.text('Global Pop & R&B Anthems'), findsOneWidget);
    expect(find.text('Modern Rap & Soul Classics'), findsOneWidget);

    final titleText = tester.widget<Text>(find.text('Global Pop & R&B Anthems'));
    expect(titleText.style?.color, const Color(0xFF0F172A));

    final subtitleText = tester.widget<Text>(find.text('36 Tracks • 2 hr 15 min'));
    expect(subtitleText.style?.color, const Color(0xFF475569));

    // Bottom navigation bar items should NOT exist
    expect(find.text('Home'), findsNothing);
    expect(find.text('Profiles'), findsNothing);
    expect(find.text('Account'), findsNothing);

    // Type query into search bar for mainstream artist 'Taylor'
    await tester.enterText(find.byType(TextField), 'Taylor');
    await tester.pumpAndSettle();

    // Now only matching playlist is shown
    expect(find.text('Global Pop & R&B Anthems'), findsOneWidget);
    expect(find.text('Modern Rap & Soul Classics'), findsNothing);

    // Clear search bar
    await tester.tap(find.byIcon(Icons.close_rounded));
    await tester.pumpAndSettle();

    // Both playlists restored
    expect(find.text('Global Pop & R&B Anthems'), findsOneWidget);
    expect(find.text('Modern Rap & Soul Classics'), findsOneWidget);

    // Toggle view to Stacked Deck
    await tester.tap(find.byIcon(Icons.view_carousel_outlined));
    await tester.pumpAndSettle();

    // In Stacked Deck view
    expect(find.text('Explore Playlist'), findsOneWidget);

    // Tap Explore Playlist to open track sheet
    await tester.tap(find.text('Explore Playlist'));
    await tester.pumpAndSettle();

    // Track sheet visible
    expect(find.byIcon(Icons.play_circle_fill_rounded), findsOneWidget);
  });
}
