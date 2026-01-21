import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quant_ai/di/injection.dart';
import 'package:quant_ai/features/portfolio/presentation/bloc/portfolio_bloc.dart';
import 'package:quant_ai/features/portfolio/presentation/widgets/asset_allocation_list.dart';
import 'package:quant_ai/features/portfolio/presentation/widgets/asset_allocation_pie_chart.dart';

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
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.pie_chart_outline,
                        size: 64.sp,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        'Start building your wealth!',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                );
              }
              final totalValue =
                  assets.fold(
                    0.0,
                    (sum, asset) => sum + (asset.currentPrice * asset.amount),
                  ) +
                  state.walletBalance;

              return SingleChildScrollView(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  children: [
                    Text(
                      'Total Wealth',
                      style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      '\$${totalValue.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 36.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 8.h,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondaryContainer,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Cash: \$${state.walletBalance.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(
                            context,
                          ).colorScheme.onSecondaryContainer,
                        ),
                      ),
                    ),
                    SizedBox(height: 24.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _PortfolioActionButton(
                          icon: Icons.add_card,
                          label: 'Deposit',
                          onTap: () async {
                            final bloc = context.read<PortfolioBloc>();
                            await showDialog(
                              context: context,
                              builder: (context) => _RealPaymentDialog(
                                type: 'Deposit',
                                onConfirm: (amount) {
                                  bloc.add(PortfolioBalanceUpdated(amount));
                                },
                              ),
                            );
                          },
                        ),
                        _PortfolioActionButton(
                          icon: Icons.account_balance_wallet,
                          label: 'Withdraw',
                          onTap: () async {
                            final bloc = context.read<PortfolioBloc>();
                            await showDialog(
                              context: context,
                              builder: (context) => _RealPaymentDialog(
                                type: 'Withdraw',
                                onConfirm: (amount) {
                                  bloc.add(PortfolioBalanceUpdated(-amount));
                                },
                              ),
                            );
                          },
                        ),
                        _PortfolioActionButton(
                          icon: Icons.pie_chart_outline, // Add Asset
                          label: 'Add Asset',
                          onTap: () async {
                            final result =
                                await showDialog<Map<String, dynamic>>(
                                  context: context,
                                  builder: (context) =>
                                      const _AddTransactionDialog(),
                                );

                            if (result != null && context.mounted) {
                              context.read<PortfolioBloc>().add(
                                PortfolioTransactionAdded(
                                  symbol: result['symbol'],
                                  name: result['symbol']
                                      .toString()
                                      .toUpperCase(),
                                  image:
                                      "https://assets.coingecko.com/coins/images/1/large/bitcoin.png",
                                  amount: result['amount'],
                                  price: result['price'],
                                ),
                              );
                            }
                          },
                        ),
                        _PortfolioActionButton(
                          icon: Icons.history,
                          label: 'History',
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Transaction History coming soon!',
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 32.h),
                    AssetAllocationPieChart(assets: assets),
                    SizedBox(height: 32.h),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Allocation',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    AssetAllocationList(assets: assets),
                    SizedBox(height: 80.h), // Bottom Nav Spacer
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
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
            decoration: const InputDecoration(
              labelText: 'Coin ID (e.g. bitcoin)',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 16.h),
          TextField(
            controller: _amountController,
            decoration: const InputDecoration(
              labelText: 'Amount',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.numberWithOptions(decimal: true),
          ),
          SizedBox(height: 16.h),
          TextField(
            controller: _priceController,
            decoration: const InputDecoration(
              labelText: 'Buy Price (\$) per unit',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.numberWithOptions(decimal: true),
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
            final symbol = _symbolController.text;
            final amount = double.tryParse(_amountController.text) ?? 0;
            final price = double.tryParse(_priceController.text) ?? 0;

            if (symbol.isNotEmpty && amount > 0 && price > 0) {
              Navigator.pop(context, {
                'symbol': symbol,
                'amount': amount,
                'price': price,
              });
            }
          },
          child: const Text('Add Asset'),
        ),
      ],
    );
  }
}

class _PortfolioActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _PortfolioActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: Theme.of(
                context,
              ).colorScheme.primaryContainer.withValues(alpha: 0.5),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Theme.of(context).colorScheme.primary),
          ),
          SizedBox(height: 8.h),
          Text(
            label,
            style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class _RealPaymentDialog extends StatefulWidget {
  final String type;
  final Function(double) onConfirm;

  const _RealPaymentDialog({required this.type, required this.onConfirm});

  @override
  State<_RealPaymentDialog> createState() => _RealPaymentDialogState();
}

class _RealPaymentDialogState extends State<_RealPaymentDialog> {
  final _amountController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('${widget.type} USD'),
      content: _isLoading
          ? const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text('Processing transaction...'),
              ],
            )
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Enter the amount you wish to process via our secure gateway.',
                ),
                SizedBox(height: 16.h),
                TextField(
                  controller: _amountController,
                  decoration: InputDecoration(
                    labelText: 'Amount (\$)',
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.attach_money),
                  ),
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  autofocus: true,
                ),
              ],
            ),
      actions: _isLoading
          ? []
          : [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              FilledButton(
                onPressed: () async {
                  final amount = double.tryParse(_amountController.text) ?? 0;
                  if (amount <= 0) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please enter a valid amount'),
                      ),
                    );
                    return;
                  }

                  setState(() => _isLoading = true);
                  await Future.delayed(
                    const Duration(seconds: 1),
                  ); // Slight delay for "realism"

                  if (mounted) {
                    widget.onConfirm(amount);
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${widget.type} Successful!')),
                    );
                  }
                },
                child: const Text('Confirm'),
              ),
            ],
    );
  }
}
