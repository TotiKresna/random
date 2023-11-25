import 'file:///zapp/project/supabase/show_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class InputView extends StatefulWidget {
  const InputView({super.key});
  @override
  State<InputView> createState() => _InputViewState();
}
class _InputViewState extends State<InputView> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crud'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  vertical: 25.0,
                  horizontal: 10.0,
                ),
                filled: true,
                hintText: "Name",
              ),
            ),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  vertical: 25.0,
                  horizontal: 10.0,
                ),
                filled: true,
                hintText: "Email",
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            CupertinoButton(
              padding: EdgeInsets.zero,
              child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(37),
                ),
                child: const Text(
                  "Submit",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              onPressed: () async {
                final name = _nameController.text;
                final email = _emailController.text;
                await Supabase.instance.client
                    .from('customers')
                    .insert({'name': name, 'email': email});
                _nameController.clear();
                _emailController.clear();
              },
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ShowView()),
                );
              },
              child: const Text("Show Data"),
            ),
          ],
        ),
      ),
    );
  }
}