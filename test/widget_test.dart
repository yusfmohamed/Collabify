// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:collabify/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Collabify app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const CollabifyApp());

    // Verify that splash screen loads
    expect(find.byType(Image), findsOneWidget);
    
    // Wait for splash screen navigation
    await tester.pumpAndSettle(const Duration(seconds: 4));

    // Verify that sign in screen appears with Sign In text
    expect(find.text('Sign In'), findsOneWidget);
    expect(find.text('Username'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
  });

  testWidgets('Navigate to Sign Up screen', (WidgetTester tester) async {
    // Build our app
    await tester.pumpWidget(const CollabifyApp());
    
    // Wait for splash to finish
    await tester.pumpAndSettle(const Duration(seconds: 4));

    // Tap on Create New Account
    await tester.tap(find.text('Create New Account'));
    await tester.pumpAndSettle();

    // Verify Sign Up screen appears
    expect(find.text('Sign Up'), findsOneWidget);
    expect(find.text('Confirm Password'), findsOneWidget);
  });
}