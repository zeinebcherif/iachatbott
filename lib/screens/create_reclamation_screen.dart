import 'package:flutter/material.dart';
import '../widgets/reclamation_form.dart';

class CreateReclamationScreen extends StatelessWidget {
  final String? initialTitre;
  final String? initialDescription;

  const CreateReclamationScreen({
    Key? key,
    this.initialTitre,
    this.initialDescription,
  }) : super(key: key);

  void _onSubmit(BuildContext context, String titre, String description) {
    Navigator.pop(context, {
      'titre': titre,
      'description': description,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(initialTitre == null ? "Nouvelle Réclamation" : "Modifier Réclamation"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ReclamationForm(
          onSubmit: (titre, description) => _onSubmit(context, titre, description),
          initialTitre: initialTitre,
          initialDescription: initialDescription,
        ),
      ),
    );
  }
}