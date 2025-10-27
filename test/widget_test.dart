import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:to_do_list/main.dart';

void main() {
  group('Todo List App Tests', () {
    testWidgets('App loads with initial todo list', (
      WidgetTester tester,
    ) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(MyApp());

      // Verify that the app title is displayed
      expect(find.text('To do list'), findsOneWidget);

      // Verify that the initial todo list is displayed
      expect(find.text('Todo List 1'), findsOneWidget);
    });

    testWidgets('Can add new todo list via TextField', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(MyApp());

      // Find the TextField and enter a new todo list name
      final textField = find.byType(TextField);
      expect(textField, findsOneWidget);

      await tester.enterText(textField, 'My New List');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();

      // Clear the TextField to avoid duplicate text matches
      await tester.enterText(textField, '');
      await tester.pump();

      // Verify that the new todo list appears
      expect(find.text('My New List'), findsOneWidget);
    });

    testWidgets('Shows dialog when todo list is tapped', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(MyApp());

      // Find and tap on the first todo list
      final listTile = find.text('Todo List 1');
      expect(listTile, findsOneWidget);

      await tester.tap(listTile);
      await tester.pump();

      // Verify that the dialog appears
      expect(find.text('Todo List Details'), findsOneWidget);
      expect(find.text('List Name: Todo List 1'), findsOneWidget);
      expect(find.text('Close'), findsOneWidget);
    });

    testWidgets('Can close dialog by tapping Close button', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(MyApp());

      // Open the dialog
      await tester.tap(find.text('Todo List 1'));
      await tester.pump();

      // Verify dialog is open
      expect(find.text('Todo List Details'), findsOneWidget);

      // Tap the Close button
      await tester.tap(find.text('Close'));
      await tester.pump();

      // Verify dialog is closed
      expect(find.text('Todo List Details'), findsNothing);
    });

    testWidgets('Empty todo list name is not added', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(MyApp());

      // Count initial todo lists
      final initialCount = find.byType(ListTile).evaluate().length;

      // Try to add empty todo list
      final textField = find.byType(TextField);
      await tester.enterText(textField, '   '); // Only whitespace
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();

      // Verify that no new todo list was added
      final finalCount = find.byType(ListTile).evaluate().length;
      expect(finalCount, equals(initialCount));
    });

    testWidgets('Multiple todo lists can be displayed', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(MyApp());

      // Add multiple todo lists
      final textField = find.byType(TextField);

      await tester.enterText(textField, 'Shopping List');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();

      // Clear the TextField
      await tester.enterText(textField, '');
      await tester.pump();

      await tester.enterText(textField, 'Work Tasks');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();

      // Clear the TextField
      await tester.enterText(textField, '');
      await tester.pump();

      // Verify all lists are displayed
      expect(find.text('Todo List 1'), findsOneWidget);
      expect(find.text('Shopping List'), findsOneWidget);
      expect(find.text('Work Tasks'), findsOneWidget);
    });
  });
}
