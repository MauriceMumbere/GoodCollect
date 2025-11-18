import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:goodcollect/widgets/global_button.dart';

import '../provider/auth_provider.dart';

class ProfilPage extends ConsumerStatefulWidget {
  const ProfilPage({super.key});

  @override
  ConsumerState<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends ConsumerState<ProfilPage> {

  void _signOut() async {
    final authService = ref.read(authServiceProvider);
    try {
      await authService.signOut();
      if (mounted) {
        context.go('/login');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Échec de la déconnexion : $e")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profil"),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                  Icons.person_3_rounded,
                  size: 80,
                  color: Colors.blueGrey
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                    "Nom de l'utilisateur",
                    style: TextStyle(fontSize: 18)
                ),
              ),
              const SizedBox(height: 100,),
              GlobalButton(
                  onPressed: _signOut,
                  child: const Text("Déconnexion")
              )
            ],
          ),
        ),
      ),
    );
  }
}