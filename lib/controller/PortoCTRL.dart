import 'package:dio/dio.dart';
import '../model/HwingsPort.dart';

class Portoctrl {
  Future<List<Hwingsport>> getPostData() async {
    Dio dio = Dio();
    try {
      final respon = await dio.get(
        "https://684aa138165d05c5d359a01d.mockapi.io/hwingsPorto",
      );
      List<dynamic> data = respon.data;
      List<Hwingsport> data_respon =
          data.map((item) => Hwingsport.fromJson(item)).toList();
      return data_respon;
    } on DioException catch (e) {
      print(e.message);
      return [];
    }
  }
}
