import 'package:fazfinance/constants/colors.dart';
import 'package:fazfinance/models/expense_model.dart';
import 'package:fazfinance/models/income_model.dart';
import 'package:fazfinance/models/user_model.dart';
import 'package:fazfinance/screens/add_expense.dart';
import 'package:fazfinance/screens/add_income.dart';
import 'package:fazfinance/screens/exp_trans_page.dart';
import 'package:fazfinance/screens/home_page.dart';
import 'package:fazfinance/screens/inc_trans_page.dart';
import 'package:fazfinance/screens/login_page.dart';
import 'package:fazfinance/screens/register_page.dart';
import 'package:fazfinance/screens/splash_page.dart';
import 'package:fazfinance/services/auth_service.dart';
import 'package:fazfinance/services/fin_service.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(UserModelAdapter());
  Hive.registerAdapter(IncomeModelAdapter());
  Hive.registerAdapter(ExpenseModelAdapter());
  await AuthService().openBox();
  await UserService().openIncomeBox();
  await UserService().openExpenseBox();
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=> AuthService()),
        ChangeNotifierProvider(create: (context)=> UserService()),
        
        ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: scaffoldColor,
          textTheme: const TextTheme(
            displaySmall: TextStyle(fontSize: 16,color: Colors.white)
          ),
          useMaterial3: true,
        ),
        initialRoute: '/',
        routes: {
          '/':(context) => const SplashPage(),
          'login':(context) => const LoginPage(),
          'register':(context) => const RegisterPage(),
          'home':(context) => const HomePage(),
          'addExpense':(context) => const AddExpensePage(),
          'addIncome':(context) => const AddIncomePage(),
          'exptrans' :(context) => const ExpenseTransactions(),
          'inctrans' :(context) => const IncomeTransactions(),
      
        },
        
      ),
    );
  }
}

