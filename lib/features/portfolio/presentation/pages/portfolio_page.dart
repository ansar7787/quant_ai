import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quant_ai/di/injection.dart';
import 'package:quant_ai/features/portfolio/domain/entities/asset.dart';
import 'package:quant_ai/features/portfolio/presentation/bloc/portfolio_bloc.dart';

class PortfolioPage extends StatelessWidget {
  const PortfolioPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<PortfolioBloc>()..add(PortfolioRequested()),
      child: Scaffold(
        appBar: AppBar(title: const Text('My Portfolio')),
        body: BlocBuilder<PortfolioBloc, PortfolioState>(
          builder: (context, state) {
            if (state is PortfolioLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is PortfolioError) {
              return Center(child: Text(state.message));
            } else if (state is PortfolioLoaded) {
              final assets = state.assets;
              if (assets.isEmpty) {
                return const Center(
                  child: Text('No assets yet. Buy some crypto!'),
                );
              }
              return SingleChildScrollView(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  children: [
                    _PortfolioChart(assets: assets),
                    SizedBox(height: 24.h),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: assets.length,
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 12.h),
                      itemBuilder: (context, index) {
                        return _AssetItem(asset: assets[index]);
                      },
                    ),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
        floatingActionButton: Builder(
          builder: (context) {
            return FloatingActionButton(
              onPressed: () async {
                final result = await showDialog<Map<String, dynamic>>(
                  context: context,
                  builder: (context) => const _AddTransactionDialog(),
                );

                if (result != null && context.mounted) {
                  context.read<PortfolioBloc>().add(
                    PortfolioTransactionAdded(
                      symbol: result['symbol'],
                      name: result['symbol']
                          .toString()
                          .toUpperCase(), // Simulating name fetch
                      image:
                          "https://assets.coingecko.com/coins/images/1/large/bitcoin.png", // Placeholder
                      amount: result['amount'],
                      price: result['price'],
                    ),
                  );
                }
              },
              child: const Icon(Icons.add),
            );
          },
        ),
      ),
    );
  }
}

class _PortfolioChart extends StatelessWidget {
  final List<Asset> assets;

  const _PortfolioChart({required this.assets});

  @override
  Widget build(BuildContext context) {
    // Determine sections for Pie Chart
    final totalValue = assets.fold(0.0, (sum, asset) => sum + asset.costBasis);

    return SizedBox(
      height: 200.h,
      child: PieChart(
        PieChartData(
          sectionsSpace: 2,
          centerSpaceRadius: 40,
          sections: assets.map((asset) {
            final value = asset.costBasis;
            final percentage = (value / totalValue) * 100;
            return PieChartSectionData(
              color: Colors
                  .primaries[assets.indexOf(asset) % Colors.primaries.length],
              value: value,
              title: '${percentage.toStringAsFixed(0)}%',
              radius: 50,
              titleStyle: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class _AssetItem extends StatelessWidget {
  final Asset asset;

  const _AssetItem({required this.asset});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Image.network(
            asset.image,
            width: 32.w,
            height: 32.w,
            errorBuilder: (_, __, ___) => const Icon(Icons.error),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  asset.name,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${asset.amount} ${asset.symbol.toUpperCase()}',
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: Colors.grey),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '\$${asset.costBasis.toStringAsFixed(2)}',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                'Avg: \$${asset.averagePrice.toStringAsFixed(2)}',
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AddTransactionDialog extends StatefulWidget {
  const _AddTransactionDialog();

  @override
  State<_AddTransactionDialog> createState() => _AddTransactionDialogState();
}

class _AddTransactionDialogState extends State<_AddTransactionDialog> {
  final _symbolController = TextEditingController(text: 'bitcoin');
  final _amountController = TextEditingController();
  final _priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Transaction'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _symbolController,
            decoration: const InputDecoration(labelText: 'Symbol (id)'),
          ),
          TextField(
            controller: _amountController,
            decoration: const InputDecoration(labelText: 'Amount'),
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: _priceController,
            decoration: const InputDecoration(labelText: 'Buy Price'),
            keyboardType: TextInputType.number,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () {
            // Hacky way to access bloc from dialog for demo
            // In real app, pass bloc or use callback
            final symbol = _symbolController.text;
            final amount = double.tryParse(_amountController.text) ?? 0;
            final price = double.tryParse(_priceController.text) ?? 0;

            if (symbol.isNotEmpty && amount > 0 && price > 0) {
              // Note: We need the context from the Page, not the Dialog.
              // This part specifically needs the BlocProvider context.
              // For simplicity in this demo, we assume the user triggers this from the FAB which has context.
              // But wait, showDialog context doesn't have the Bloc Provider if it's above the page.
              // We'll need to wrap the dialog execution where the Bloc is available.
              Navigator.pop(context, {
                'symbol': symbol,
                'amount': amount,
                'price': price,
              });
            }
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}
