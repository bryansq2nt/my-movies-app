import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movies_app/src/blocs/auth/auth_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  void login(AuthenticationBloc authBloc) {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      authBloc.add(LoginRequestedEvent(
          email: emailController.text,
          password: passwordController.text,
          context: context));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SingleChildScrollView(
          child:
              Padding(padding: const EdgeInsets.all(8.0), child: _loginForm()),
        ),
      ),
    );
  }

  _loginForm() {
    Size size = MediaQuery.of(context).size;
    final authBloc = BlocProvider.of<AuthenticationBloc>(context);
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Image.asset(
              "assets/images/login.png",
              height: size.height * 0.3,
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
                enabled: authBloc.state is LoginLoadingState ? false : true,
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "email can't be empty";
                  }
                  return null;
                },
                onEditingComplete: () => FocusScope.of(context).nextFocus(),
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Colors.white)),
                style: const TextStyle(height: 0.5, color: Colors.white)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
                enabled: authBloc.state is LoginLoadingState ? false : true,
                controller: passwordController,
                obscureText: true,
                obscuringCharacter: "*",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "password can't be empty";
                  }
                  return null;
                },
                onEditingComplete: () => login(authBloc),
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Colors.white)),
                style: const TextStyle(height: 0.5, color: Colors.white)),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ElevatedButton(
                    child: const Text("Signin",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    style:
                        ElevatedButton.styleFrom(fixedSize: const Size(0, 60)),
                    onPressed: authBloc.state is LoginLoadingState
                        ? null
                        : () => login(authBloc),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
