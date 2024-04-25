class PersonEntity {
  final int id;
  String name;
  
  PersonEntity({
    required this.id,
    required this.name,
  });

  @override
  String toString() {
    return 'PersonEntity(id: $id, name: $name)';
  }
}