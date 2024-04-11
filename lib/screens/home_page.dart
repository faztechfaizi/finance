import 'package:fazfinance/models/user_model.dart';
import 'package:fazfinance/services/auth_service.dart';
import 'package:fazfinance/services/fin_service.dart';


import 'package:fazfinance/widgets/apptext.dart';
import 'package:fazfinance/widgets/dashboard_widget.dart';
import 'package:fazfinance/widgets/mydivider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
     _fetchInitialData(context);
    });
    

  }

  Future <void> _fetchInitialData(BuildContext context)async{
    final userService = Provider.of<UserService>(context,listen: false);
    final authService = Provider.of<AuthService>(context,listen: false);
    final userModel = await authService.getCurrentUser();

    if(userModel != null){
      userService.calculateTotalExpenseForUser(userModel.id);
      userService.calculateTotalIncomeForUser(userModel.id);

    }


  }
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
     final userService=Provider.of<UserService>(context);
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<UserModel?>(
          future: authService.getCurrentUser(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (snapshot.hasData) {
                final userData = snapshot.data;
                return Center(
                  child: Container(
                      height: double.infinity,
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const AppText(
                                    data: 'Welcome',
                                    color: Colors.white,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  AppText(
                                    data: userData!.name.toUpperCase(),
                                    color: Colors.white,
                                    fw: FontWeight.bold,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                               
                              PopupMenuButton(
                              itemBuilder: (BuildContext context) {
                                return [
                                  const PopupMenuItem(
                                    child: AppText(data: 'Logout'),
                                    value: 'logout',
                                  ),
                                ];
                              },
                              onSelected: (value) {
                                if (value == 'logout') {
                                  authService.logout(context);
                                }
                              },
                            
                                child: CircleAvatar(
                                  child: Text(userData.name[0].toUpperCase()),
                                ),
                              ),
                            ],
                          ),
                          const MyDivider(),
                          const SizedBox(
                            height: 20,
                          ),
                          DashboardItemWidget(
                              onTap1: () {Navigator.pushNamed(context, 'inctrans',arguments: userService.totalIncome);},
                              onTap2: () {Navigator.pushNamed(context, 'exptrans',arguments: userService.totalExpense);},
                              titleOne: 'Income \n${ userService.totalIncome}',
                              titleTwo: 'Expense \n${userService.totalExpense}'),
                          const SizedBox(
                            height: 20,
                          ),
                          DashboardItemWidget(
                              onTap1: () {
                                Navigator.pushNamed(context, 'addIncome',
                                    arguments: userData.id);
                              },
                              onTap2: () {
                                Navigator.pushNamed(context, 'addExpense',
                                    arguments: userData.id);
                              },
                              titleOne: 'Add Income',
                              titleTwo: 'Add Expense'),
                          Container(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                const AppText(
                                  data: 'Income vs Expense',
                                  color: Colors.white,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                AspectRatio(
                                  aspectRatio: 1.3,
                                  child: PieChart(PieChartData(
                                    sections: [
                                      PieChartSectionData(
                                        radius: 50,
                                        color: const Color(0xffe76f51),
                                        value: userService.totalExpense,
                                        title: "Expense",
                                        titleStyle: const TextStyle(
                                            color: Colors.white),
                                      ),
                                      PieChartSectionData(
                                        radius: 50,
                                        color: const Color(0xff2a9d8f),
                                        value: userService.totalIncome,
                                        title: "Income",
                                        titleStyle: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ],
                                  )),
                                )
                              ],
                            ),
                          )
                        ],
                      )),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }
          },
        ),
      ),
    );
  }
}
