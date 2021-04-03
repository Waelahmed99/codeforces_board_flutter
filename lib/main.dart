import 'package:flutter/material.dart';
import 'helpers/codeforces_api.dart' as cf;
import 'dart:html';

void main() {
  cf.getProblems();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(AppRoot());
}

class AppRoot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // get handles/problems json files from url.
    var url = window.location.href;
    final Map<String, String> params = Uri.parse(url).queryParameters;
    String handle = params['handle'];

    return MaterialApp(
      home: Scaffold(
        body: UserDetails(handle: handle),
      ),
    );
  }
}

class UserDetails extends StatefulWidget {
  final String handle;

  const UserDetails({Key key, this.handle}) : super(key: key);

  @override
  _UserDetailsState createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  bool _isLoading;

  set isLoading(bool value) => setState(() => _isLoading = value);

  get isLoading => _isLoading;

  @override
  void initState() {
    super.initState();
    _isLoading = true;
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      cf.getProblems();
    });

    if (widget.handle == null || widget.handle.isEmpty)
      return Center(
        child: Text(
          'Please pass your handle like this:\nurl/?handle=YOUR_HANDLE',
          textAlign: TextAlign.center,
        ),
      );

    if (isLoading)
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 24),
            Text('Welcome ${widget.handle}'),
          ],
        ),
      );
  }
}

// class AppRoot extends StatefulWidget {
//   @override
//   _AppRootState createState() => _AppRootState();
// }

// class _AppRootState extends State<AppRoot> {
//   @override
//   Widget build(BuildContext context) {
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
//     // get handles/problems json files from url.
//     var url = window.location.href;
//     final Map<String, String> params = Uri.parse(url).queryParameters;
//     String handle = params['handle'];

//     if (handle == null || handle.isEmpty) {
//       return MaterialApp(
//         home: Scaffold(
//           body: Center(
//             child: Text(
//               'Please pass your handle like this:\nurl/?handle=YOUR_HANDLE',
//               textAlign: TextAlign.center,
//             ),
//           ),
//         ),
//       );
//     }
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Hello'),
//         ),
//         body: Center(
//           child: Text('Welcome ${params['handle']}'),
//         ),
//       ),
//     );
//   }
// }
