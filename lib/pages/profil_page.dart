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


  void _showSnackBar(String message, Color color) {
    if (!mounted) return;

    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: color,
      duration: const Duration(seconds: 3),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _signOut() async {
    final authService = ref.read(authServiceProvider);
    try {
      await authService.signOut();
      if (mounted) {
        _showSnackBar("Déconnexion réussie. À bientôt !", Colors.green);
        context.go('/login');
      }
    } catch (e) {
      if (mounted) {
        _showSnackBar("Échec de la déconnexion : $e", Colors.red);
      }
    }
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Deconnexion"),
          content: const Text("Voulez-vous vraiment vous déconnecter ?"),
          actions: <Widget>[
            TextButton(
              child: const Text("Annuler"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),

            // Bouton DÉCONNEXION
            TextButton(
              child: const Text("Déconnexion", style: TextStyle(color: Colors.red)),
              onPressed: () {
                Navigator.of(context).pop();
                _signOut();
              },
            ),
          ],
        );
      },
    );
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
                  onPressed: (){
                    _showLogoutDialog(context);
                  },
                  child: const Text("Déconnexion")
              )
            ],
          ),
        ),
      ),
    );
  }
}