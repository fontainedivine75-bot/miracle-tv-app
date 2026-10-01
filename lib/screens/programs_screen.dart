import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:miracle_tv/core/constants.dart';
import 'package:miracle_tv/services/firestore_service.dart';
import 'package:miracle_tv/models/program_model.dart';

class ProgramsScreen extends StatefulWidget {
  const ProgramsScreen({super.key});

  @override
  State<ProgramsScreen> createState() => _ProgramsScreenState();
}

class _ProgramsScreenState extends State<ProgramsScreen> {
  final _firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Programmes'),
        actions: [
          StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              final user = snapshot.data;
              if (user != null) {
                return FutureBuilder<DocumentSnapshot>(
                  future: FirebaseFirestore.instance
                      .collection(FirestoreCollections.users)
                      .doc(user.uid)
                      .get(),
                  builder: (context, userSnapshot) {
                    final isAdmin = userSnapshot.data?.get('isAdmin') ?? false;
                    if (isAdmin) {
                      return IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          // Navigate to add program screen
                        },
                      );
                    }
                    return const SizedBox.shrink();
                  },
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
      body: StreamBuilder<List<ProgramModel>>(
        stream: _firestoreService.fetchPrograms(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Erreur: ${snapshot.error}'));
          }

          final programs = snapshot.data ?? [];

          if (programs.isEmpty) {
            return const Center(
              child: Text('Aucun programme disponible'),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: programs.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final program = programs[index];
              return Card(
                child: ListTile(
                  leading: program.imageUrl.isNotEmpty
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            program.imageUrl,
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) {
                              return const Icon(Icons.image_not_supported);
                            },
                          ),
                        )
                      : const Icon(Icons.event),
                  title: Text(program.title),
                  subtitle: Text(
                    '${program.date} • ${program.time}\n${program.location}',
                  ),
                  isThreeLine: true,
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              program.title,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(program.description),
                            const SizedBox(height: 16),
                            Text(
                              'Date: ${program.date}\nHeure: ${program.time}\nLieu: ${program.location}',
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
