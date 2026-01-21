import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'app_database.g.dart';

class PortfolioTable extends Table {
  TextColumn get symbol => text()();
  TextColumn get name => text()();
  TextColumn get image => text()();
  RealColumn get amount => real()();
  RealColumn get totalCost => real()(); // Store total cost to calculate average

  @override
  Set<Column> get primaryKey => {symbol};
}

@lazySingleton
@DriftDatabase(tables: [PortfolioTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<List<PortfolioTableData>> getAllAssets() =>
      select(portfolioTable).get();

  Future<void> addTransaction(
    String symbol,
    String name,
    String image,
    double amount,
    double price,
  ) async {
    final cost = amount * price;

    // Check if asset exists
    final exists = await (select(
      portfolioTable,
    )..where((t) => t.symbol.equals(symbol))).getSingleOrNull();

    if (exists != null) {
      // Update existing
      final newAmount = exists.amount + amount;
      final newCost = exists.totalCost + cost;

      // If sell results in 0 or less, delete (simplified logic)
      if (newAmount <= 0) {
        await (delete(
          portfolioTable,
        )..where((t) => t.symbol.equals(symbol))).go();
      } else {
        await update(portfolioTable).replace(
          PortfolioTableCompanion(
            symbol: Value(symbol),
            name: Value(name),
            image: Value(image),
            amount: Value(newAmount),
            totalCost: Value(newCost),
          ),
        );
      }
    } else {
      // Insert new
      await into(portfolioTable).insert(
        PortfolioTableCompanion.insert(
          symbol: symbol,
          name: name,
          image: image,
          amount: amount,
          totalCost: cost,
        ),
      );
    }
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'quant_ai.sqlite'));
    return NativeDatabase(file);
  });
}
