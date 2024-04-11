import 'package:fazfinance/models/expense_model.dart';
import 'package:fazfinance/services/auth_service.dart';
import 'package:fazfinance/services/fin_service.dart';
import 'package:fazfinance/widgets/apptext.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpenseTransactions extends StatefulWidget {
  const ExpenseTransactions({super.key});

  @override
  State<ExpenseTransactions> createState() => _ExpenseTransactionsState();
}

class _ExpenseTransactionsState extends State<ExpenseTransactions> {
  @override
  Widget build(BuildContext context) {
    final double totalExpense = ModalRoute.of(context)!.settings.arguments as double;
    final userService = Provider.of<UserService>(context,listen: false);
    final authService = Provider.of<AuthService>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Expenses'),

      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: FutureBuilder(future:authService.getCurrentUser() , builder: (context,snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(
              child: CircularProgressIndicator(),
        
            );
          }else{
            if(snapshot.hasData){
              final userData = snapshot.data!;
              return FutureBuilder<List<ExpenseModel>>(future: userService.getAllExpense(userData.id), builder: (context,snapshot){
                if(snapshot.connectionState == ConnectionState.waiting){
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }else{
                  if(snapshot.hasData){
                    final List<ExpenseModel> expenses = snapshot.data!;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(data: 'Total Expense $totalExpense',color: Colors.white,),
                        const SizedBox(height: 20,),
                        Expanded(child: ListView.builder(
                          itemCount: expenses.length,
                          itemBuilder: (context,index){
                          final expense = expenses[index];
                          return Card(
                            color: const Color(0xffcaf0f8),
                            child: ListTile(
                              onTap: (){
                                showModalBottomSheet(
                                  
                                  context: context, builder: (context){

                                  return Container(
                                    color: const Color(0xff90e0ef),
                                    height: 150,
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(20),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        AppText(data: 'Category: ${expense.category}'),
                                        AppText(data: 'Description : ${expense.description}'),
                                        AppText(data: 'Amount: ${expense.amount.toString()}'),
                                        
                                        


                                      ],
                                      
                                      
                                    ),
                                  );
                                  

                                }
                                
                                
                                );
                               
                              },
                              title: AppText(data: expense.category,),
                              subtitle: AppText(data: expense.amount.toString(),),
                            
                            ),
                          );
                        }))
                      ],
                    );
                  }
                  return const Center(child: CircularProgressIndicator(),);
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