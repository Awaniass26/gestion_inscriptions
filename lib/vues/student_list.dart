import 'package:flutter/material.dart';
import '../models/student.dart';
import '../services/api_service.dart';

class StudentList extends StatefulWidget {
  const StudentList({Key? key}) : super(key: key);

  @override
  State<StudentList> createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {
  List<Student> students = [];
  bool isLoading = true;
  String? selectedClasse;
  final List<String> classes = ['L1 MAE', 'L2 MAE', 'L3 MAE'];

  @override
  void initState() {
    super.initState();
    fetchStudents();
  }

  Future<void> fetchStudents({String? classe}) async {
    setState(() {
      isLoading = true;
    });
    try {
      final data = await ApiService.fetchStudents(classe: classe);
      setState(() {
        students = data;
        selectedClasse = classe;
      });
    } catch (e) {
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Widget buildStudentCard(Student student) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        title: Text('${student.nom} ${student.prenom}'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Classe : ${student.classe}'),
            Text('Matricule : ${student.matricule}'),
            Text('Email : ${student.email}'),
          ],
        ),
      ),
    ); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liste des Étudiants Inscrits'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: DropdownButtonFormField<String>(
              value: selectedClasse,
              hint: const Text('Filtrer par classe'),
              items: classes
                  .map((classe) => DropdownMenuItem(
                        value: classe,
                        child: Text(classe),
                      ))
                  .toList(),
              onChanged: (value) {
                fetchStudents(classe: value);
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Classe',
              ),
            ),
          ),
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : students.isEmpty
                    ? const Center(child: Text('Aucun étudiant trouvé.'))
                    : ListView.builder(
                        itemCount: students.length,
                        itemBuilder: (context, index) =>
                            buildStudentCard(students[index]),
                      ),
          ),
        ],
      ),
    );
  }
}
