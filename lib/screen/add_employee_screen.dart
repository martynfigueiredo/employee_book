import 'package:flutter/material.dart';
import '../widget/custom_text_form_field.dart';

class AddEmployeeScreen extends StatefulWidget {
  const AddEmployeeScreen({Key? key}) : super(key: key);

  @override
  State<AddEmployeeScreen> createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Employee"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: (){
                //TODO

              },
              icon: const Icon(Icons.save))
        ],
      ),
      body: Column(
        children: [
          CustomTextFormField(controller: _userNameController, txtLable: "User Name",),
          const SizedBox(height: 8.0,),
          CustomTextFormField(controller: _firstNameController, txtLable: "First Name",),
          const SizedBox(height: 8.0,),
          CustomTextFormField(controller: _lastNameController, txtLable: "Last Name",),
          const SizedBox(height: 8.0,),
          CustomTextFormField(controller: _dateOfBirthController, txtLable: "Date of Birth",),
          const SizedBox(height: 8.0,),
        ],
      ),
    );
  }
}


