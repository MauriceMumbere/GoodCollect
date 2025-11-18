// lib/pages/register_page.dart

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../services/auth_services.dart';
import '../../widgets/global_button.dart';
import '../../widgets/global_input.dart';


class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();

  bool _isLoading = false;
  String? _errorMessage;

  // Nouvelle méthode pour afficher un SnackBar
  void _showSnackBar(String message, Color color) {
    if (!mounted) return; // Assurez-vous que le widget est monté

    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: color,
      duration: const Duration(seconds: 3),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _registerUser() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final email = emailController.text.trim();
    final password = passController.text;
    final name = nameController.text.trim();

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      User? user = await AuthService().registerWithEmailAndPassword(email, password);

      if (user != null) {
        await user.updateDisplayName(name);

        if (mounted) {
          _showSnackBar(
              "Inscription réussie ! Vous pouvez maintenant vous connecter.",
              Colors.green
          );
          context.go("/login");
        }
      }
    } on FirebaseAuthException catch (e) {
      String message = 'Erreur d\'inscription.';
      if (e.code == 'weak-password') {
        message = 'Le mot de passe est trop faible (6 caractères minimum).';
      } else if (e.code == 'email-already-in-use') {
        message = 'Cet email est déjà utilisé.';
      } else if (e.code == 'invalid-email') {
        message = 'Le format de l\'email est invalide.';
      } else {
        message = e.message ?? message;
      }
      setState(() {
        _errorMessage = message;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Une erreur inattendue est survenue.';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Inscription"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Créer un compte",
                style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 40),
              GlobalTextField(
                controller: nameController,
                label: "Votre nom",
                validator: (val) => val == null || val.isEmpty ? "Veuillez entrer votre nom" : null,
              ),
              const SizedBox(height: 20),
              GlobalTextField(
                controller: emailController,
                label: "Votre email",
                keyboardType: TextInputType.emailAddress,
                validator: (val) => val == null || val.isEmpty ? "Veuillez entrer votre email" : null,
              ),
              const SizedBox(height: 20),
              GlobalTextField(
                controller: passController,
                label: "Votre mot de passe",
                obscure: true,
                validator: (val) => val != null && val.length < 6
                    ? "Le mot de passe doit contenir au moins 6 caractères"
                    : null,
              ),
              const SizedBox(height: 20),

              if (_errorMessage != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Text(
                    _errorMessage!,
                    style: const TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
                  ),
                ),

              GlobalButton(
                onPressed: _isLoading ? null : _registerUser,
                child: _isLoading
                    ? const SizedBox(
                  height: 24,
                  width: 24,
                  child: CircularProgressIndicator(color: Colors.white, strokeWidth: 3),
                )
                    : const Text(
                  "S'inscrire",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
              const SizedBox(height: 40),
              Center(
                child: Text.rich(
                  TextSpan(
                    text: "Vous avez déjà un compte ? ",
                    style: const TextStyle(color: Colors.black, fontSize: 16),
                    children: [
                      TextSpan(
                        text: "Connectez-vous",
                        style: const TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            context.go("/login");
                          },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}