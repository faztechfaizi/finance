import 'package:fazfinance/models/income_model.dart';
import 'package:fazfinance/services/auth_service.dart';
import 'package:fazfinance/services/fin_service.dart';
import 'package:fazfinance/widgets/apptext.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IncomeTransactions extends StatefulWidget {
  const IncomeTransactions({super.key});

  @override
  State<IncomeTransactions> createState() => _IncomeTransactionsState();
}

class _IncomeTransactionsState extends State<IncomeTransactions> {
  @override
  Widget build(BuildContext context) {
    final double totalIncome =
        ModalRoute.of(context)!.settings.arguments as double;
    final userService = Provider.of<UserService>(context, listen: false);
    final authService = Provider.of<AuthService>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Income'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: FutureBuilder(
            future: authService.getCurrentUser(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                if (snapshot.hasData) {
                  final userData = snapshot.data!;
                  return FutureBuilder<List<IncomeModel>>(
                      future: userService.getAllIncome(userData.id),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          if (snapshot.hasData) {
                            final List<IncomeModel> income = snapshot.data!;
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppText(
                                  data: 'Total Expense $totalIncome',
                                  color: Colors.white,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Expanded(
                                    child: ListView.builder(
                                        itemCount: income.length,
                                        itemBuilder: (context, index) {
                                          final incomes = income[index];
                                          return Card(
                                           color:  const Color(0xffcaf0f8),
                                            child: ListTile(
                                              onTap: () {
                                                showModalBottomSheet(
                                                    context: context,
                                                    builder: (context) {
                                                      return Container(
                                                        color: const Color(0xff90e0ef),
                                                        height: 150,
                                                        width: double.infinity,
                                                        padding:
                                                            const EdgeInsets
                                                                .all(20),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            AppText(
                                                                data:
                                                                    'Category: ${incomes.category}'),
                                                            AppText(
                                                                data:
                                                                    'Description : ${incomes.description}'),
                                                            AppText(
                                                                data:
                                                                    'Amount: ${incomes.amount.toString()}'),
                                                          ],
                                                        ),
                                                      );
                                                    });
                                              },
                                              title: AppText(
                                                data: incomes.category,
                                              ),
                                              subtitle: AppText(
                                                data: incomes.amount.toString(),
                                              ),
                                            ),
                                          );
                                        }))
                              ],
                            );
                          }
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      });
                }
                return const Center();
              }
            }),
      ),
    );
  }
}
