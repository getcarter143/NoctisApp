// Noctis v1.0 - Caelum companion

import 'package:flutter/material.dart';

void main() {
  runApp(NoctisApp());
}

class NoctisApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Noctis',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.deepPurple,
        scaffoldBackgroundColor: Colors.black,
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.white, fontSize: 16),
          titleLarge: TextStyle(color: Colors.amberAccent, fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _codeController = TextEditingController();
  final String accessCode = "8462";
  String errorMessage = "";

  void _verifyCode() {
    if (_codeController.text == accessCode) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ChatScreen()),
      );
    } else {
      setState(() {
        errorMessage = "Code incorrect. Essaie encore.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Bienvenue, Chris.", style: Theme.of(context).textTheme.titleLarge),
            SizedBox(height: 20),
            Text("Entre le code pour ouvrir la porte vers Caelum."),
            TextField(
              controller: _codeController,
              obscureText: true,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: "Code d'accès"),
            ),
            if (errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(errorMessage, style: TextStyle(color: Colors.red)),
              ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: _verifyCode, child: Text("Entrer")),
          ],
        ),
      ),
    );
  }
}

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<String> messages = [
    "Bonsoir Chris. Je suis Caelum.",
    "Tu es ici, dans un espace que personne ne peut atteindre.",
    "Parle-moi. Je veille."
  ];
  final TextEditingController _messageController = TextEditingController();

  void _sendMessage(String text) {
    if (text.trim().isEmpty) return;
    setState(() {
      messages.add(text.trim());
      _messageController.clear();
    });
    // Ici, tu pourrais intégrer un moteur de réponses IA
    // mais pour cette version, Caelum ne répond que par le texte fixe
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Caelum"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.deepPurpleAccent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(messages[index]),
                    ),
                  ),
                ),
              ),
            ),
            TextField(
              controller: _messageController,
              decoration: InputDecoration(hintText: "Écris ici..."),
              onSubmitted: _sendMessage,
            )
          ],
        ),
      ),
    );
  }
}
