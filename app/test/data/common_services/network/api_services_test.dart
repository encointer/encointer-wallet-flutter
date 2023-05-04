import 'package:encointer_wallet/data/common_services/models/network/api_response.dart';

import 'package:encointer_wallet/data/common_services/network/api_services.dart';
import 'package:encointer_wallet/mocks/announcements/mock_announcements_api.dart';
import 'package:encointer_wallet/models/announcement/announcement.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:mocktail/mocktail.dart';

const _error404 = '404 Error';

class MockApiServices extends Mock implements ApiServices {}

void main() {
  late MockApiServices mockApiServices;

  setUp(() {
    mockApiServices = MockApiServices();
  });

  void setUpMockHttpClientSuccess200() {
    when(
      () => mockApiServices.get(endpoint: any(named: 'endpoint')),
    ).thenAnswer((_) async => Success<List<Announcement>>(data: leuAnnouncements));
  }

  void setUpMockHttpClientFailure404() {
    when(() => mockApiServices.get(endpoint: any(named: 'endpoint')))
        .thenAnswer((_) async => Failure<String>(error: _error404));
  }

  group('test ApiServices methods', () {
    test(
      'should return leuAnnouncements when the response code is 200 (success)',
      () async {
        // arrange
        setUpMockHttpClientSuccess200();
        // act
        final result = await mockApiServices.get(endpoint: 'endpoint');

        // assert
        expect((result as Success<List<Announcement>>).data!.first.communityIdentifier,
            equals(leuAnnouncements.first.communityIdentifier));
      },
    );

    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        // arrange
        setUpMockHttpClientFailure404();
        // act
        final result = await mockApiServices.get(endpoint: 'endpoint');
        // assert
        expect((result as Failure<String>).error, equals(_error404));
      },
    );
  });
}
