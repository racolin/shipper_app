class ErrorSocketModel {
  final String name;
  final String message;

  const ErrorSocketModel({
    required this.name,
    required this.message,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'message': message,
    };
  }

  factory ErrorSocketModel.fromMap(Map<String, dynamic> map) {
    return ErrorSocketModel(
      name: map['name'] as String,
      message: map['message'] as String,
    );
  }
}