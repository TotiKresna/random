import 'package:supabase/supabase.dart';
import 'file:///zapp/project/supabase/input_view.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  await Supabase.initialize(
    url: 'https://vivaqyferhyizlpqjtnv.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZpdmFxeWZlcmh5aXpscHFqdG52Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDA3NTI2NzYsImV4cCI6MjAxNjMyODY3Nn0.PxM6m8s1lhMZ-BjlibWAonbkWL_wQJ3NXwNfJ9pdF2g',
  );
  runApp(
    MaterialApp(
      title: 'Crud',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    ),
  );
}
final supabase = Supabase.instance.client;
class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return const InputView();
  }
}