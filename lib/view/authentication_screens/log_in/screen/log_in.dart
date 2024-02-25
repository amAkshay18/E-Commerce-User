// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// final _firebase = FirebaseAuth.instance;

// class ScreenLogin extends StatefulWidget {
//   const ScreenLogin({super.key});

//   @override
//   State<ScreenLogin> createState() => _ScreenLoginState();
// }

// class _ScreenLoginState extends State<ScreenLogin> {
//   final _form = GlobalKey<FormState>();
//   var _isLogin = true;
//   var _enteredEmail = '';
//   var _enteredPassword = '';
//   // var _isAuthenticating = false;
//   void _submit() async {
//     final isValid = _form.currentState!.validate();

//     if (!isValid) {
//       return;
//     }
//     _form.currentState!.save();
//     try {
//       if (_isLogin) {
//         // ignore: unused_local_variable
//         final userCredential = await _firebase.signInWithEmailAndPassword(
//             email: _enteredEmail, password: _enteredPassword);
//       } else {
//         // ignore: unused_local_variable
//         final userCredentials = await _firebase.createUserWithEmailAndPassword(
//             email: _enteredEmail, password: _enteredPassword);
//       }
//     } on FirebaseAuthException catch (error) {
//       if (error.code == 'email-already-in-use') {}
//       // ignore: use_build_context_synchronously
//       ScaffoldMessenger.of(context).clearSnackBars();
//       // ignore: use_build_context_synchronously
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(error.message ?? 'Authentication faild'),
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: Center(
//           child: SingleChildScrollView(
//             child: Form(
//               key: _form,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Row(
//                     children: [
//                       Padding(
//                         padding: EdgeInsets.only(left: 15.0),
//                         child: Text(
//                           'Welcome to ',
//                           style: TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                       Text(
//                         'LeafLoom',
//                         style: TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.green),
//                       ),
//                     ],
//                   ),
//                   const Padding(
//                     padding: EdgeInsets.only(left: 15.0),
//                     child: Text(
//                       'Log in or Sign up to continue',
//                       style: TextStyle(),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(left: 15.0, right: 15),
//                     child: TextFormField(
//                       decoration:
//                           const InputDecoration(labelText: 'Email Address'),
//                       keyboardType: TextInputType.emailAddress,
//                       autocorrect: false,
//                       textCapitalization: TextCapitalization.none,
//                       validator: (value) {
//                         if (value == null ||
//                             value.trim().isEmpty ||
//                             !value.contains('@')) {
//                           return 'Please enter a valid email address.';
//                         }

//                         return null;
//                       },
//                       onSaved: (value) {
//                         _enteredEmail = value!;
//                       },
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(left: 15.0, right: 15),
//                     child: TextFormField(
//                       decoration: const InputDecoration(labelText: 'Password'),
//                       obscureText: true,
//                       validator: (value) {
//                         if (value == null || value.trim().length < 6) {
//                           return 'Password must be at least 6 characters long.';
//                         }
//                         return null;
//                       },
//                       onSaved: (value) {
//                         _enteredPassword = value!;
//                       },
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   Center(
//                     child: Column(
//                       children: [
//                         ElevatedButton(
//                           onPressed: _submit,
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.green,
//                           ),
//                           child: Text(_isLogin ? 'Login' : 'Signup'),
//                         ),
//                         TextButton(
//                           onPressed: () {
//                             setState(
//                               () {
//                                 _isLogin = !_isLogin;
//                               },
//                             );
//                           },
//                           child: Text(_isLogin
//                               ? 'Create an account'
//                               : 'I already have an account'),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _firebase = FirebaseAuth.instance;

class ScreenLogin extends StatefulWidget {
  const ScreenLogin({Key? key}) : super(key: key);

  @override
  State<ScreenLogin> createState() => _ScreenLoginState();
}

final _nameController = TextEditingController();
final _emailController = TextEditingController();
final _passwordController = TextEditingController();
final _confirmPasswordController = TextEditingController();

class _ScreenLoginState extends State<ScreenLogin> {
  final _form = GlobalKey<FormState>();
  var _isLogin = true;
  var _enteredEmail = '';
  var _enteredPassword = '';

  recoverPasswordByMail() async {
    await _firebase.sendPasswordResetEmail(email: 'akshayfabz321@gmail.com');
  }

  void _submit() async {
    final isValid = _form.currentState!.validate();

    if (!isValid) {
      return;
    }
    _form.currentState!.save();
    try {
      if (_isLogin) {
        final userCredential = await _firebase.signInWithEmailAndPassword(
            email: _enteredEmail, password: _enteredPassword);
      } else {
        final userCredentials = await _firebase.createUserWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim());
        // userCredentials.user!.uid
      }
    } on FirebaseAuthException catch (error) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.message ?? 'Authentication failed'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Form(
                key: _form,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Welcome to ',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'LeafLoom',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                        Icon(
                          Icons.eco,
                          color: Colors.green,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      _isLogin ? 'Log in to continue' : 'Sign up to continue',
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 20),
                    Visibility(
                      visible: !_isLogin,
                      child: TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          labelText: 'Name',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        textCapitalization: TextCapitalization.none,
                        // validator: (value) {
                        //   if (value == null ||
                        //       value.trim().isEmpty ||
                        //       !value.contains('@')) {
                        //     return 'Please enter a valid email address.';
                        //   }

                        //   return null;
                        // },
                        onSaved: (value) {
                          _enteredEmail = value!;
                        },
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email Address',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: false,
                      textCapitalization: TextCapitalization.none,
                      validator: (value) {
                        if (value == null ||
                            value.trim().isEmpty ||
                            !value.contains('@')) {
                          return 'Please enter a valid email address.';
                        }

                        return null;
                      },
                      onSaved: (value) {
                        _enteredEmail = value!;
                      },
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      controller: _passwordController,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(),
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.trim().length < 6) {
                          return 'Password must be at least 6 characters long.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _enteredPassword = value!;
                      },
                    ),
                    const SizedBox(height: 20),
                    Visibility(
                      visible: !_isLogin,
                      child: TextFormField(
                        controller: _confirmPasswordController,
                        decoration: const InputDecoration(
                          labelText: 'Confirm Password',
                          border: OutlineInputBorder(),
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.trim().length < 6) {
                            return 'Password must be at least 6 characters long.';
                          } else if (value != _passwordController.text) {
                            return 'Password doesnot matching';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _enteredPassword = value!;
                        },
                      ),
                    ),
                    Visibility(
                      visible: _isLogin,
                      child: TextButton(
                        onPressed: () async {
                          recoverPasswordByMail();
                        },
                        child: const Text('Forgot password'),
                      ),
                    ),
                    const SizedBox(height: 15),
                    ElevatedButton(
                      onPressed: _submit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 15),
                      ),
                      child: Text(
                        _isLogin ? 'Login' : 'Sign up',
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(
                          () {
                            _isLogin = !_isLogin;
                          },
                        );
                      },
                      child: Text(
                        _isLogin
                            ? 'Create an account'
                            : 'I already have an account',
                        style: const TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
