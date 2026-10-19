import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:senada/main.dart';

void main() {
  testWidgets('opens on the Senada welcome screen with its launcher icon', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Senada'), findsOneWidget);
    expect(find.text('Cari · Putar · Resapi'), findsNothing);

    final image = tester.widget<Image>(find.byType(Image));
    expect(image.image, isA<AssetImage>());
    expect(
      (image.image as AssetImage).assetName,
      'assets/icons/senada_icon.png',
    );

    // The welcome screen remains visible; it is not a timed splash screen.
    await tester.pump(const Duration(seconds: 5));
    expect(find.text('Senada'), findsOneWidget);
  });
}
