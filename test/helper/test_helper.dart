import 'package:mockito/annotations.dart';
import 'package:flutter_tdd_clean_architecture/domain/repositories/wheather_repository.dart';
import 'package:http/http.dart' as http;

@GenerateMocks(
  [
    WheatherRepository,
  ],
  customMocks: [
    MockSpec<http.Client>(as: #MockHttpClient),
  ],
)
void main() {}
