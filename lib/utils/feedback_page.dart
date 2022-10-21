import 'package:encointer_wallet/common/components/encointer_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FeedbackPage extends StatefulWidget {
  FeedbackPage({Key? key}) : super(key: key);

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController subjectController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f5fd),
      body: Center(
        child: Container(
          height: 450,
          width: 400,
          margin: const EdgeInsets.symmetric(
            horizontal: 40,
            vertical: 20,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 40,
            vertical: 20,
          ),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), boxShadow: [
            BoxShadow(offset: const Offset(0, 5), blurRadius: 10, spreadRadius: 1, color: Colors.grey[300]!)
          ]),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text('Contact Us', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                EncointerTextFormField(
                  controller: subjectController,
                  hintText: 'Subject',
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(
                  height: 120,
                  child: EncointerTextFormField(
                    controller: bodyController,
                    hintText: 'Message',
                    keyboardType: TextInputType.emailAddress,
                    maxLines: 5,
                    // minLines: 1,
                  ),
                ),
                SizedBox(
                  height: 45,
                  width: 110,
                  child: TextButton(
                    style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40))),

                    // Future<bool> _sendEmail() async {
                    //   final Uri _emailLaunchUri = Uri(
                    //     scheme: 'mailto',
                    //     path: 'bugreports@mail.encointer.org',
                    //   );
                    //   final _isSuccess = await launchUrl(_emailLaunchUri);
                    //   if (!_isSuccess) {
                    //     ScaffoldMessenger.of(context).showSnackBar(
                    //       const SnackBar(
                    //         content: Text('Check that you have downloaded the Email app'),
                    //       ),
                    //     );
                    //   }
                    //   return _isSuccess;
                    // }

                    onPressed: () async {
                      String recipient = 'janara2610@gmail.com';
                      String subject = subjectController.text;
                      String message = bodyController.text;
                      final Uri email = Uri(
                        scheme: 'mailto',
                        path: recipient,
                        // 'bugreports@mail.encointer.org',
                        query: 'subject=${Uri.encodeComponent(subject)}&body=${Uri.encodeComponent(message)}',
                      );
                      if (await canLaunchUrl(email)) {
                        await launchUrl(email);
                      } else {
                        debugPrint('error');
                      }
                    },
                    child: const Text('Send', style: TextStyle(fontSize: 16)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
