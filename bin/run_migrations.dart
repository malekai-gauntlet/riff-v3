import 'package:riff/domain/tab/migrations/run_migrations.dart';

void main() async {
  try {
    await runMigrations();
  } catch (e) {
    print('❌ Error running migrations:');
    print(e);
  }
} 