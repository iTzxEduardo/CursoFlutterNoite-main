class Todolist {
  // Attributes
  final String? doc;
  final String id;
  final String titulo;
  final String userId;
  final DateTime timeStamp;

  Todolist({
    this.doc,
    required this.id,
    required this.titulo,
    required this.userId,
    required this.timeStamp,
  });

  // Convert to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titulo': titulo,
      'userid': userId,
      'timeStamp': timeStamp.toIso8601String(),
    };
  }

  // Create instance from Map
  factory Todolist.fromMap(Map<String, dynamic> map, String id, {String? doc}) {
    return Todolist(
      doc: doc,
      id: map['id'],
      titulo: map['titulo'],
      userId: map['userid'],
      timeStamp: DateTime.parse(map['timeStamp']),
    );
  }
}
