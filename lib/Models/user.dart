import 'package:hive/hive.dart';

@HiveType(typeId: 1)
class User extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String phone;
}

