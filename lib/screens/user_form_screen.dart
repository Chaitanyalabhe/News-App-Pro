import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/form_bloc.dart' as form_bloc;
import 'news_list_screen.dart';

class UserFormScreen extends StatelessWidget {
  const UserFormScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => form_bloc.FormBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('User Form'),
        ),
        body: const UserForm(),
      ),
    );
  }
}

class UserForm extends StatefulWidget {
  const UserForm({Key? key}) : super(key: key);

  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            _buildTextField(_nameController, 'Name', 'Enter your name'),
            _buildTextField(_emailController, 'Email', 'Enter your email',
                validator: (value) {
                  if (value == null || !value.contains('@')) {
                    return 'Enter a valid email';
                  }
                  return null;
                }),
            _buildTextField(
              _phoneController,
              'Phone',
              'Enter your phone number',
              validator: (value) {
                if (value == null || value.length != 10) {
                  return 'Enter a valid 10-digit phone number';
                }
                return null;
              },
            ),
            _buildTextField(_genderController, 'Gender', 'Enter your gender'),
            _buildTextField(_countryController, 'Country', 'Enter your country'),
            _buildTextField(_stateController, 'State', 'Enter your state'),
            _buildTextField(_cityController, 'City', 'Enter your city'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final formData = {
                    'name': _nameController.text,
                    'email': _emailController.text,
                    'phone': _phoneController.text,
                    'gender': _genderController.text,
                    'country': _countryController.text,
                    'state': _stateController.text,
                    'city': _cityController.text,
                  };

                  // Submit form data
                  context.read<form_bloc.FormBloc>().add(
                      form_bloc.SubmitFormEvent(formData));

                  // Show success message
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Form Submitted')),
                  );

                  // Navigate to news_list_screen.dart
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => NewsListScreen()),
                        (Route<dynamic> route) => false,
                  );
                }
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller,
      String label,
      String hint, {
        String? Function(String?)? validator,
      }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
        ),
        validator: validator,
      ),
    );
  }
}