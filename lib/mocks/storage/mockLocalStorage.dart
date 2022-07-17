import 'dart:convert';

import 'package:encointer_wallet/utils/localStorage.dart';
import 'package:mockito/mockito.dart';

import '../data/mockAccountData.dart';

class MockLocalStorage extends Mock implements LocalStorage {}

MockLocalStorage getMockLocalStorage() {
  final localStorage = MockLocalStorage();
  when(localStorage.getAccountList()).thenAnswer((_) {
    return Future.value(accList as FutureOr<List<Map<String, dynamic>>>?);
  } as Future<List<Map<String, dynamic>>> Function(Invocation));
  when(localStorage.addAccount(any)).thenAnswer((invocation) {
    accList.add(invocation.positionalArguments[0]);
    return Future.value();
  });
  when(localStorage.removeAccount(any)).thenAnswer((invocation) {
    accList.removeWhere((i) => i!['pubKey'] == invocation.positionalArguments[0]);
    return Future.value();
  });
  when(localStorage.setCurrentAccount(any)).thenAnswer((invocation) {
    currentAccountPubKey = invocation.positionalArguments[0];
    return Future.value();
  });
  when(localStorage.getCurrentAccount()).thenAnswer((_) {
    return Future.value(currentAccountPubKey);
  });
  when(localStorage.getSeeds(any)).thenAnswer((_) => Future.value({}));
  when(localStorage.getAccountCache(any, any)).thenAnswer((_) => Future.value(null));

  when(localStorage.getContactList()).thenAnswer(((_) => Future.value(contactList as FutureOr<List<Map<String, dynamic>>>?)) as Future<List<Map<String, dynamic>>> Function(Invocation));
  when(localStorage.addContact(any)).thenAnswer((invocation) {
    contactList.add(invocation.positionalArguments[0]);
    return Future.value();
  });
  when(localStorage.removeContact(any)).thenAnswer((invocation) {
    contactList.removeWhere((i) => i!['address'] == invocation.positionalArguments[0]);
    return Future.value();
  });
  when(localStorage.updateContact(any)).thenAnswer((invocation) {
    contactList.removeWhere((i) => i!['pubKey'] == invocation.positionalArguments[0]['pubKey']);
    contactList.add(invocation.positionalArguments[0]);
    return Future.value();
  });

  when(localStorage.getObject(any)).thenAnswer((realInvocation) async {
    String? value = storage[realInvocation.positionalArguments.first];
    if (value != null) {
      Object? data = jsonDecode(value);
      return data!;
    }
    return Future.value(null);
  } as Future<Object> Function(Invocation));

  when(localStorage.getMap(any)).thenAnswer((realInvocation) async {
    String? value = storage[realInvocation.positionalArguments.first];
    if (value != null) {
      Object? data = jsonDecode(value);
      return data as FutureOr<Map<String, dynamic>>;
    }
    return Future.value(null);
  } as Future<Map<String, dynamic>> Function(Invocation));

  when(localStorage.setObject(any, any)).thenAnswer((realInvocation) async {
    var args = realInvocation.positionalArguments;
    String str = jsonEncode(args[1]);
    storage[args[0]] = str;
    return Future.value();
  });

  return localStorage;
}
