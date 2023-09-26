import '../api_service.dart';
import '../sync_response_model.dart';

class PredictSync {
  Future<SyncResponse> getPredictValues() async {
    try {
      final dio = await ApiService.getInstanceAPI();
      final response = await dio.get('/predict');

      if (ApiService.isResponseStatusSuccesss(response.statusCode)) {
        final data = response.data['predicted_values'] as List<dynamic>;
        return SyncResponse(
          status: ResponseStatus.SUCCESS,
          response: data,
          responseCode: response.statusCode,
        );
      } else {
        return ApiService.handleErrorAndException(response);
      }
    } catch (ex) {
      return ApiService.handleErrorAndException(ex);
    }
  }

  Future<SyncResponse> getDeviceImages() async {
    try {
      final dio = await ApiService.getInstanceAPI();
      final response = await dio.get('/predict/devices/images');

      if (ApiService.isResponseStatusSuccesss(response.statusCode)) {
        final imgs = response.data['device_images'];

        return SyncResponse(
          status: ResponseStatus.SUCCESS,
          response: imgs,
          responseCode: response.statusCode,
        );
      } else {
        return ApiService.handleErrorAndException(response);
      }
    } catch (ex) {
      return ApiService.handleErrorAndException(ex);
    }
  }

  Future<SyncResponse> getRecommend() async {
    try {
      final dio = await ApiService.getInstanceAPI();
      final response = await dio.get('/recommend');

      if (ApiService.isResponseStatusSuccesss(response.statusCode)) {
        final data = response.data['data'];

        return SyncResponse(
          status: ResponseStatus.SUCCESS,
          response: data.toString(),
          responseCode: response.statusCode,
        );
      } else {
        return ApiService.handleErrorAndException(response);
      }
    } catch (ex) {
      return ApiService.handleErrorAndException(ex);
    }
  }
}
