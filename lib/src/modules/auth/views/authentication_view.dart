// import 'package:flutter/material.dart';
// import 'package:shop_app/src/modules/auth/views/login_view.dart';
// import 'package:shop_app/src/modules/auth/views/register_view.dart';

// class AuthenticateView extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() => _AuthenticateViewState();
// }

// class _AuthenticateViewState extends State<AuthenticateView> {
//   bool signIn = true;
//   @override
//   void initState() {
//     super.initState();
//   }

//   switchScreen() {
//     setState(() {
//       signIn = !signIn;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return signIn
//         ? LoginView(
//             toggleView: switchScreen,
//           )
//         : RegisterView(
//             toggleView: switchScreen,
//           );
//   }
// }
