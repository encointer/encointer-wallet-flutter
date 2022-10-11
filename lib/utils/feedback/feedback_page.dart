import 'dart:io';

import 'package:encointer_wallet/common/components/encointer_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:image_picker/image_picker.dart';

class FeedbackPage extends StatefulWidget {
  FeedbackPage({Key? key}) : super(key: key);

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController email = TextEditingController();
  final TextEditingController subject = TextEditingController();
  final TextEditingController body = TextEditingController();

  XFile? image;

  // String? platformResponse;

  sendEmail(String subject, String body, String recipientemail) async {
    final Email email = Email(
      body: body,
      subject: subject,
      recipients: [recipientemail],
      // attachmentPaths: [image!.path],
      isHTML: false,
    );
    await FlutterEmailSender.send(email);
    // try {
    //   await FlutterEmailSender.send(email);
    //   platformResponse = 'success';
    // } catch (error) {
    //   print(error);
    //   platformResponse = error.toString();
    // }

    // if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f5fd),
      body: Center(
        child: Container(
          height: 350,
          width: 300,
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Contact Us', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                EncointerTextFormField(
                  controller: subject,
                  hintText: 'Subject',
                  keyboardType: TextInputType.emailAddress,
                ),
                EncointerTextFormField(
                  controller: body,
                  hintText: 'Message',
                  keyboardType: TextInputType.multiline,
                  // expands: true,
                  maxLines: 8,
                  minLines: 1,
                ),
                // // ElevatedButton.icon(
                // //   onPressed: () async {
                // //     final ImagePicker _picker = ImagePicker();
                // //     final img = await _picker.pickImage(source: ImageSource.gallery);
                // //     setState(() {
                // //       image = img;
                // //     });
                // //   },
                // //   label: const Text('Choose Image'),
                // //   icon: const Icon(Icons.image),
                // // ),
                // // if (image != null)
                // //   Expanded(
                // //     child: Column(
                // //       children: [
                // //         Expanded(child: Image.file(File(image!.path))),
                // //         ElevatedButton.icon(
                // //           onPressed: () {
                // //             setState(() {
                // //               image = null;
                // //             });
                // //           },
                // //           label: const Text('Remove Image'),
                // //           icon: const Icon(Icons.close),
                // //         )
                //       ],
                //     ),
                //   )
                // else
                //   const SizedBox(),
                SizedBox(
                  height: 45,
                  width: 110,
                  child: TextButton(
                    style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: const Color(0xff151534),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40))),
                    onPressed: () async {
                      formKey.currentState!.validate();

                      sendEmail(subject.text, body.text, 'janara2610@gmail.com');
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
