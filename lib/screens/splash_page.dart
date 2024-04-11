
import 'package:fazfinance/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
   
    super.initState();
    checkLoginState();
  }

  Future <void> checkLoginState()async{
await Future.delayed(const Duration(seconds: 3));
final authService = Provider.of<AuthService>(context,listen: false);
final isLoggedIn = await authService.isUserLoggedIn();
if(isLoggedIn){
  
  
  Navigator.pushNamedAndRemoveUntil(context, 'home', (route) => false, );
}else { Navigator.pushReplacementNamed(context,'login' );
}


  }
  @override
  Widget build(BuildContext context) {
    return 
    Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(

      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/splashlogo.png'),
          ],
        ),
      ),
    );
  }
}