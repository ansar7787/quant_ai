import 'package:injectable/injectable.dart';
import 'package:quant_ai/core/database/app_database.dart';

@module
abstract class DatabaseModule {
  @lazySingleton
  AppDatabase get appDatabase => AppDatabase();
}
