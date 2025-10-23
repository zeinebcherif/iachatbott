import 'package:flutter/material.dart';

class ReclamationForm extends StatefulWidget {
  final void Function(String titre, String description) onSubmit;
  final String? initialTitre;
  final String? initialDescription;

  const ReclamationForm({
    Key? key,
    required this.onSubmit,
    this.initialTitre,
    this.initialDescription,
  }) : super(key: key);

  @override
  State<ReclamationForm> createState() => _ReclamationFormState();
}

class _ReclamationFormState extends State<ReclamationForm> {
  final _formKey = GlobalKey<FormState>();
  late String titre;
  late String description;

  @override
  void initState() {
    super.initState();
    titre = widget.initialTitre ?? '';
    description = widget.initialDescription ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            initialValue: titre,
            decoration: InputDecoration(
              labelText: 'Titre',
              prefixIcon: Icon(Icons.title),
              border: OutlineInputBorder(),
            ),
            onSaved: (value) => titre = value ?? '',
            validator: (value) => value == null || value.isEmpty ? 'Veuillez entrer un titre' : null,
          ),
          SizedBox(height: 16),
          TextFormField(
            initialValue: description,
            decoration: InputDecoration(
              labelText: 'Description',
              prefixIcon: Icon(Icons.description),
              border: OutlineInputBorder(),
            ),
            maxLines: 4,
            onSaved: (value) => description = value ?? '',
            validator: (value) => value == null || value.isEmpty ? 'Veuillez entrer une description' : null,
          ),
          SizedBox(height: 24),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.secondary,
              foregroundColor: Theme.of(context).colorScheme.onSecondary,
              minimumSize: Size(double.infinity, 48),
            ),
            icon: Icon(Icons.send),
            label: Text('Envoyer', style: TextStyle(fontSize: 16)),
            onPressed: () {
              if (_formKey.currentState?.validate() ?? false) {
                _formKey.currentState?.save();
                widget.onSubmit(titre, description);
              }
            },
          ),
        ],
      ),
    );
  }
}