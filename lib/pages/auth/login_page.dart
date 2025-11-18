import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../services/auth_services.dart';
import '../../widgets/global_button.dart';
import '../../widgets/global_input.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passController = TextEditingController();

  bool _isLoading = false;
  String? _errorMessage;

  void _showSnackBar(String message, Color color) {
    if (!mounted) return;

    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: color,
      duration: const Duration(seconds: 3),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _loginUser() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final email = emailController.text.trim();
    final password = passController.text;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      User? user = await AuthService().signInWithEmailAndPassword(email, password);

      if (user != null) {
        if (mounted) {
          _showSnackBar("Connexion réussie ! Bienvenue.", Colors.green);
          context.go("/home");
        }
      }
    } on FirebaseAuthException catch (e) {
      String message = 'Échec de la connexion.';
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        message = 'Identifiants invalides (email ou mot de passe incorrect).';
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
        title: const Text("Connexion"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Connectez-vous",
                style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 40),

              // Champ Email
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
                onPressed: _isLoading ? null : _loginUser,
                child: _isLoading
                    ? const SizedBox(
                  height: 24,
                  width: 24,
                  child: CircularProgressIndicator(color: Colors.white, strokeWidth: 3),
                )
                    : const Text(
                  "Se Connecter", // Texte mis à jour
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
              const SizedBox(height: 40),

              Center(
                child: Text.rich(
                  TextSpan(
                    text: "Vous n'avez pas de compte ? ",
                    style: const TextStyle(color: Colors.black, fontSize: 16),
                    children: [
                      TextSpan(
                        text: "Créez un compte",
                        style: const TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            context.go("/register");
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