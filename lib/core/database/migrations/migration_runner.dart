import 'dart:math' as math;

import 'package:drift/drift.dart';
import 'package:driftsql/core/database/app_database.steps.dart';

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

  // v5 ve sonrası:
  // Drift'in generated step-by-step migration sistemi.
  if (to > 5) {
    await migrator.runMigrationSteps(
      from: math.max(5, from),
      to: to,
      steps: migrationSteps(from5To6: migrateFrom5To6),
    );
  }
  // Future ranges:
  //
  // await runMigrationsV011V020(...);
  // await runMigrationsV021V030(...);
}
