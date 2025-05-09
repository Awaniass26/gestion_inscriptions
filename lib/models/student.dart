class Student {
  final String nom;
  final String prenom;
  final String classe;
  final String matricule;
  final String email;

  Student({
    required this.nom,
    required this.prenom,
    required this.classe,
    required this.matricule,
    required this.email,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      nom: json['nom'],
      prenom: json['prenom'],
      classe: json['classe'],
      matricule: json['matricule'],
      email: json['email'],
    );
  }
}
