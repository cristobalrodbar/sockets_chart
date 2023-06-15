class InputValue {
  String id;
  String name;
  int votes;

  InputValue({required this.id, required this.name, required this.votes});

  factory InputValue.fromMap(Map<String, dynamic> obj) => InputValue(
      id: obj.containsKey('id') ? obj['id'] : 'no-id',
      name: obj.containsKey('name') ? obj['name'] : 'no-name',
      votes: obj.containsKey('votes') ? obj['votes'] : 'no-votes');
}
