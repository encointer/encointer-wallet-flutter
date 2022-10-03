import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FeedbackPage extends StatefulWidget {
  FeedbackPage({Key? key}) : super(key: key);

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();

  final emailController = TextEditingController();

  final messageController = TextEditingController();
  File? image;
  // Future getImage()async{
  //   final image = await ImagePicker().pickImage(source: ImageSource.camera);
  //   if(image == null) return;
  //   final ImageTemporary = File(image.path);
  // setState((){
  //   this._image = imageTemporary;
  // })
  // }
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
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text('Contact Us', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(hintText: 'Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '*Required';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(hintText: 'Email'),
                  validator: (email) {
                    if (email == null || email.isEmpty) {
                      return 'Required*';
                    } else {
                      return null;
                    }
                  },
                  onTap: () {},
                ),
                TextFormField(
                  controller: messageController,
                  decoration: const InputDecoration(hintText: 'Message'),
                  maxLines: 5,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '*Required';
                    }
                    return null;
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () async {
                        final ImagePicker _picker = ImagePicker();
                        final img = await _picker.getImage(source: ImageSource.gallery);
                        // pickImage(source: ImageSource.gallery);
                        setState(() {
                          image = img as File?;
                        });
                      },
                      label: const Text('Choose Image'),
                      icon: const Icon(Icons.image),
                    ),
                    // ElevatedButton.icon(
                    //   onPressed: () async {
                    //     final ImagePicker _picker = ImagePicker();
                    //     final img = await _picker.getImage(source: ImageSource.camera);
                    //     setState(() {
                    //       image = img as File?;
                    //     });
                    //   },
                    //   label: const Text('Take \nPhoto'),
                    //   icon: const Icon(Icons.camera_alt_outlined),
                    // ),
                  ],
                ),
                if (image != null)
                  Expanded(
                    child: Column(
                      children: [
                        Expanded(child: Image.file(File(image!.path))),
                        ElevatedButton.icon(
                          onPressed: () {
                            setState(() {
                              image = null;
                            });
                          },
                          label: const Text('Remove Image'),
                          icon: const Icon(Icons.close),
                        )
                      ],
                    ),
                  )
                else
                  const SizedBox(),
                SizedBox(
                  height: 45,
                  width: 110,
                  child: TextButton(
                    style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: const Color(0xff151534),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40))),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        //TODO: send email
                        nameController.clear();
                        emailController.clear();
                        messageController.clear();
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
