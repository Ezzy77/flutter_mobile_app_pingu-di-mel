class Coqueiros{
  late final int id;
  late final String firstName;
  late final String lastName;

  Coqueiros({
    required this.id,
    required this.firstName,
    required this.lastName,
  });

  Coqueiros.fromMap(Map<String, dynamic> result)
      : id = result["id"],
        firstName = result["firstName"],
        lastName = result["lastName"];
  Map<String, Object> toMap() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,

    };
  }
}
