// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $PortfolioTableTable extends PortfolioTable
    with TableInfo<$PortfolioTableTable, PortfolioTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PortfolioTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _symbolMeta = const VerificationMeta('symbol');
  @override
  late final GeneratedColumn<String> symbol = GeneratedColumn<String>(
    'symbol',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _imageMeta = const VerificationMeta('image');
  @override
  late final GeneratedColumn<String> image = GeneratedColumn<String>(
    'image',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalCostMeta = const VerificationMeta(
    'totalCost',
  );
  @override
  late final GeneratedColumn<double> totalCost = GeneratedColumn<double>(
    'total_cost',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    symbol,
    name,
    image,
    amount,
    totalCost,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'portfolio_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<PortfolioTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('symbol')) {
      context.handle(
        _symbolMeta,
        symbol.isAcceptableOrUnknown(data['symbol']!, _symbolMeta),
      );
    } else if (isInserting) {
      context.missing(_symbolMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('image')) {
      context.handle(
        _imageMeta,
        image.isAcceptableOrUnknown(data['image']!, _imageMeta),
      );
    } else if (isInserting) {
      context.missing(_imageMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('total_cost')) {
      context.handle(
        _totalCostMeta,
        totalCost.isAcceptableOrUnknown(data['total_cost']!, _totalCostMeta),
      );
    } else if (isInserting) {
      context.missing(_totalCostMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {symbol};
  @override
  PortfolioTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PortfolioTableData(
      symbol: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}symbol'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      image: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      )!,
      totalCost: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_cost'],
      )!,
    );
  }

  @override
  $PortfolioTableTable createAlias(String alias) {
    return $PortfolioTableTable(attachedDatabase, alias);
  }
}

class PortfolioTableData extends DataClass
    implements Insertable<PortfolioTableData> {
  final String symbol;
  final String name;
  final String image;
  final double amount;
  final double totalCost;
  const PortfolioTableData({
    required this.symbol,
    required this.name,
    required this.image,
    required this.amount,
    required this.totalCost,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['symbol'] = Variable<String>(symbol);
    map['name'] = Variable<String>(name);
    map['image'] = Variable<String>(image);
    map['amount'] = Variable<double>(amount);
    map['total_cost'] = Variable<double>(totalCost);
    return map;
  }

  PortfolioTableCompanion toCompanion(bool nullToAbsent) {
    return PortfolioTableCompanion(
      symbol: Value(symbol),
      name: Value(name),
      image: Value(image),
      amount: Value(amount),
      totalCost: Value(totalCost),
    );
  }

  factory PortfolioTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PortfolioTableData(
      symbol: serializer.fromJson<String>(json['symbol']),
      name: serializer.fromJson<String>(json['name']),
      image: serializer.fromJson<String>(json['image']),
      amount: serializer.fromJson<double>(json['amount']),
      totalCost: serializer.fromJson<double>(json['totalCost']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'symbol': serializer.toJson<String>(symbol),
      'name': serializer.toJson<String>(name),
      'image': serializer.toJson<String>(image),
      'amount': serializer.toJson<double>(amount),
      'totalCost': serializer.toJson<double>(totalCost),
    };
  }

  PortfolioTableData copyWith({
    String? symbol,
    String? name,
    String? image,
    double? amount,
    double? totalCost,
  }) => PortfolioTableData(
    symbol: symbol ?? this.symbol,
    name: name ?? this.name,
    image: image ?? this.image,
    amount: amount ?? this.amount,
    totalCost: totalCost ?? this.totalCost,
  );
  PortfolioTableData copyWithCompanion(PortfolioTableCompanion data) {
    return PortfolioTableData(
      symbol: data.symbol.present ? data.symbol.value : this.symbol,
      name: data.name.present ? data.name.value : this.name,
      image: data.image.present ? data.image.value : this.image,
      amount: data.amount.present ? data.amount.value : this.amount,
      totalCost: data.totalCost.present ? data.totalCost.value : this.totalCost,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PortfolioTableData(')
          ..write('symbol: $symbol, ')
          ..write('name: $name, ')
          ..write('image: $image, ')
          ..write('amount: $amount, ')
          ..write('totalCost: $totalCost')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(symbol, name, image, amount, totalCost);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PortfolioTableData &&
          other.symbol == this.symbol &&
          other.name == this.name &&
          other.image == this.image &&
          other.amount == this.amount &&
          other.totalCost == this.totalCost);
}

class PortfolioTableCompanion extends UpdateCompanion<PortfolioTableData> {
  final Value<String> symbol;
  final Value<String> name;
  final Value<String> image;
  final Value<double> amount;
  final Value<double> totalCost;
  final Value<int> rowid;
  const PortfolioTableCompanion({
    this.symbol = const Value.absent(),
    this.name = const Value.absent(),
    this.image = const Value.absent(),
    this.amount = const Value.absent(),
    this.totalCost = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PortfolioTableCompanion.insert({
    required String symbol,
    required String name,
    required String image,
    required double amount,
    required double totalCost,
    this.rowid = const Value.absent(),
  }) : symbol = Value(symbol),
       name = Value(name),
       image = Value(image),
       amount = Value(amount),
       totalCost = Value(totalCost);
  static Insertable<PortfolioTableData> custom({
    Expression<String>? symbol,
    Expression<String>? name,
    Expression<String>? image,
    Expression<double>? amount,
    Expression<double>? totalCost,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (symbol != null) 'symbol': symbol,
      if (name != null) 'name': name,
      if (image != null) 'image': image,
      if (amount != null) 'amount': amount,
      if (totalCost != null) 'total_cost': totalCost,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PortfolioTableCompanion copyWith({
    Value<String>? symbol,
    Value<String>? name,
    Value<String>? image,
    Value<double>? amount,
    Value<double>? totalCost,
    Value<int>? rowid,
  }) {
    return PortfolioTableCompanion(
      symbol: symbol ?? this.symbol,
      name: name ?? this.name,
      image: image ?? this.image,
      amount: amount ?? this.amount,
      totalCost: totalCost ?? this.totalCost,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (symbol.present) {
      map['symbol'] = Variable<String>(symbol.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (image.present) {
      map['image'] = Variable<String>(image.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (totalCost.present) {
      map['total_cost'] = Variable<double>(totalCost.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PortfolioTableCompanion(')
          ..write('symbol: $symbol, ')
          ..write('name: $name, ')
          ..write('image: $image, ')
          ..write('amount: $amount, ')
          ..write('totalCost: $totalCost, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $PortfolioTableTable portfolioTable = $PortfolioTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [portfolioTable];
}

typedef $$PortfolioTableTableCreateCompanionBuilder =
    PortfolioTableCompanion Function({
      required String symbol,
      required String name,
      required String image,
      required double amount,
      required double totalCost,
      Value<int> rowid,
    });
typedef $$PortfolioTableTableUpdateCompanionBuilder =
    PortfolioTableCompanion Function({
      Value<String> symbol,
      Value<String> name,
      Value<String> image,
      Value<double> amount,
      Value<double> totalCost,
      Value<int> rowid,
    });

class $$PortfolioTableTableFilterComposer
    extends Composer<_$AppDatabase, $PortfolioTableTable> {
  $$PortfolioTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get symbol => $composableBuilder(
    column: $table.symbol,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get image => $composableBuilder(
    column: $table.image,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalCost => $composableBuilder(
    column: $table.totalCost,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PortfolioTableTableOrderingComposer
    extends Composer<_$AppDatabase, $PortfolioTableTable> {
  $$PortfolioTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get symbol => $composableBuilder(
    column: $table.symbol,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get image => $composableBuilder(
    column: $table.image,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalCost => $composableBuilder(
    column: $table.totalCost,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PortfolioTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $PortfolioTableTable> {
  $$PortfolioTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get symbol =>
      $composableBuilder(column: $table.symbol, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get image =>
      $composableBuilder(column: $table.image, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<double> get totalCost =>
      $composableBuilder(column: $table.totalCost, builder: (column) => column);
}

class $$PortfolioTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PortfolioTableTable,
          PortfolioTableData,
          $$PortfolioTableTableFilterComposer,
          $$PortfolioTableTableOrderingComposer,
          $$PortfolioTableTableAnnotationComposer,
          $$PortfolioTableTableCreateCompanionBuilder,
          $$PortfolioTableTableUpdateCompanionBuilder,
          (
            PortfolioTableData,
            BaseReferences<
              _$AppDatabase,
              $PortfolioTableTable,
              PortfolioTableData
            >,
          ),
          PortfolioTableData,
          PrefetchHooks Function()
        > {
  $$PortfolioTableTableTableManager(
    _$AppDatabase db,
    $PortfolioTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PortfolioTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PortfolioTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PortfolioTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> symbol = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> image = const Value.absent(),
                Value<double> amount = const Value.absent(),
                Value<double> totalCost = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PortfolioTableCompanion(
                symbol: symbol,
                name: name,
                image: image,
                amount: amount,
                totalCost: totalCost,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String symbol,
                required String name,
                required String image,
                required double amount,
                required double totalCost,
                Value<int> rowid = const Value.absent(),
              }) => PortfolioTableCompanion.insert(
                symbol: symbol,
                name: name,
                image: image,
                amount: amount,
                totalCost: totalCost,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PortfolioTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PortfolioTableTable,
      PortfolioTableData,
      $$PortfolioTableTableFilterComposer,
      $$PortfolioTableTableOrderingComposer,
      $$PortfolioTableTableAnnotationComposer,
      $$PortfolioTableTableCreateCompanionBuilder,
      $$PortfolioTableTableUpdateCompanionBuilder,
      (
        PortfolioTableData,
        BaseReferences<_$AppDatabase, $PortfolioTableTable, PortfolioTableData>,
      ),
      PortfolioTableData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$PortfolioTableTableTableManager get portfolioTable =>
      $$PortfolioTableTableTableManager(_db, _db.portfolioTable);
}
