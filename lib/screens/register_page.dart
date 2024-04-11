import 'package:fazfinance/models/user_model.dart';
import 'package:fazfinance/services/auth_service.dart';
import 'package:fazfinance/widgets/appbutton.dart';
import 'package:fazfinance/widgets/apptext.dart';
import 'package:fazfinance/widgets/customtextformfiled.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegistePageState();
}

class _RegistePageState extends State<RegisterPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _regKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Scaffold(
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          height: double.infinity,
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          child: Form(
              key: _regKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const AppText(
                      data: "Create an Account",
                      color: Colors.white,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextFormField(
                        controller: _nameController, hintText: 'Enter Name'),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextFormField(
                        controller: _phoneController, hintText: 'Phone no'),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextFormField(
                        controller: _emailController, hintText: 'Enter Email'),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextFormField(
                        controller: _passwordController,
                        hintText: 'Enter Password'),
                    const SizedBox(
                      height: 20,
                    ),
                    AppButton(
                        height: 48,
                        width: 250,
                        color: const Color(0xfffca311),
                        onTap: () async {
                          var uuid = const Uuid().v1();
                          if (_regKey.currentState!.validate()) {
                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                });
                                UserModel user = 
                                UserModel(
                                  id: uuid,
                                  email: _emailController.text.trim(), 
                                password: _passwordController.text.trim(), 
                                name: _nameController.text.trim(), 
                                phoneno: _phoneController.text.trim(), 
                                status: 1);
                                final res = await authService.registerUser(user);
                                Navigator.pop(context);
                                if(res == true){
                                  Navigator.pop(context);
                                }
                          }
                        },
                        child: const AppText(
                          data: 'Register',
                          color: Color(0xffe5e5e5),
                          fw: FontWeight.w600,
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const AppText(
                          data: 'Already have an Account?',
                          color: Color(0xffe5e5e5),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, 'login');
                            },
                            child: const AppText(
                              data: 'Login',
                              color: Color(0xffe5e5e5),
                            ))
                      ],
                    )
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
