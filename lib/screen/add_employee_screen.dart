import 'package:employee_book/widget/custom_date_picker_form_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../data/local/db/app_db.dart';
import '../widget/custom_text_form_field.dart';
import 'package:drift/drift.dart' as drift;

class AddEmployeeScreen extends StatefulWidget {
  const AddEmployeeScreen({Key? key}) : super(key: key);

  @override
  State<AddEmployeeScreen> createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {
  late AppDb _db;
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  DateTime? _dateOfBirth;

  @override
  void initState() {
    super.initState();
    _db = AppDb();
  }

  @override
  void dispose() {
    _db.close();
    _userNameController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _dateOfBirthController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Employee"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                addEmployee();
              },
              icon: const Icon(Icons.save))
        ],
      ),
      body: Column(
        children: [
          CustomTextFormField(
            controller: _userNameController,
            txtLable: "User Name",
          ),
          const SizedBox(
            height: 8.0,
          ),
          CustomTextFormField(
            controller: _firstNameController,
            txtLable: "First Name",
          ),
          const SizedBox(
            height: 8.0,
          ),
          CustomTextFormField(
            controller: _lastNameController,
            txtLable: "Last Name",
          ),
          const SizedBox(
            height: 8.0,
          ),
          CustomDatePickerFormField(
              controller: _dateOfBirthController,
              txtLabel: "Date of Birth",
              callback: () {
                pickDateOfBirth(context);
              }),
          const SizedBox(
            height: 8.0,
          ),
        ],
      ),
    );
  }

  Future<void> pickDateOfBirth(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: _dateOfBirth ?? initialDate,
      firstDate: DateTime(DateTime.now().year - 100),
      lastDate: DateTime(DateTime.now().year + 1),
      builder: (context, child) => Theme(
        data: ThemeData().copyWith(
            colorScheme: const ColorScheme.light(
                primary: Colors.pink,
                onPrimary: Colors.white,
                onSurface: Colors.black),
            dialogBackgroundColor: Colors.white),
        child: child ?? const Text(""),
      ),
    );

    if (newDate == null) {
      return;
    }

    setState(() {
      _dateOfBirth = newDate;
      String dob = DateFormat("dd/MM/yyyy").format(newDate);
      _dateOfBirthController.text = dob;
    });
  }

  void addEmployee() {
    final entity = EmployeeCompanion(
      userName: drift.Value(_userNameController.text),
      firstName: drift.Value(_userNameController.text),
      lastName: drift.Value(_userNameController.text),
      dateOfBirth: drift.Value(_dateOfBirth!),
    );

    _db.insertEmployee(entity).then(
          (value) => ScaffoldMessenger.of(context).showMaterialBanner(
            MaterialBanner(
                backgroundColor: Colors.pink,
                content: Text(
                  'New employee inserted: $value',
                  style: const TextStyle(color: Colors.white),
                ),
                actions: [
                  TextButton(
                      onPressed: () => ScaffoldMessenger.of(context)
                          .hideCurrentMaterialBanner(),
                      child: const Text(
                        'Close',
                        style: TextStyle(color: Colors.white),
                      )),
                ]),
          ),
        );
  }
}
