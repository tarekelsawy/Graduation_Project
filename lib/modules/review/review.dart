import 'package:corona_test_project/modules/edit_profile_screen/edit_profile_screen.dart';
import 'package:corona_test_project/modules/sidebar_screen/sidebar_screen.dart';
import 'package:corona_test_project/shared/components/constants.dart';
import 'package:corona_test_project/shared/cubit/cubit.dart';
import 'package:corona_test_project/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/components/components.dart';

TextEditingController reviewController = TextEditingController();

class ReviewScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CoronaCubit, CoronaStates>(
      listener: (context, state) {
        if (state is CoronaUploadFeedbackToFirebaseSuccessState) {
          showToast(
              message: 'Your Feedback Uploaded Successfully',
              toastStatus: ToastStatus.SUCCESS);
        }
      },
      builder: (context, state) {
        CoronaCubit cubit = CoronaCubit.get(context);
        return Scaffold(
          drawer: SideBarScreen(),
          appBar: AppBar(
            title: Title(
              color: colorYellow,
              child: Text('Review'),
            ),
          ),
          body: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    TextFormField(
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: colorWhite),
                      controller: reviewController,
                      minLines: 6,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      showCursor: true,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'required field!';
                        }
                      },
                      onTap: () {},
                      decoration: InputDecoration(
                        labelText: 'Type Your Review Here',
                        labelStyle: TextStyle(
                          fontSize: 12,
                          color: isDark ? colorWhite : colorBlack,
                          fontWeight: FontWeight.bold,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(
                            width: 2,
                            style: BorderStyle.none,
                          ),
                        ),
                        filled: true,
                        fillColor:
                            Color.fromARGB(255, 215, 205, 205).withOpacity(0.1),
                        contentPadding: EdgeInsets.all(20.0),
                      ),
                      cursorColor: isDark ? colorYellow : colorPurple,
                    ),
                    SizedBox(height: 60.0),
                    state is! CoronaUploadReviewToPythonLoadingState
                        ? Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: isDark ? colorBlack : colorPurple,
                              borderRadius: BorderRadius.all(
                                Radius.circular(50),
                              ),
                              border: Border.all(
                                color: isDark ? colorYellow : colorPurple,
                                width: 2,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: isDark
                                      ? Color.fromARGB(255, 117, 105, 51)
                                      : colorPurple.withOpacity(0.9),
                                  spreadRadius: 1.0,
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: MaterialButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  print(reviewController.text);
                                  cubit.sendReview(reviewController.text);
                                }
                              },
                              child: Text(
                                'Review',
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      color: isDark ? colorYellow : colorWhite,
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              elevation: 25.0,
                              highlightElevation: 10.0,
                            ),
                          )
                        : Center(
                            child: CircularProgressIndicator(),
                          ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
