import 'package:expermed_test/app/ui/components/gradient_input_border.component.dart';
import 'package:expermed_test/app/ui/components/linear_gradient_button.component.dart';
import 'package:expermed_test/app/ui/constants/spacing.dart';
import 'package:expermed_test/app/ui/views/auth/sign_in/sign_in.bloc.dart';
import 'package:expermed_test/app/ui/components/top_snack_bar_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';


import 'sign_up.bloc.dart';
import 'sign_up.events.dart';

class SignUpView extends StatefulWidget {

  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  late final SignUpBloc _signUpBloc;
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final _nameTextController = TextEditingController();
  bool _passwordVisible = true;

  @override
  void initState() {
    super.initState();
    _signUpBloc = SignUpBloc();
  }

  @override
  void dispose() {
    super.dispose();
    _signUpBloc.close();
    _emailTextController.dispose();
    _passwordTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(kPadding),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: BlocConsumer<SignUpBloc, SignUpState>(
              bloc: _signUpBloc,
              listener: (context, state) {
                if (state is SuccessfulSignUpState) {
                  context.pop();
                }
                if (state is FailedSignUpState) {
                  _showSnackBar(context, state.message);
                }
              },
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/logo_expermed.png'),
                    const SizedBox(height: kPadding*2),
                    GradientBorder(
                      child: TextFormField(
                        key: const Key('name_field'),
                        keyboardType: TextInputType.name,
                        controller: _nameTextController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          prefixIcon:  const Padding(
                            padding: EdgeInsets.all(kPadding),
                            child: Icon(Icons.person),
                          ),
                          hintText: 'Name',
                        ),
                      ),
                    ),
                    const SizedBox(height: kPadding),
                    GradientBorder(
                      child: TextFormField(
                        key: const Key('email_field'),
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailTextController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          prefixIcon:  const Padding(
                            padding: EdgeInsets.all(kPadding),
                            child: Icon(Icons.person_outline_rounded),
                          ),
                          hintText: 'E-mail',
                        ),
                      ),
                    ),
                    const SizedBox(height: kPadding),
                    GradientBorder(
                      child: StatefulBuilder(
                        builder: (context, setState) {
                          return TextFormField(
                            key: const Key('password_field'),
                            keyboardType: TextInputType.visiblePassword,
                            controller: _passwordTextController,
                            obscureText: _passwordVisible,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              prefixIcon:  const Padding(
                                padding: EdgeInsets.all(kPadding),
                                child: Icon(Icons.key_outlined),
                              ),
                            suffixIcon: Padding(
                                padding: const EdgeInsets.all(kPadding),
                                child: InkWell(
                                  onTap: () => setState(() => _passwordVisible = !_passwordVisible),
                                  child: Icon(_passwordVisible ? Icons.visibility_outlined : Icons.visibility_off_outlined),
                                ),
                              ),
                              hintText: 'Password',
                            ),
                          );
                        }
                      ),
                    ),

                    const SizedBox(height: kPadding*2),
                    LinearGradientButton(
                      onPressed: _sendSignUpRequest,
                      child: const Text(
                        'Enviar',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  void _sendSignUpRequest() {
    _signUpBloc.add(
      SendSignUpState(
        email: _emailTextController.text,
        password: _passwordTextController.text,
        name: _nameTextController.text,
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    showTopSnackBar(
      Overlay.of(context),
      TopSnackBar(message: message, key: const Key('sign_in_error_modal'),),
      animationDuration: const Duration(milliseconds: 1000),
      reverseAnimationDuration: const Duration(milliseconds: 500),
    );
  }
}
