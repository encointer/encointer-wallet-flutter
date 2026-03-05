import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:encointer_wallet/modules/settings/logic/app_settings_store.dart';
import 'package:encointer_wallet/page-encointer/bazaar/businesses/view/ipfs_image.dart';
import 'package:encointer_wallet/common/components/encointer_text_form_field.dart';
import 'package:encointer_wallet/models/bazaar/category.dart';
import 'package:encointer_wallet/models/bazaar/ipfs_business.dart';
import 'package:encointer_wallet/modules/login/logic/login_store.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/service/tx/lib/src/error_notifications.dart';
import 'package:encointer_wallet/service/tx/lib/src/send_tx_dart.dart';
import 'package:encointer_wallet/service/tx/lib/src/submit_tx_wrappers.dart';
import 'package:encointer_wallet/service/tx/lib/src/tx_builder.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/theme/theme.dart';
import 'package:encointer_wallet/utils/alerts/app_alert.dart';
import 'package:ew_keyring/ew_keyring.dart';
import 'package:ew_l10n/l10n.dart';
import 'package:ew_log/ew_log.dart';
import 'package:ew_test_keys/ew_test_keys.dart';
import 'package:ew_polkadart/encointer_types.dart' as pd;
import 'package:ew_polkadart/generated/encointer_kusama/types/encointer_kusama_runtime/proxy_type.dart' show ProxyType;
import 'package:ew_polkadart/generated/encointer_kusama/types/pallet_proxy/pallet/event.dart' as proxy_event;
import 'package:ew_polkadart/generated/encointer_kusama/types/sp_runtime/dispatch_error.dart';
import 'package:ew_polkadart/runtime_event.dart' as re;
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

const _logTarget = 'BusinessFormPage';

class BusinessFormParams {
  const BusinessFormParams({this.existingBusiness, this.businessController});

  final IpfsBusiness? existingBusiness;
  final String? businessController;

  bool get isEdit => existingBusiness != null;
}

class BusinessFormPage extends StatefulWidget {
  const BusinessFormPage({required this.params, super.key});

  static const String route = '/bazaar/business-form';

  final BusinessFormParams params;

  @override
  State<BusinessFormPage> createState() => _BusinessFormPageState();
}

