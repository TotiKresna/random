import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ShowView extends StatefulWidget {
  const ShowView({super.key});
  @override
  State<ShowView> createState() => _ShowViewState();
}
class _ShowViewState extends State<ShowView> {
  final _customersStream = Supabase.instance.client.from('customers').stream(primaryKey: ['id']);
  Future<void> _deleteData(int id) async {
    await Supabase.instance.client
        .from('customers')
        .delete()
        .match({'id': id});
  }
  Future<void> _updateData(int id, String name, String email) async {
    await Supabase.instance.client.from('customers').update({
      'name': name,
      'email': email,
    }).match({'id': id});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Data",
        ),
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: _customersStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final customers = snapshot.data!;
          return ListView.builder(
            itemCount: customers.length,
            itemBuilder: (context, index) {
              final nameController = TextEditingController(text: customers[index]['name']);
              final emailController = TextEditingController(text: customers[index]['email']);
              return ListTile(
                title: Text(customers[index]['name']),
                subtitle: Text(customers[index]['email']),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () async {
                    await _deleteData(customers[index]['id']);
                  },
                ),
                onTap: () async {
                  final result = await showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Edit Data'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            controller: nameController,
                            decoration: const InputDecoration(
                              labelText: 'Name',
                            ),
                          ),
                          TextField(
                            controller: emailController,
                            decoration: const InputDecoration(
                              labelText: 'Email',
                            ),
                          ),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context, false);
                          },
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context, true);
                          },
                          child: const Text('Save'),
                        ),
                      ],
                    ),
                  );
                  if (result == true) {
                    await _updateData(
                      customers[index]['id'],
                      nameController.text,
                      emailController.text,
                    );
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}