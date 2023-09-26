// ignore_for_file: constant_identifier_names

class SyncResponse {
  ResponseStatus status;
  dynamic response;
  String? errorMsg;
  dynamic errorResponse;
  int? responseCode;
  String? exceptionMsg;

  SyncResponse({
    required this.status,
    this.response,
    this.errorMsg,
    this.errorResponse,
    this.responseCode,
    this.exceptionMsg,
  });

  bool isStatusSuccess() {
    return status == ResponseStatus.SUCCESS;
  }
}

enum ResponseStatus { SUCCESS, ERROR, REQUEST_FAIL }