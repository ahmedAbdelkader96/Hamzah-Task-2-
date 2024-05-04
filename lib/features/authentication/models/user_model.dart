class UserModel {
  static DateTime fromJsonDate(String value) => DateTime.parse(value).toLocal();

  static String toJsonDate(DateTime value) => value.toUtc().toString();

  String userId;
  var createdAt;
  String name;
  String jobTitle;
  String phone;
  String email;

  UserModel({
    required this.userId,
    required this.createdAt,
    required this.name,
    required this.jobTitle,
    required this.phone,
    required this.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return  UserModel(
      userId: json['user_id'] as String,
      createdAt: UserModel.fromJsonDate(json['created_at']),
      name: json['name']  as String,
      jobTitle: json['job_title']  as String,
      phone: json['phone']  as String,
      email: json['email']  as String,
    );
  }

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "created_at": UserModel.toJsonDate(createdAt),
        "name": name,
        "job_title": jobTitle,
        "phone": phone,
        "email": email,
      };
}
