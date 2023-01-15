import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:jomhack/models/assestment.dart';
import 'package:jomhack/services/auth_service.dart';
import 'package:jomhack/templates/custom_widgets.dart';
import 'package:jomhack/themes/colors.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class AssestmentPage extends StatefulWidget {
  const AssestmentPage({super.key});

  @override
  State<AssestmentPage> createState() => _AssestmentPageState();
}

class _AssestmentPageState extends State<AssestmentPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _jobController = TextEditingController();
  final TextEditingController _conditionController = TextEditingController();
  final TextEditingController _familyHistoryController =
      TextEditingController();

  final FocusNode _ageFocus = FocusNode();
  final FocusNode _jobFocus = FocusNode();
  final FocusNode _conditionFocus = FocusNode();
  final FocusNode _familyHistoryFocus = FocusNode();

  bool? smoker = false;
  bool? married = false;

  bool isSaving = false;

  @override
  Widget build(BuildContext context) {
    AuthService auth = Provider.of(context, listen: false);
    return Stack(
      children: [
        GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
            child: Form(
              key: _formKey,
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  customTextFormField(
                    controller: _ageController,
                    focusNode: _ageFocus,
                    hintText: 'Age',
                    inputType: TextInputType.number,
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'Insert age';
                      } else if (int.tryParse(text) == null) {
                        return 'Insert number as age value';
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: 1.h),
                  RadioListTile(
                    title: const Text('Smoker'),
                    value: true,
                    groupValue: smoker,
                    selected: smoker == true,
                    onChanged: (value) {
                      setState(() {
                        smoker = value;
                      });
                    },
                  ),
                  RadioListTile(
                    title: const Text('Non-smoker'),
                    value: false,
                    groupValue: smoker,
                    selected: smoker == false,
                    onChanged: (value) {
                      setState(() {
                        smoker = value;
                      });
                    },
                  ),
                  SizedBox(height: 1.h),
                  customTextFormField(
                    controller: _jobController,
                    focusNode: _jobFocus,
                    hintText: 'Job Description',
                    validator: (text) => text == null || text.isEmpty
                        ? 'Insert job description'
                        : null,
                  ),
                  SizedBox(height: 1.h),
                  customTextFormField(
                    controller: _conditionController,
                    focusNode: _conditionFocus,
                    hintText: 'Tell us about any pre-existing conditions',
                    validator: (text) => text == null || text.isEmpty
                        ? 'Insert pre-existing conditions or \'-\' if none'
                        : null,
                  ),
                  SizedBox(height: 1.h),
                  customTextFormField(
                    controller: _familyHistoryController,
                    focusNode: _familyHistoryFocus,
                    hintText: 'Family History',
                    validator: (text) => text == null || text.isEmpty
                        ? 'Insert family history or \'-\' if none'
                        : null,
                  ),
                  RadioListTile(
                    title: Text('Married'),
                    value: true,
                    selected: married == true,
                    groupValue: married,
                    onChanged: (value) {
                      setState(() {
                        married = value;
                      });
                    },
                  ),
                  RadioListTile(
                    title: Text('Not married'),
                    value: false,
                    selected: married == false,
                    groupValue: married,
                    onChanged: (value) {
                      setState(() {
                        married = value;
                      });
                    },
                  ),
                  SizedBox(height: 1.h),
                  customTextButton(
                    label: 'Submit',
                    onPressed: () async {
                      FocusScope.of(context).unfocus();
                      setState(() {
                        isSaving = true;
                      });
                      if (_formKey.currentState!.validate()) {
                        await auth.submitAssestment(
                            assestment: Assestment(
                          age: int.parse(_ageController.text),
                          jobDescription: _jobController.text,
                          existingCondition: _conditionController.text,
                          familyHistory: _familyHistoryController.text,
                          smoker: smoker,
                          married: married,
                        ));
                      }

                      setState(() {
                        isSaving = false;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        isSaving
            ? Container(
                alignment: Alignment.center,
                color: AppColor.background.withOpacity(0.3),
                child: SpinKitFadingCube(
                  color: AppColor.tertiary,
                  size: 30.sp,
                ),
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}
