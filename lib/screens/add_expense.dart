
import 'package:fazfinance/constants/colors.dart';
import 'package:fazfinance/models/expense_model.dart';
import 'package:fazfinance/services/fin_service.dart';
import 'package:fazfinance/widgets/appbutton.dart';
import 'package:fazfinance/widgets/apptext.dart';
import 'package:fazfinance/widgets/customtextformfiled.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AddExpensePage extends StatefulWidget {
  final uid;
  const AddExpensePage({super.key,this.uid});

  @override
  State<AddExpensePage> createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  String? category;

  final _expeKey = GlobalKey<FormState>();
  var expenseCategories = [
    'Housing',
    'Transportation',
    'Food and Groceries',
    'Healthcare',
    'Debt Payments',
    'Entertainment',
    'Personal Care',
    'Clothing and Accessories',
    'Utilities and Bills',
    'Savings and Investments',
    'Education',
    'Travel',
  ];

  @override
  Widget build(BuildContext context) {

    final userService=Provider.of<UserService>(context);
    final String userid=ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(

      appBar: AppBar(
        title: const AppText(data: "Add Expense",),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _expeKey,
          child: Column(
            children: [
              DropdownButtonFormField(
                dropdownColor: scaffoldColor,
                style: const TextStyle(color: Colors.white),
                value: category, // Add this line to set the current value
                onChanged: (value) {
                  setState(() {
                    category = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Select a category';
                  }
                  return null; // Return null if validation succeeds
                },
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.white),
                  ),
                  hintStyle: const TextStyle(color: Colors.white),
                  hintText: "Select Category",
                ),
                items: expenseCategories
                    .map((item) => DropdownMenuItem(
                  value: item,
                  child: AppText(data: item),
                ))
                    .toList(),
              ),

              const SizedBox(
                height: 20,
              ),
              CustomTextFormField(
          
                  validator: (value){
          
                    if(value!.isEmpty){
                      return "Description is Mandatory";
                    }
                    return null;
                  },
                  controller:_descController, hintText: "Description")
             , const SizedBox(
                height: 20,
              ),
              CustomTextFormField(
                type: TextInputType.number,
                  validator: (value){
          
                    if(value!.isEmpty){
                      return "Enter a Valid Amount";
                    }
                    return null;
                  },
                  controller: _amountController, hintText: "Enter the Amount"),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: AppButton(
                    height: 48,
                    width: 250,
                    color: Colors.deepOrange,
                    onTap: () async{
                      

                      var uuid=const Uuid().v1();
          
                       if (_expeKey.currentState!.validate()) {

                        ExpenseModel exp=ExpenseModel(
                            id: uuid,
                            uid: userid,
                            amount: double.parse(_amountController.text),
                            description: _descController.text,
                            category:  category.toString(),
                            createdAt: DateTime.now());



                        userService.addExpense(exp);

                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content: Lottie.asset('assets/json/success.json'),
                            );
                          },
                        );



                      
                        Future.delayed(const Duration(seconds: 4), () {
                          Navigator.pop(context);
                        }).then((value) => Navigator.pop(context));

                      } 
                    },
                    child: const AppText(
                      data: "Add Expense",
                      color: Colors.white,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}