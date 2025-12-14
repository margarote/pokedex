import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:pokedex/src/features/pokemon/presentation/widgets/item_card.dart';

void main() {
  const testName = 'Pikachu';
  const testNumber = 4;
  const testImageUrl = 'https://orn.com/001.png';

  Widget createWidget({VoidCallback? onTap, String? searchText}) {
    return MaterialApp(
      home: Scaffold(
        body: ItemCard(
          name: testName,
          number: testNumber,
          imageUrl: testImageUrl,
          onTap: onTap,
          searchText: searchText,
        ),
      ),
    );
  }

  group('ItemCard', () {
    testWidgets('renders pokemon name', (tester) async {
      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(createWidget());

        expect(find.text(testName), findsOneWidget);
      });
    });

    testWidgets('renders pokemon number with hash', (tester) async {
      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(createWidget());

        expect(find.text('#$testNumber'), findsOneWidget);
      });
    });

    testWidgets('renders add icon', (tester) async {
      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(createWidget());

        expect(find.byIcon(Icons.add_circle_rounded), findsOneWidget);
      });
    });

    testWidgets('calls onTap when tapped', (tester) async {
      var wasTapped = false;

      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(createWidget(onTap: () => wasTapped = true));

        await tester.tap(find.byType(ItemCard));
        await tester.pump();

        expect(wasTapped, isTrue);
      });
    });

    testWidgets('does not throw when onTap is null', (tester) async {
      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(createWidget());

        await tester.tap(find.byType(ItemCard));
        await tester.pump();

        expect(find.byType(ItemCard), findsOneWidget);
      });
    });

    testWidgets('renders with search highlight', (tester) async {
      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(createWidget(searchText: 'Bulba'));

        expect(find.text(testName), findsOneWidget);
      });
    });
  });
}
