import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/vocabulary_provider.dart';
import '../providers/auth_provider.dart';
import 'login_screen.dart';

class VocabularyShow extends StatefulWidget {
  const VocabularyShow({super.key});

  @override
  State<VocabularyShow> createState() => _VocabularyShowState();
}

class _VocabularyShowState extends State<VocabularyShow> {

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<VocabularyProvider>().loadVocabularies();
    });
  }

  Future<void> _logout() async {
    await context.read<AuthProvider>().signOut();

    if (!mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
          (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Vocabulary",
          style: TextStyle(color: Colors.indigo),
        ),
        centerTitle: true,
        backgroundColor: Colors.black12,

        // 🔴 زر تسجيل الخروج
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
          )
        ],
      ),

      body: Consumer<VocabularyProvider>(
        builder: (context, provider, _) {

          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.vocabularies.isEmpty) {
            return const Center(child: Text("No data"));
          }

          return ListView.builder(
            itemCount: provider.vocabularies.length,
            itemBuilder: (context, index) {
              final vocab = provider.vocabularies[index];

              return ListTile(
                title: Text("Arabic: ${vocab.arabic}"),
                subtitle: Text("Chinese: ${vocab.chinese}"),
              );
            },
          );
        },
      ),
    );
  }
}