class _BusinessFormPageState extends State<BusinessFormPage> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameCtrl;
  late final TextEditingController _descriptionCtrl;
  late final TextEditingController _addressCtrl;
  late final TextEditingController _zipcodeCtrl;
  late final TextEditingController _addressDescCtrl;
  late final TextEditingController _telephoneCtrl;
  late final TextEditingController _emailCtrl;
  late final TextEditingController _openingHoursCtrl;
  late final TextEditingController _moreInfoCtrl;
  late final TextEditingController _longitudeCtrl;
  late final TextEditingController _latitudeCtrl;

  Category? _selectedCategory;
  XFile? _pickedLogo;
  bool _clearLogo = false;
  final List<XFile> _pickedPhotos = [];
  List<_ExistingPhoto> _existingPhotos = [];
  final Set<String> _removedPhotoNames = {};
  bool _loadingExistingPhotos = false;
  bool _saving = false;
  String? _progressMessage;

  IpfsBusiness? get _existing => widget.params.existingBusiness;
  bool get _isEdit => widget.params.isEdit;

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController(text: _existing?.name ?? '');
    _descriptionCtrl = TextEditingController(text: _existing?.description ?? '');
    _addressCtrl = TextEditingController(text: _existing?.address ?? '');
    _zipcodeCtrl = TextEditingController(text: _existing?.zipcode ?? '');
    _addressDescCtrl = TextEditingController(text: _existing?.addressDescription ?? '');
    _telephoneCtrl = TextEditingController(text: _existing?.telephone ?? '');
    _emailCtrl = TextEditingController(text: _existing?.email ?? '');
    _openingHoursCtrl = TextEditingController(text: _existing?.openingHours ?? '');
    _moreInfoCtrl = TextEditingController(text: _existing?.moreInfo ?? '');
    _longitudeCtrl = TextEditingController(text: _existing?.longitude ?? '');
    _latitudeCtrl = TextEditingController(text: _existing?.latitude ?? '');
    _selectedCategory = _existing?.category;
    if (_selectedCategory == Category.all) _selectedCategory = null;
    if (_isEdit && _existing?.photos != null) {
      _loadExistingPhotos();
    }
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _descriptionCtrl.dispose();
    _addressCtrl.dispose();
    _zipcodeCtrl.dispose();
    _addressDescCtrl.dispose();
    _telephoneCtrl.dispose();
    _emailCtrl.dispose();
    _openingHoursCtrl.dispose();
    _moreInfoCtrl.dispose();
    _longitudeCtrl.dispose();
    _latitudeCtrl.dispose();
    super.dispose();
  }

  Future<XFile?> _pickImage() async {
    if (context.read<AppSettings>().isIntegrationTest) {
      return _mockPickImage();
    }
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Iconsax.camera),
              title: Text(MaterialLocalizations.of(ctx).dialogLabel.isEmpty ? 'Camera' : 'Camera'),
              onTap: () => Navigator.pop(ctx, ImageSource.camera),
            ),
            ListTile(
              leading: const Icon(Iconsax.gallery),
              title: const Text('Gallery'),
              onTap: () => Navigator.pop(ctx, ImageSource.gallery),
            ),
          ],
        ),
      ),
    );
    if (source == null) return null;
    return ImagePicker().pickImage(source: source);
  }

  Future<XFile> _mockPickImage() async {
    final recorder = ui.PictureRecorder();
    Canvas(recorder).drawRect(const Rect.fromLTWH(0, 0, 100, 100), Paint()..color = Colors.blue);
    final picture = recorder.endRecording();
    final image = await picture.toImage(100, 100);
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    final file = File('${Directory.systemTemp.path}/test_img_${DateTime.now().millisecondsSinceEpoch}.png');
    await file.writeAsBytes(byteData!.buffer.asUint8List());
    return XFile(file.path);
  }

  Future<void> _loadExistingPhotos() async {
    setState(() => _loadingExistingPhotos = true);
    try {
      final entries = await webApi.ipfsApi.getImagesFromFolder(_existing!.photos!);
      if (mounted) {
        setState(() {
          _existingPhotos = entries.entries.map((e) => _ExistingPhoto(name: e.key, bytes: e.value)).toList();
          _loadingExistingPhotos = false;
        });
      }
    } catch (e) {
      Log.e('Failed to load existing photos: $e', _logTarget);
      if (mounted) setState(() => _loadingExistingPhotos = false);
    }
  }

  /// Uploads bytes to IPFS, returns CID hash string.
  Future<String> _uploadBytes(Uint8List bytes, String filename) async {
    final store = context.read<AppStore>();
    final pubKey = store.account.currentAccountPubKey!;
    final keyPair = store.account.getKeyringAccount(pubKey).pair;
    final address = store.account.currentAddress;
    final communityId = store.encointer.chosenCid!.toFmtString();

    final result = await webApi.ipfsUploadService.uploadBytes(
      bytes: bytes,
      filename: filename,
      address: address,
      communityId: communityId,
      keyPair: keyPair,
    );
    return result.hash;
  }

  /// Uploads JSON metadata to IPFS, returns CID hash string.
  Future<String> _uploadJson(Map<String, dynamic> data) async {
    final store = context.read<AppStore>();
    final pubKey = store.account.currentAccountPubKey!;
    final keyPair = store.account.getKeyringAccount(pubKey).pair;
    final address = store.account.currentAddress;
    final communityId = store.encointer.chosenCid!.toFmtString();

    final result = await webApi.ipfsUploadService.uploadJson(
      data: data,
      filename: 'business.json',
      address: address,
      communityId: communityId,
      keyPair: keyPair,
    );
    return result.hash;
  }

  /// Uploads multiple files as an IPFS folder, returns folder CID.
  Future<String> _uploadFolder(Map<String, Uint8List> files) async {
    final store = context.read<AppStore>();
    final pubKey = store.account.currentAccountPubKey!;
    final keyPair = store.account.getKeyringAccount(pubKey).pair;
    final address = store.account.currentAddress;
    final communityId = store.encointer.chosenCid!.toFmtString();

    final result = await webApi.ipfsUploadService.uploadFolder(
      files: files,
      address: address,
      communityId: communityId,
      keyPair: keyPair,
    );
    return result.hash;
  }

  /// Builds IpfsBusiness from form values, uploading new images if picked.
  Future<IpfsBusiness> _buildBusiness() async {
    // Logo
    String? logoCid;
    if (_clearLogo) {
      logoCid = null;
    } else if (_pickedLogo != null) {
      // ignore: avoid_print
      print('[BazaarForm] _buildBusiness: uploading logo');
      final bytes = Uint8List.fromList(await _pickedLogo!.readAsBytes());
      logoCid = await _uploadBytes(bytes, _pickedLogo!.name);
      // ignore: avoid_print
      print('[BazaarForm] _buildBusiness: logo uploaded, cid=$logoCid');
    } else {
      logoCid = _existing?.logo;
    }

    // Photos — collect kept existing + newly picked into a single folder
    final photoFiles = <String, Uint8List>{};
    for (final photo in _existingPhotos) {
      if (!_removedPhotoNames.contains(photo.name)) {
        photoFiles[photo.name] = photo.bytes;
      }
    }
    for (final file in _pickedPhotos) {
      photoFiles[file.name] = Uint8List.fromList(await file.readAsBytes());
    }

    String? photosCid;
    if (photoFiles.isNotEmpty) {
      // ignore: avoid_print
      print('[BazaarForm] _buildBusiness: uploading ${photoFiles.length} photos');
      photosCid = await _uploadFolder(photoFiles);
      // ignore: avoid_print
      print('[BazaarForm] _buildBusiness: photos uploaded, cid=$photosCid');
    }

    return IpfsBusiness(
      name: _nameCtrl.text.trim(),
      categoryRaw: _selectedCategory!.jsonKey,
      description: _nullIfEmpty(_descriptionCtrl.text),
      address: _nullIfEmpty(_addressCtrl.text),
      zipcode: _nullIfEmpty(_zipcodeCtrl.text),
      addressDescription: _nullIfEmpty(_addressDescCtrl.text),
      telephone: _nullIfEmpty(_telephoneCtrl.text),
      email: _nullIfEmpty(_emailCtrl.text),
      openingHours: _nullIfEmpty(_openingHoursCtrl.text),
      moreInfo: _nullIfEmpty(_moreInfoCtrl.text),
      longitude: _nullIfEmpty(_longitudeCtrl.text),
      latitude: _nullIfEmpty(_latitudeCtrl.text),
      logo: logoCid,
      photos: photosCid,
    );
  }

  String? _nullIfEmpty(String text) {
    final trimmed = text.trim();
    return trimmed.isEmpty ? null : trimmed;
  }

  Future<void> _onSave() async {
    // ignore: avoid_print
    print('[BazaarForm] _onSave called, _saving=$_saving, _isEdit=$_isEdit');
    if (!_formKey.currentState!.validate()) {
      // ignore: avoid_print
      print('[BazaarForm] _onSave: form validation failed');
      return;
    }

    final l10n = context.l10n;
    if (_selectedCategory == null) {
      // ignore: avoid_print
      print('[BazaarForm] _onSave: category is null');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(l10n.businessCategoryRequired)));
      return;
    }

    if (_saving) {
      // ignore: avoid_print
      print('[BazaarForm] _onSave: already saving, returning');
      return;
    }

    setState(() => _saving = true);

    try {
      if (_isEdit) {
        await _saveEdit();
      } else {
        await _saveCreate();
      }
      // ignore: avoid_print
      print('[BazaarForm] _onSave: save completed successfully');
    } catch (e) {
      // ignore: avoid_print
      print('[BazaarForm] _onSave ERROR: $e');
      Log.e('Business form save error: $e', _logTarget);
      if (mounted) {
        AppAlert.showErrorDialog(context, errorText: e.toString(), buttontext: context.l10n.ok);
      }
    } finally {
      if (mounted) {
        setState(() {
          _saving = false;
          _progressMessage = null;
        });
      }
    }
  }

  Future<void> _saveEdit() async {
    final l10n = context.l10n;
    final store = context.read<AppStore>();
    final cid = store.encointer.chosenCid!;
    final signer = store.account.getKeyringAccount(store.account.currentAccountPubKey!);
    final currentAddress = store.account.currentAddress;

    setState(() => _progressMessage = l10n.businessUploadingData);
    final business = await _buildBusiness();
    final metadataCid = await _uploadJson(business.toJson());
    business.controller = widget.params.businessController;
    setState(() => _progressMessage = null);

    // The edit button is only shown when isOwner || isDelegate
    // (SingleBusinessDetail), so !isOwner here implies delegate.
    final isOwner = AddressUtils.areEqual(widget.params.businessController!, currentAddress);

    if (isOwner) {
      await submitUpdateBusiness(
        context,
        store,
        webApi,
        signer,
        cid,
        metadataCid,
        txPaymentAsset: cid,
        onFinish: (_, __) {
          if (mounted) Navigator.of(context).pop(business);
        },
      );
    } else {
      // Proxy path: look up the user's actual proxy type for this controller
      final controllerPubKey = AddressUtils.addressToPubKey(widget.params.businessController!).toList();
      final proxies = await webApi.encointer.getProxyAccounts(controllerPubKey);
      final proxyDef = proxies.where((p) => AddressUtils.isSamePubKey(currentAddress, p.delegate)).firstOrNull;

      if (proxyDef == null) {
        throw Exception(l10n.proxyNotProxyBody);
      }

      await submitUpdateBusinessViaProxy(
        context,
        store,
        webApi,
        signer,
        cid,
        metadataCid,
        controllerPubKey,
        txPaymentAsset: cid,
        proxyType: proxyDef.proxyType,
        onFinish: (_, __) {
          if (mounted) Navigator.of(context).pop(business);
        },
      );
    }
  }

  Future<void> _saveCreate() async {
    // ignore: avoid_print
    print('[BazaarForm] _saveCreate: starting');
    final l10n = context.l10n;
    final store = context.read<AppStore>();
    final api = webApi;
    final cid = store.encointer.chosenCid!;
    final signer = store.account.getKeyringAccount(store.account.currentAccountPubKey!);

    // Authenticate once upfront
    final authenticated = await context.read<LoginStore>().ensureAuthenticated(context);
    // ignore: avoid_print
    print('[BazaarForm] _saveCreate: authenticated=$authenticated');
    if (!authenticated) return;

    // Upload to IPFS
    setState(() => _progressMessage = l10n.businessUploadingData);
    // ignore: avoid_print
    print('[BazaarForm] _saveCreate: building business (logo=${_pickedLogo != null}, photos=${_pickedPhotos.length})');
    final business = await _buildBusiness();
    // ignore: avoid_print
    print('[BazaarForm] _saveCreate: uploading metadata JSON');
    final metadataCid = await _uploadJson(business.toJson());
    // ignore: avoid_print
    print('[BazaarForm] _saveCreate: metadata uploaded, cid=$metadataCid');

    // Step 1: createPure
    setState(() => _progressMessage = l10n.businessCreatingAccount);
    final createPureCall = api.encointer.encointerKusama.tx.proxy.createPure(
      proxyType: ProxyType.nonTransfer,
      delay: 0,
      index: 0,
    );
    final createPureXt = await TxBuilder(api.provider).createSignedExtrinsic(
      signer.pair,
      createPureCall,
      paymentAsset: cid.toPolkadart(),
    );

    ExtrinsicReport createPureReport;
    try {
      createPureReport =
          await EWAuthorApi(api.provider).submitAndWatchExtrinsicWithReport(OpaqueExtrinsic(createPureXt));
    } catch (e) {
      throw Exception('${l10n.businessCreateError}: $e');
    }

    if (createPureReport.isExtrinsicFailed) {
      final error = createPureReport.dispatchError;
      Log.e('createPure dispatch error: ${error?.toJson()}', _logTarget);
      final msg = error != null ? getLocalizedTxErrorMessage(l10n, error) : null;
      throw Exception('${msg?.title ?? l10n.businessCreateError}: ${msg?.body ?? error}');
    }

    // Parse PureCreated event to get the pure proxy account ID
    final pureAccountId = _extractPureAccountId(createPureReport);
    if (pureAccountId == null) {
      throw Exception('${l10n.businessCreateError}: PureCreated event not found');
    }

    Log.d('PureCreated account: ${AddressUtils.pubKeyToAddress(pureAccountId)}', _logTarget);

    // Step 2: createBusiness via proxy
    setState(() => _progressMessage = l10n.businessRegistering);
    final createBusinessCall = api.encointer.encointerKusama.tx.encointerBazaar.createBusiness(
      cid: cid.toPolkadart(),
      url: metadataCid.codeUnits,
    );
    final proxyCall = api.encointer.encointerKusama.tx.proxy.proxy(
      real: pd.MultiAddress.values.id(pureAccountId),
      forceProxyType: ProxyType.nonTransfer,
      call: createBusinessCall,
    );
    final proxyXt = await TxBuilder(api.provider).createSignedExtrinsic(
      signer.pair,
      proxyCall,
      paymentAsset: cid.toPolkadart(),
    );

    ExtrinsicReport createBizReport;
    try {
      createBizReport = await EWAuthorApi(api.provider).submitAndWatchExtrinsicWithReport(OpaqueExtrinsic(proxyXt));
    } catch (e) {
      throw Exception('${l10n.businessCreateError}: $e');
    }

    if (createBizReport.isExtrinsicFailed) {
      final error = createBizReport.dispatchError;
      Log.e('createBusiness dispatch error: ${error?.toJson()}', _logTarget);
      final msg = error != null ? getLocalizedTxErrorMessage(l10n, error) : null;
      throw Exception('${msg?.title ?? l10n.businessCreateError}: ${msg?.body ?? error}');
    }

    // Check ProxyExecuted event for inner dispatch error
    final proxyError = _extractProxyDispatchError(createBizReport);
    if (proxyError != null) {
      Log.e('createBusiness proxy dispatch error: ${proxyError.toJson()}', _logTarget);
      final msg = getLocalizedTxErrorMessage(l10n, proxyError);
      throw Exception('${msg.title}: ${msg.body}');
    }

    setState(() => _progressMessage = null);

    business.controller = AddressUtils.pubKeyToAddress(pureAccountId);
    if (mounted) Navigator.of(context).pop(business);
  }

  /// Extracts the pure account ID (32 bytes) from the PureCreated event in the report.
  List<int>? _extractPureAccountId(ExtrinsicReport report) {
    for (final record in report.events) {
      final event = record.event;
      if (event is re.Proxy) {
        final proxyEvent = event.value0;
        if (proxyEvent is proxy_event.PureCreated) {
          return proxyEvent.pure.toList();
        }
      }
    }
    return null;
  }

  /// Extracts the DispatchError from a ProxyExecuted event, if the inner call failed.
  DispatchError? _extractProxyDispatchError(ExtrinsicReport report) {
    for (final record in report.events) {
      final event = record.event;
      if (event is re.Proxy) {
        final proxyEvent = event.value0;
        if (proxyEvent is proxy_event.ProxyExecuted && proxyEvent.result.isErr) {
          return proxyEvent.result.errValue;
        }
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    // Category items excluding 'all'
    final categoryItems = Category.values.where((c) => c != Category.all).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(_isEdit ? l10n.businessFormTitleEdit : l10n.businessFormTitleCreate),
      ),
      body: Stack(
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      // Name
                      EncointerTextFormField(
                        key: const Key(EWTestKeys.businessName),
                        labelText: l10n.businessNameLabel,
                        controller: _nameCtrl,
                        validator: (v) => (v == null || v.trim().isEmpty) ? l10n.businessNameRequired : null,
                      ),
                      const SizedBox(height: 12),

                      // Category
                      DropdownButtonFormField<Category>(
                        key: const Key(EWTestKeys.businessCategory),
                        initialValue: _selectedCategory,
                        decoration: InputDecoration(
                          labelText: l10n.businessCategoryLabel,
                          labelStyle: context.bodyLarge.copyWith(color: context.colorScheme.primary),
                          contentPadding: const EdgeInsets.only(top: 16, bottom: 16, left: 25),
                          border: UnderlineInputBorder(
                            borderSide: const BorderSide(width: 0, style: BorderStyle.none),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        items: categoryItems
                            .map((c) => DropdownMenuItem(value: c, child: Text(c.localized(context))))
                            .toList(),
                        onChanged: (v) => setState(() => _selectedCategory = v),
                        validator: (v) => v == null ? l10n.businessCategoryRequired : null,
                      ),
                      const SizedBox(height: 12),

                      // Description
                      TextFormField(
                        key: const Key(EWTestKeys.businessDescription),
                        controller: _descriptionCtrl,
                        decoration: InputDecoration(
                          labelText: l10n.businessDescriptionLabel,
                          labelStyle: context.bodyLarge.copyWith(color: context.colorScheme.primary),
                          contentPadding: const EdgeInsets.only(top: 16, bottom: 16, left: 25),
                        ),
                        maxLines: 3,
                        keyboardType: TextInputType.multiline,
                      ),
                      const SizedBox(height: 12),

                      // Address
                      EncointerTextFormField(
                        key: const Key(EWTestKeys.businessAddress),
                        labelText: l10n.businessAddressLabel,
                        controller: _addressCtrl,
                      ),
                      const SizedBox(height: 12),

                      // Zipcode
                      EncointerTextFormField(
                        key: const Key(EWTestKeys.businessZipcode),
                        labelText: l10n.businessZipcodeLabel,
                        controller: _zipcodeCtrl,
                      ),
                      const SizedBox(height: 12),

                      // Address Description
                      EncointerTextFormField(
                          labelText: l10n.businessAddressDescriptionLabel, controller: _addressDescCtrl),
                      const SizedBox(height: 12),

                      // Telephone
                      EncointerTextFormField(
                        key: const Key(EWTestKeys.businessTelephone),
                        labelText: l10n.businessTelephoneLabel,
                        controller: _telephoneCtrl,
                        keyboardType: TextInputType.phone,
                      ),
                      const SizedBox(height: 12),

                      // Email
                      EncointerTextFormField(
                        key: const Key(EWTestKeys.businessEmail),
                        labelText: l10n.businessEmailLabel,
                        controller: _emailCtrl,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 12),

                      // Opening Hours
                      TextFormField(
                        key: const Key(EWTestKeys.businessOpeningHours),
                        controller: _openingHoursCtrl,
                        decoration: InputDecoration(
                          labelText: l10n.businessOpeningHoursLabel,
                          labelStyle: context.bodyLarge.copyWith(color: context.colorScheme.primary),
                          contentPadding: const EdgeInsets.only(top: 16, bottom: 16, left: 25),
                        ),
                        maxLines: 2,
                        keyboardType: TextInputType.multiline,
                      ),
                      const SizedBox(height: 12),

                      // More Info
                      TextFormField(
                        controller: _moreInfoCtrl,
                        decoration: InputDecoration(
                          labelText: l10n.businessMoreInfoLabel,
                          labelStyle: context.bodyLarge.copyWith(color: context.colorScheme.primary),
                          contentPadding: const EdgeInsets.only(top: 16, bottom: 16, left: 25),
                        ),
                        maxLines: 3,
                        keyboardType: TextInputType.multiline,
                      ),
                      const SizedBox(height: 12),

                      // Longitude / Latitude
                      Row(
                        children: [
                          Expanded(
                            child: EncointerTextFormField(
                              key: const Key(EWTestKeys.businessLongitude),
                              labelText: l10n.businessLongitudeLabel,
                              controller: _longitudeCtrl,
                              keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: EncointerTextFormField(
                              key: const Key(EWTestKeys.businessLatitude),
                              labelText: l10n.businessLatitudeLabel,
                              controller: _latitudeCtrl,
                              keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Logo
                      Text(l10n.businessLogoLabel,
                          style: context.bodyLarge.copyWith(color: context.colorScheme.primary)),
                      const SizedBox(height: 4),
                      if (_pickedLogo != null)
                        Row(children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: Image.file(File(_pickedLogo!.path), width: 48, height: 48, fit: BoxFit.cover),
                          ),
                          const SizedBox(width: 8),
                          Expanded(child: Text(l10n.businessLogoLabel, overflow: TextOverflow.ellipsis)),
                          IconButton(
                            icon: const Icon(Icons.close, size: 18),
                            tooltip: l10n.businessRemoveImage,
                            onPressed: () => setState(() {
                              _pickedLogo = null;
                              _clearLogo = true;
                            }),
                          ),
                        ])
                      else if (!_clearLogo && _existing?.logo != null)
                        Row(children: [
                          IpfsImage(
                            ipfs: webApi.ipfsApi,
                            cidOrFolder: _existing!.logo!,
                            width: 48,
                            height: 48,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          const SizedBox(width: 8),
                          TextButton.icon(
                            icon: const Icon(Iconsax.camera, size: 18),
                            label: Text(l10n.businessChangeImage),
                            onPressed: () async {
                              final file = await _pickImage();
                              if (file != null) setState(() => _pickedLogo = file);
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.close, size: 18),
                            tooltip: l10n.businessRemoveImage,
                            onPressed: () => setState(() => _clearLogo = true),
                          ),
                        ])
                      else
                        TextButton.icon(
                          key: const Key(EWTestKeys.businessPickLogo),
                          icon: const Icon(Iconsax.camera, size: 18),
                          label: Text(l10n.businessPickImage),
                          onPressed: () async {
                            final file = await _pickImage();
                            if (file != null) {
                              setState(() {
                                _pickedLogo = file;
                                _clearLogo = false;
                              });
                            }
                          },
                        ),
                      const SizedBox(height: 16),

                      // Photos
                      Text(l10n.businessPhotosLabel,
                          style: context.bodyLarge.copyWith(color: context.colorScheme.primary)),
                      const SizedBox(height: 4),
                      if (_loadingExistingPhotos)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Row(children: [
                            const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2)),
                            const SizedBox(width: 8),
                            Text(l10n.businessLoadingPhotos),
                          ]),
                        ),
                      Wrap(
                        spacing: 8,
                        runSpacing: 4,
                        children: [
                          for (final photo in _existingPhotos)
                            if (!_removedPhotoNames.contains(photo.name))
                              Chip(
                                avatar: Image.memory(photo.bytes, width: 24, height: 24, fit: BoxFit.cover),
                                label: Text(photo.name, overflow: TextOverflow.ellipsis),
                                onDeleted: () => setState(() => _removedPhotoNames.add(photo.name)),
                                deleteButtonTooltipMessage: l10n.businessRemoveImage,
                              ),
                          for (var i = 0; i < _pickedPhotos.length; i++)
                            Chip(
                              avatar: CircleAvatar(
                                backgroundImage: FileImage(File(_pickedPhotos[i].path)),
                                radius: 12,
                              ),
                              label: Text('${l10n.businessPhoto} ${i + 1}', overflow: TextOverflow.ellipsis),
                              onDeleted: () {
                                final idx = i;
                                setState(() => _pickedPhotos.removeAt(idx));
                              },
                              deleteButtonTooltipMessage: l10n.businessRemoveImage,
                            ),
                        ],
                      ),
                      TextButton.icon(
                        key: const Key(EWTestKeys.businessAddPhoto),
                        icon: const Icon(Iconsax.camera, size: 18),
                        label: Text(l10n.businessAddPhoto),
                        onPressed: () async {
                          final file = await _pickImage();
                          if (file != null) setState(() => _pickedPhotos.add(file));
                        },
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),

                // Save button
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      key: const Key(EWTestKeys.businessSave),
                      onPressed: _saving ? null : _onSave,
                      child: _saving
                          ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
                          : Text(l10n.businessSaveButton),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Progress overlay
          if (_progressMessage != null)
            ColoredBox(
              color: Colors.black38,
              child: Center(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const CircularProgressIndicator(),
                        const SizedBox(height: 16),
                        Text(_progressMessage!, style: context.bodyLarge),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _ExistingPhoto {
  _ExistingPhoto({required this.name, required this.bytes});
  final String name;
  final Uint8List bytes;
}
