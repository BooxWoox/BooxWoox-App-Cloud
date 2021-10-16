import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

final hiveProvider = Provider.autoDispose((ref) => Hive.box('user'));
