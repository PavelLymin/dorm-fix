import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui.dart';
import '../../../app/model/application_config.dart';
import 'signin_form.dart';
import '../state_management/authentication/authentication_bloc.dart';
part 'auth_validate.dart';

@RoutePage()
class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn>
    with _EmailPasswordPhoneNumberFormStateMixin {
  final _emailFocusNode = FocusNode();
  final _phoneFocusNode = FocusNode();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  bool _isValidateEmail = false;
  bool _isValidatePassword = false;
  bool _isValidatePhone = false;

  @override
  void initState() {
    super.initState();
    _onEmailChanged();
    _onPasswordChanged();
    _onPhoneChanged();
  }

  void _onEmailChanged() {
    _emailController.addListener(() {
      if (_validateEmail(_emailController.text) && !_isValidateEmail) {
        setState(() {
          _isValidateEmail = true;
        });
      } else if (!_validateEmail(_emailController.text) && _isValidateEmail) {
        setState(() {
          _isValidateEmail = false;
        });
      }
    });
  }

  void _onPasswordChanged() {
    _passwordController.addListener(() {
      if (_validatePassword(_passwordController.text) && !_isValidatePassword) {
        setState(() {
          _isValidatePassword = true;
        });
      } else if (!_validatePassword(_passwordController.text) &&
          _isValidatePassword) {
        setState(() {
          _isValidatePassword = false;
        });
      }
    });
  }

  void _onPhoneChanged() {
    _phoneController.addListener(() {
      if (_validatePhoneNumber(_phoneController.text) && !_isValidatePhone) {
        setState(() {
          _isValidatePhone = true;
        });
      } else if (!_validatePhoneNumber(_phoneController.text) &&
          _isValidatePhone) {
        setState(() {
          _isValidatePhone = false;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _emailFocusNode.dispose();
    _phoneFocusNode.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }

  // Scaffold(
  //   body: BlocListener<AuthenticationBloc, AuthenticationState>(
  //     listener: (context, state) {
  //       state.mapOrNull(
  //         authenticated: (_) => context.router.replace(NamedRoute('Home')),
  //         error: (error) => ScaffoldMessenger.of(
  //           context,
  //         ).showSnackBar(SnackBar(content: Text(error.message))),
  //       );
  //     },
  //     child: SafeArea(
  //       child: Center(
  //         child: LayoutBuilder(
  //           builder: (context, constraints) => SingleChildScrollView(
  //             child: switch (constraints.maxWidth) {
  //               final width when width < 656 => Padding(
  //                 padding: EdgeInsets.only(
  //                   left: constraints.maxWidth > 528
  //                       ? (constraints.maxWidth - (400 + 64))
  //                       : 40,
  //                   right: 40,
  //                 ),
  //                 child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.center,
  //                   children: [
  //                     SignInForm(
  //                       emailFocusNode: _emailFocusNode,
  //                       phoneFocusNode: _phoneFocusNode,
  //                       emailController: _emailController,
  //                       passwordController: _passwordController,
  //                       phoneController: _phoneController,
  //                     ),
  //                     const SizedBox(height: 32),
  //                     BaseButton(
  //                       onPressed: () {
  //                         _signInWithEmailAndPassword(
  //                           _emailController.text,
  //                           _passwordController.text,
  //                         );
  //                       },
  //                       isEnable:
  //                           _isValidateEmail && _isValidatePassword ||
  //                           _isValidatePhone,
  //                       widget:
  //                           BlocBuilder<
  //                             AuthenticationBloc,
  //                             AuthenticationState
  //                           >(
  //                             builder: (context, state) {
  //                               return state.maybeMap(
  //                                 orElse: () => const Text('Continue'),
  //                                 loading: (_) => const Center(
  //                                   child: CircularProgressIndicator(),
  //                                 ),
  //                               );
  //                             },
  //                           ),
  //                     ),
  //                     const SizedBox(height: 32),
  //                     // const AuthWithSocial(),
  //                   ],
  //                 ),
  //               ),
  //               _ => Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   Padding(
  //                     padding: EdgeInsets.symmetric(
  //                       horizontal: (constraints.maxWidth - 656) / 2,
  //                     ),
  //                     child: const Image(
  //                       image: AssetImage('assets/icons/microsoft.png'),
  //                     ),
  //                   ),
  //                   Flexible(
  //                     child: Padding(
  //                       padding: EdgeInsets.symmetric(horizontal: 40),
  //                       child: Column(
  //                         children: [
  //                           SignInForm(
  //                             emailFocusNode: _emailFocusNode,
  //                             phoneFocusNode: _phoneFocusNode,
  //                             emailController: _emailController,
  //                             passwordController: _passwordController,
  //                             phoneController: _phoneController,
  //                           ),
  //                           const SizedBox(height: 32),
  //                           BaseButton(
  //                             onPressed: () {
  //                               _signInWithEmailAndPassword(
  //                                 _emailController.text,
  //                                 _passwordController.text,
  //                               );
  //                             },
  //                             isEnable:
  //                                 _isValidateEmail & _isValidatePassword ||
  //                                 _isValidatePhone,
  //                             widget:
  //                                 BlocBuilder<
  //                                   AuthenticationBloc,
  //                                   AuthenticationState
  //                                 >(
  //                                   builder: (context, state) {
  //                                     return state.isLoading
  //                                         ? const Center(
  //                                             child:
  //                                                 CircularProgressIndicator(),
  //                                           )
  //                                         : const Text('Continue');
  //                                   },
  //                                 ),
  //                           ),
  //                           const SizedBox(height: 32),
  //                           // const AuthWithSocial(),
  //                         ],
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             },
  //           ),
  //         ),
  //       ),
  //     ),
  //   ),
  // );
}
