import 'package:flutter/material.dart';

class ProgramsScreen extends StatelessWidget {
  const ProgramsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final programs = [
      {
        'title': 'Culte de guérison',
        'date': 'Samedi 18 mai',
        'time': '17h00',
        'location': 'Centre de prière',
        'description': 'Service de guérison, délivrance et enseignement',
      },
      {
        'title': 'Heure de prière',
        'date': 'Dimanche 19 mai',
        'time': '09h00',
        'location': 'Église centrale',
        'description': 'Moment de prière et de louange',
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Programmes')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: programs.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final program = programs[index];
          return Card(
            child: ListTile(
              leading: const Icon(Icons.event),
              title: Text(program['title'] as String),
              subtitle: Text(
                '${program['date']} • ${program['time']}\n${program['location']}\n${program['description']}',
              ),
            ),
          );
        },
      ),
    );
  }
}
