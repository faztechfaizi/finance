import 'package:fazfinance/services/auth_service.dart';
import 'package:fazfinance/widgets/appbutton.dart';
import 'package:fazfinance/widgets/apptext.dart';
import 'package:fazfinance/widgets/customtextformfiled.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _loginKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Scaffold(
      
      body: Container(
        padding: const EdgeInsets.all(20),
        height: double.infinity,
        width: double.infinity,
        child: Form(
          key: _loginKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            
            children: [
              CustomTextFormField(
                validator: (value){
                  if(value!.isEmpty){
                    return 'Email Required';

                  }
                  return null;
                },
                controller: _emailController, hintText: 'Enter Email'),
              const SizedBox(height: 20,),
              CustomTextFormField(
                validator: (value){
                  if(value!.isEmpty){
                    return 'Password Required';

                  }
                  return null;
                },
                 obscureText: true, controller: _passwordController, hintText: "Enter Password"),
              const SizedBox(height: 20,),
              AppButton(
                height: 48,
                width: 250,
                color: const Color(0xfffca311),
                onTap: (){
                  if(_loginKey.currentState!.validate()){
                    showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                });
                            final user =    authService.loginUser(_emailController.text.trim(), _passwordController.text);
                            Navigator.pop(context);
                            
                            Navigator.pushNamedAndRemoveUntil(context, 'home', (route) => false, arguments:user );
                                            }
                }, child: const AppText(data: 'Login',color: Color(0xffe5e5e5),fw: FontWeight.w600,)),
                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    
                    const AppText(data: 'Dont have an Account?',color: Color(0xffe5e5e5),),
                    const SizedBox(width: 10,),
                    InkWell(
                      onTap: (){
                        Navigator.pushNamed(context, 'register');
                      },
                      child: const AppText(data: 'Register',color: Color(0xffe5e5e5),))
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }
}