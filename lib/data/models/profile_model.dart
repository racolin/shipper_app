class ProfileModel {
  final String name;
  final DateTime dob;
  final int gender;
  final String phone;
  final int wallet;
  final String numberPlate;
  final String avatar;
  final DateTime createdAt;

  ProfileModel({
    required this.name,
    required this.dob,
    required this.gender,
    required this.phone,
    required this.wallet,
    required this.numberPlate,
    required this.avatar,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'dob': dob,
      'gender': gender,
      'phone': phone,
      'wallet': wallet,
      'numberPlate': numberPlate,
      'avatar': avatar,
      'createdAt': createdAt,
    };
  }

  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    return ProfileModel(
      name: map['name'] as String,
      dob: map['dob'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['dob'])
          : DateTime.now(),
      gender: map['gender'] as int,
      phone: map['phone'] as String,
      wallet: map['wallet'] as int,
      numberPlate: map['numberPlate'] as String,
      avatar: map['avatar'] as String,
      createdAt: map['createdAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'])
          : DateTime.now(),
    );
  }

  ProfileModel copyWith({
    String? name,
    DateTime? dob,
    int? gender,
    String? phone,
    int? wallet,
    String? numberPlate,
    String? avatar,
    DateTime? createdAt,
  }) {
    return ProfileModel(
      name: name ?? this.name,
      dob: dob ?? this.dob,
      gender: gender ?? this.gender,
      phone: phone ?? this.phone,
      wallet: wallet ?? this.wallet,
      numberPlate: numberPlate ?? this.numberPlate,
      avatar: avatar ?? this.avatar,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
