import 'package:expermed_test/app/ui/components/gradient_input_border.component.dart';
import 'package:expermed_test/app/ui/components/linear_gradient_button.component.dart';
import 'package:expermed_test/app/ui/constants/spacing.dart';
import 'package:expermed_test/app/ui/views/auth/sign_in/sign_in.bloc.dart';
import 'package:expermed_test/app/ui/components/top_snack_bar_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';


import 'sign_in.events.dart';

class SignInView extends StatefulWidget {

  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  late final SignInBloc _signInBloc;
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  bool _passwordVisible = true;

  @override
  void initState() {
    super.initState();
    _signInBloc = SignInBloc();
  }

  @override
  void dispose() {
    super.dispose();
    _signInBloc.close();
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
            child: Column(
              children: [
                Expanded(
                  child: BlocConsumer<SignInBloc, SignInState>(
                    bloc: _signInBloc,
                    listener: (context, state) {
                      if (state is SuccessfulSignInState) {
                        context.push('/medical-examinations');
                      }
                      if (state is FailedSignInState) {
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
                          const SizedBox(height: 8),
                          const SizedBox(
                            width: double.infinity,
                            child: Text('Esqueci minha senha', textAlign: TextAlign.end,),
                          ),
                          const SizedBox(height: kPadding*2),
                          LinearGradientButton(
                            key: const Key('sign_in_button'),
                            onPressed: () => _signInBloc.add(
                              SendSignInState(
                                _emailTextController.text,
                                _passwordTextController.text,
                              ),
                            ),
                            child: const Text(
                              'Acessar',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ],
                      );
                    }
                  ),
                ),
                TextButton(
                  onPressed: () => context.push('/sign-up'),
                  child: const Text('Não é registrado ainda? Se cadastre aqui'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    showTopSnackBar(
      Overlay.of(context),
      TopSnackBar(message: message, key: const Key('sign_in_error_modal'),),
      animationDuration: const Duration(milliseconds: 1000),
      reverseAnimationDuration: const Duration(milliseconds: 500),
      // curve: Curves.easeInOut,
      // reverseCurve: Curves.easeInOut,
    );
  }
}
