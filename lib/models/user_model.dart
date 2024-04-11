import 'package:hive_flutter/adapters.dart';

import 'package:hive_flutter/hive_flutter.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel extends HiveObject {
  @HiveField(0)
  late String email;
  @HiveField(1)
  late String password;
  @HiveField(2)
  late String name;
  @HiveField(3)
  late String phoneno;
  @HiveField(4)
  late int status;
  @HiveField(5)
  late String id;
  UserModel({
    required this.email,
    required this.password,
    required this.name,
    required this.phoneno,
    required this.status,
    required this.id,
  });
}
