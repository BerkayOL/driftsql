import 'package:drift/drift.dart';

import 'migration_context.dart';
import 'migrations_v001_v010.dart';

Future<void> runMigrations({
  required Migrator migrator,
  required int from,
  required int to,
  required MigrationContext context,
}) async {
  await runMigrationsV001V010(
    migrator: migrator,
    from: from,
    to: to,
    context: context,
  );

  // Future ranges:
  //
  // await runMigrationsV011V020(...);
  // await runMigrationsV021V030(...);
}
