// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// final _firebase = FirebaseAuth.instance;

// class ScreenSignup extends StatefulWidget {
//   const ScreenSignup({Key? key}) : super(key: key);

//   @override
//   State<ScreenSignup> createState() => _ScreenSignupState();
// }

// class _ScreenSignupState extends State<ScreenSignup> {
//   final _form = GlobalKey<FormState>();
//   var _enteredName = '';
//   var _enteredEmail = '';
//   var _enteredPassword = '';
//   var _confirmedPassword = '';

//   void _submit() async {
//     final isValid = _form.currentState!.validate();

//     if (!isValid) {
//       return;
//     }
//     _form.currentState!.save();
//     try {
//       final userCredential = await _firebase.createUserWithEmailAndPassword(
//           email: _enteredEmail, password: _enteredPassword);
//       // User signed up successfully
//     } on FirebaseAuthException catch (error) {
//       ScaffoldMessenger.of(context).clearSnackBars();
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(error.message ?? 'Sign up failed'),
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
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20.0),
//               child: Form(
//                 key: _form,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     const Text(
//                       'Create Account',
//                       style: TextStyle(
//                         fontSize: 30,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                     TextFormField(
//                       decoration: const InputDecoration(
//                         labelText: 'Name',
//                         border: OutlineInputBorder(),
//                       ),
//                       validator: (value) {
//                         if (value == null || value.trim().isEmpty) {
//                           return 'Please enter your name.';
//                         }
//                         return null;
//                       },
//                       onSaved: (value) {
//                         _enteredName = value!;
//                       },
//                     ),
//                     const SizedBox(height: 15),
//                     TextFormField(
//                       decoration: const InputDecoration(
//                         labelText: 'Email Address',
//                         border: OutlineInputBorder(),
//                       ),
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
//                     const SizedBox(height: 15),
//                     TextFormField(
//                       decoration: const InputDecoration(
//                         labelText: 'Password',
//                         border: OutlineInputBorder(),
//                       ),
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
//                     const SizedBox(height: 15),
//                     TextFormField(
//                       decoration: const InputDecoration(
//                         labelText: 'Confirm Password',
//                         border: OutlineInputBorder(),
//                       ),
//                       obscureText: true,
//                       validator: (value) {
//                         if (value == null || value != _enteredPassword) {
//                           return 'Passwords do not match.';
//                         }
//                         return null;
//                       },
//                       onSaved: (value) {
//                         _confirmedPassword = value!;
//                       },
//                     ),
//                     const SizedBox(height: 20),
//                     ElevatedButton(
//                       onPressed: _submit,
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.green,
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 40, vertical: 15),
//                       ),
//                       child: const Text(
//                         'Sign Up',
//                         style: TextStyle(fontSize: 18),
//                       ),
//                     ),
//                     TextButton(
//                       onPressed: () {
//                         // Navigate to login screen or perform other actions
//                       },
//                       child: const Text(
//                         'Already have an account? Log in',
//                         style: TextStyle(color: Colors.blue),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
