import 'package:flutter/material.dart';
import '../models/reclamation.dart';
import '../widgets/reclamation_card.dart';
import '../screens/reclamation_detail_screen.dart';


class ReclamationsListScreen extends StatefulWidget {
  final List<Reclamation> reclamations;
  final VoidCallback onAddPressed;

  const ReclamationsListScreen({
    Key? key,
    required this.reclamations,
    required this.onAddPressed,
  }) : super(key: key);

  @override
  State<ReclamationsListScreen> createState() => _ReclamationsListScreenState();
}

class _ReclamationsListScreenState extends State<ReclamationsListScreen> {
  String searchText = '';

  void handleEdit(Reclamation updatedReclamation) {
    setState(() {
      final idx = widget.reclamations.indexWhere((r) => r.id == updatedReclamation.id);
      if (idx != -1) {
        widget.reclamations[idx] = updatedReclamation;
      }
    });
  }

  void handleDelete(String id) {
    setState(() {
      widget.reclamations.removeWhere((r) => r.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final filteredReclamations = widget.reclamations.where((reclamation) {
      final query = searchText.toLowerCase();
      return reclamation.titre.toLowerCase().contains(query) ||
          reclamation.description.toLowerCase().contains(query);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("SmartFIT - Mes Réclamations"),
        centerTitle: true,
        actions: [
          IconButton(
            tooltip: 'Assistant IA',
            icon: const Icon(Icons.smart_toy_outlined),
            onPressed: () => Navigator.pushNamed(context, '/chat'),
          ),
        ],
      ),
      body: Container(
        color: Theme.of(context).colorScheme.background,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: const InputDecoration(
                  labelText: "Rechercher",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    searchText = value;
                  });
                },
              ),
            ),
            Expanded(
              child: filteredReclamations.isEmpty
                  ? const Center(child: Text("Aucune réclamation trouvée."))
                  : ListView.builder(
                itemCount: filteredReclamations.length,
                itemBuilder: (context, index) {
                  final reclamation = filteredReclamations[index];
                  return GestureDetector(
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (ctx) => ReclamationDetailScreen(
                            reclamation: reclamation,
                            onEdit: handleEdit,
                            onDelete: handleDelete,
                          ),
                        ),
                      );
                      setState(() {}); // Rafraîchit la liste après modif/suppression
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      child: ReclamationCard(reclamation: reclamation),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: widget.onAddPressed,
        icon: const Icon(Icons.add),
        label: const Text('Nouvelle réclamation'),
      ),
    );
  }
}