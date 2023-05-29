class InputValues {
  String id;
  String name;
  int votes;

  InputValues({required this.id, required this.name, required this.votes});

  factory InputValues.fromMap(Map<String, dynamic> obj) =>
      InputValues(id: obj['id'], name: obj['name'], votes: obj['votes']);
}
