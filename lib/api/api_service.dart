// ignore_for_file: constant_identifier_names

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:energy_manager/api/sync_response_model.dart';

class ApiService {
  static const String SOMETHING_WRONG = 'SOMETHING_WRONG';
  static const String CONNECTION_ISSUE = 'CONNECTION_ISSUE';

  static Future<Dio> getInstanceAPI() async {
    final dio = Dio(); // with default Options

    // Set default configs
    dio.options.baseUrl = 'http://final-research-2023.uksouth.cloudapp.azure.com';
    // dio.options.connectTimeout = 5000; //5s
    // dio.options.receiveTimeout = 3000;

    // final token = await AppPref.readStringPref(AppPref.accessTokenStr, '');
    // dio.options.headers = <String, dynamic>{"Authorization": "Bearer $token"};

    return dio;
  }

  static Future<Dio> getInstanceFiles() async {
    final dio = Dio(); // with default Options

    // Set default configs
    dio.options.baseUrl = 'http://final-research-2023.uksouth.cloudapp.azure.com/files';
    // dio.options.connectTimeout = 5000; //5s
    // dio.options.receiveTimeout = 3000;

    // final token = await AppPref.readStringPref(AppPref.accessTokenStr, '');
    // dio.options.headers = <String, dynamic>{"Authorization": "Bearer $token"};

    return dio;
  }

  static bool isResponseStatusSuccesss(int? statusCode) {
    return ((statusCode != null) &&
        (statusCode == 200 || statusCode == 201 || statusCode == 202));
  }

  static SyncResponse handleErrorAndException(Object exep) {
    if (exep is DioException) {
      final error = exep;
      if (error.response != null) {
        // --- error logging -----------------

        // ErrorLogSync().send(
        //   errorText: exep.toString(),
        //   dataBefore: (error.response?.data != null)
        //       ? (error.response?.data?.toString() ?? '')
        //       : error.response.toString(),
        //   dataAfter: error.message + " - " + error.error.toString(),
        //   errorLocation:
        //       "llib/services/api/api_service.dart - static SyncResponse handleApiException(Object exep, BuildContext context)",
        // );

        return SyncResponse(
          status: ResponseStatus.ERROR,
          errorResponse: error.response?.data,
          errorMsg: SOMETHING_WRONG,
          responseCode: error.response?.statusCode,
        );
      } else {
        if (error.error != null) {
          if (error.error is SocketException || error.error is IOException) {
            return SyncResponse(
              status: ResponseStatus.REQUEST_FAIL,
              exceptionMsg: CONNECTION_ISSUE,
            );
          } else {
            return SyncResponse(
              status: ResponseStatus.REQUEST_FAIL,
              exceptionMsg: SOMETHING_WRONG,
            );
          }
        } else {
          return SyncResponse(
            status: ResponseStatus.REQUEST_FAIL,
            exceptionMsg: SOMETHING_WRONG,
          );
        }
      }
    } else if (exep is Response<dynamic>) {
      final res = exep;
      return SyncResponse(
        status: ResponseStatus.ERROR,
        errorResponse: res.data,
        errorMsg: SOMETHING_WRONG,
        responseCode: res.statusCode,
      );
    } else {
      if (exep is SocketException || exep is IOException) {
        return SyncResponse(
          status: ResponseStatus.REQUEST_FAIL,
          exceptionMsg: CONNECTION_ISSUE,
        );
      } else {
        return SyncResponse(
          status: ResponseStatus.REQUEST_FAIL,
          exceptionMsg: SOMETHING_WRONG,
        );
      }
    }
  }
}



/*
try {
  //404
  await dio.get('https://wendux.github.io/xsddddd');
} on DioError catch (e) {
  // The request was made and the server responded with a status code
  // that falls out of the range of 2xx and is also not 304.
  if (e.response != null) {
    print(e.response.data)
    print(e.response.headers)
    print(e.response.requestOptions)
  } else {
    // Something happened in setting up or sending the request that triggered an Error
    print(e.requestOptions)
    print(e.message)
  }
}
DioError scheme 
 {
  /// Response info, it may be `null` if the request can't reach to
  /// the http server, for example, occurring a dns error, network is not available.
  Response? response;
  /// Request info.
  RequestOptions? request;
  /// Error descriptions.
  String message;

  DioErrorType type;
  /// The original error/exception object; It's usually not null when `type`
  /// is DioErrorType.DEFAULT
  dynamic? error;
}



DioErrorType #
enum DioErrorType {
  /// It occurs when url is opened timeout.
  connectTimeout,

  /// It occurs when url is sent timeout.
  sendTimeout,

  ///It occurs when receiving timeout.
  receiveTimeout,

  /// When the server response, but with a incorrect status, such as 404, 503...
  response,

  /// When the request is cancelled, dio will throw a error with this type.
  cancel,

  /// Default error type, Some other Error. In this case, you can
  /// use the DioError.error if it is not null.
  other,
}

*/
