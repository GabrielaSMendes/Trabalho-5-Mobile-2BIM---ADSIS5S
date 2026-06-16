import 'package:dio/dio.dart';
import '../constants/app_constants.dart';

class DioClient {
  static Dio create() {
    return Dio(
      BaseOptions(
        baseUrl: AppConstants.baseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        // Não definir Content-Type como padrão: em GET requests esse header
        // é desnecessário e dispara preflight CORS no Flutter Web, bloqueando
        // a requisição antes mesmo de ela ser enviada.
      ),
    );
  }
}
