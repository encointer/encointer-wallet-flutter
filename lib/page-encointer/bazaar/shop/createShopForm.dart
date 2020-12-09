import 'package:encointer_wallet/common/components/roundedButton.dart';
import 'package:encointer_wallet/utils/i18n/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:encointer_wallet/common/components/roundedButton.dart';
import 'package:encointer_wallet/page/account/txConfirmPage.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:image_picker/image_picker.dart';
import 'package:encointer_wallet/service/ipfsApi/httpApi.dart';
import 'dart:io';
import 'package:encointer_wallet/service/substrateApi/api.dart';

class CreateShopForm extends StatefulWidget {
  CreateShopForm(this.store);

  final AppStore store;
  static final String route = '/encointer/bazaar/createShopForm';

  @override
  _CreateShopForm createState() => _CreateShopForm(store);
}

class _CreateShopForm extends State<CreateShopForm> {
  _CreateShopForm(this.store);

  final AppStore store;
  static final String route = '/encointer/bazaar/createShopForm';

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _urlCtrl = new TextEditingController();
  final TextEditingController _nameCtrl = new TextEditingController();
  final TextEditingController _descriptionCtrl = new TextEditingController();
  PickedFile _imageFile;

  Future<void> _getImage() async {
    try {
      final pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);
      setState(() {
        _imageFile = pickedFile;
      });
    } catch (e) {
      print("Image picker error " + e);
    }
  }

  Future<String> _uploadImage() async {
    // TODO: upload image to IPFS, return Hash to image
    Ipfs ipfs = Ipfs();
    File image = File(_imageFile.path);
    var cid = await ipfs.uploadImage(image);
    print(cid.toString());
    return cid.toString();
  }

  Future<String> _uploadJson(imageHash) async {
    // TODO: upload json to IPFS, return Hash to json
    try {
      final pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);
      setState(() {
        _imageFile = pickedFile;
      });
    } catch (e) {
      print("Image picker error " + e);
    }
  }

  Future<void> _submit() async {
    if (_formKey.currentState.validate()) {
      final _imageHash = await _uploadImage();
      //  final _jsonHash = await _uploadJson(_imageHash);

      var args = {
        "title": 'new_shop',
        "txInfo": {
          "module": 'encointerBazaar',
          "call": 'newShop',
        },
        "detail": jsonEncode({
          "cid": store.encointer.chosenCid,
          "url": _urlCtrl.text.trim(), //TODO: create overview?
        }),
        "params": [
          store.encointer.chosenCid,
          _urlCtrl.text.trim(), //TODO: change to _jsonHash
        ],
        'onFinish': (BuildContext txPageContext, Map res) {
          Navigator.popUntil(txPageContext, ModalRoute.withName('/'));
        }
      };
      Navigator.of(context).pushNamed(TxConfirmPage.route, arguments: args);
    }
  }

  Future<void> test() async {
    String index = await webApi.evalJavascriptIpfs();
    print(index);
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, String> dic = I18n.of(context).bazaar;
    // test();
    // TODO: Input fields for description, location usw., convert to json, upload and copy URL to blockchain.
    // TODO: IPFS
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
              shrinkWrap: true,
              children: <Widget>[
                TextFormField(
                  // URL
                  decoration: InputDecoration(
                    icon: Icon(Icons.cake, color: Colors.green),
                    hintText: dic['shop.url'],
                    labelText: "${dic['shop.url']}",
                  ),
                  controller: _urlCtrl,
                ),
                TextFormField(
                  // URL
                  decoration: InputDecoration(
                    icon: Icon(Icons.beach_access, color: Colors.blue),
                    hintText: dic['shop.name'],
                    labelText: "${dic['shop.name']}",
                  ),
                  controller: _nameCtrl,
                ),
                TextFormField(
                  // URL
                  decoration: InputDecoration(
                    icon: Icon(Icons.favorite, color: Colors.pink),
                    hintText: dic['shop.description'],
                    labelText: "${dic['shop.description']}",
                  ),
                  controller: _descriptionCtrl,
                ),
                _previewImage(),
                Container(
                  padding: EdgeInsets.all(16),
                  child: RoundedButton(
                    text: I18n.of(context).bazaar['image.choose'],
                    onPressed: () {
                      _getImage();
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            child: RoundedButton(
              text: I18n.of(context).bazaar['shop.create'],
              onPressed: () {
                _submit();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _previewImage() {
    if (_imageFile != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.file(File(_imageFile.path)),
            SizedBox(
              height: 20,
            ),
            /* RaisedButton(
              onPressed: () async {
                var res = await uploadImage(_imageFile.path, uploadUrl);
                print(res);
              },
              child: const Text('Upload'),
            )*/
          ],
        ),
      );
    } else {
      return const Text(
        'You have not yet chosen an image.',
        textAlign: TextAlign.center,
      );
    }
  }
}
