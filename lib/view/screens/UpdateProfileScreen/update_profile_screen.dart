import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager/utils/app_color.dart';
import 'package:task_manager/view/utility/validate_checking_fun.dart';
import 'package:task_manager/view/widgets/background_widget.dart';
import 'package:task_manager/view/widgets/elevated_icon_button.dart';
import 'package:task_manager/view/widgets/one_button_dialog.dart';
import 'inner/photo_picker_widget.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final TextEditingController _emailTextEditingController = TextEditingController();
  final TextEditingController _firstNameTextEditingController = TextEditingController();
  final TextEditingController _lastNameTextEditingController = TextEditingController();
  final TextEditingController _mobileTextEditingController = TextEditingController();
  final TextEditingController _passwordTextEditingController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _obscureText = true;

  final ImagePicker _imagePicker = ImagePicker();
  XFile? _selectedImage;

  Future<void> pickImage() async {
    final XFile? pickedFile = await _imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = pickedFile;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Profile"),
      ),
      body: BackgroundWidget(
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.only(left: 35, right: 35),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 70,
                  ),

                  ///------Update profile text------///
                  Text(
                    "Update Profile",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        ///------photo picker field------///
                        photoPickerWidget(
                          () => pickImage(),
                          _selectedImage?.name,
                        ),
                        const SizedBox(
                          height: 10,
                        ),

                        ///------email text form field------///
                        TextFormField(
                          controller: _emailTextEditingController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            hintText: 'Email',
                          ),
                          validator: (String? value) {
                            return ValidateCheckingFun.validateEmail(value);
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),

                        ///------First text form field------///
                        TextFormField(
                          controller: _firstNameTextEditingController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.name,
                          decoration: const InputDecoration(
                            hintText: 'First Name',
                          ),
                          validator: (String? value) {
                            return ValidateCheckingFun.validateFirstName(value);
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),

                        ///------Last name text form field------///
                        TextFormField(
                          controller: _lastNameTextEditingController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.name,
                          decoration: const InputDecoration(
                            hintText: 'Last Name',
                          ),
                          validator: (String? value) {
                            return ValidateCheckingFun.validateFirstName(value);
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),

                        ///------Mobile text form field------///
                        TextFormField(
                          controller: _mobileTextEditingController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            hintText: 'Mobile',
                          ),
                          validator: (String? value) {
                            return ValidateCheckingFun.validateNumber(value);
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),

                        ///------Password text form field------///
                        TextFormField(
                          controller: _passwordTextEditingController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: _obscureText,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                              icon: Icon(
                                _obscureText ? Icons.visibility : Icons.visibility_off,
                                color: AppColor.grey,
                              ),
                            ),
                          ),
                          validator: (String? value) {
                            return ValidateCheckingFun.validateNumber(value);
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),

                        ///------Update button------///
                        ElevatedIconButton(
                          icon: Icons.arrow_circle_right_outlined,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              oneButtonDialog(
                                context,
                                AppColor.themeColor,
                                AppColor.themeColor,
                                "Update Success!",
                                "Your profile information update successfully.",
                                Icons.task_alt,
                                () {
                                  Navigator.pop(context);
                                },
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
