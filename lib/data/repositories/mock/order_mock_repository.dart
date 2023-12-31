import '../../../business_logic/repositories/order_repository.dart';
import '../../models/order_model.dart';
import '../../models/order_detail_model.dart';
import '../../models/response_model.dart';

class OrderMockRepository extends OrderRepository {
  @override
  Future<ResponseModel<List<OrderModel>>> getCurrentOrder(
      {required double lat, required double lng}) {
    // TODO: implement getCurrentOrder
    throw UnimplementedError();
  }

  @override
  Future<ResponseModel<OrderDetailModel>> getDetailOrder(
      {required String orderId}) {
    // TODO: implement getDetailOrder
    throw UnimplementedError();
  }

  @override
  Future<ResponseModel<List<OrderModel>>> getListOrder(
      {int? page, int? limit, int? time}) async {
    return ResponseModel<List<OrderModel>>(
      type: ResponseModelType.success,
      data: [
        {
          "receiver": {
            "name": "Tín",
            "phone": "+84931592381",
            "address": "01 Võ Văn Ngân, Linh Chiểu, Thủ Đức, Thành phố Hồ Chí Minh, Việt Nam",
            "lat": 10.8506324,
            "lng": 106.7719131
          },
          "store": {
            "name": "TCC Hoàng Diệu 2",
            "address": "322 Nguyễn Thị Thập, Phú Thuận, Quận 7, Hồ Chí ",
            "phone": "02821201717",
            "lat": 10.8526199,
            "lng": 106.7450425
          },
          "id": "658889ecbdc3d5a9569042ec",
          "quantity": 1,
          "totalPrice": 35000,
          "shippingFee": 0,
          "paymentType": 1,
          "createdAt": 1703447020349,
          "shipDistance": 2946.0520751615595
        },
        {
          "receiver": {
            "name": "Tín",
            "phone": "+84931592381",
            "address": "70 Đ. Lữ Gia, Phường 15, Quận 11, Thành phố Hồ Chí Minh 700000, Việt Nam",
            "lat": 10.7715686,
            "lng": 106.6532635
          },
          "store": {
            "name": "TCC Nguyễn Thị Thập",
            "address": "322 Nguyễn Thị Thập, Phú Thuận, Quận 7, Hồ Chí ",
            "phone": "02829284186",
            "lat": 10.739751,
            "lng": 106.7027951
          },
          "id": "65854d38886ec7924af842b7",
          "quantity": 1,
          "totalPrice": 55000,
          "shippingFee": 0,
          "paymentType": 1,
          "createdAt": 1703234872705,
          "shipDistance": 6472.148222159505
        },
        {
          "receiver": {
            "name": "Tín",
            "phone": "+84931592381",
            "address": "233 Test street, Hồ Chí Minh",
            "lat": 0,
            "lng": 0
          },
          "store": {
            "name": "TCC Nguyễn Thị Thập",
            "address": "322 Nguyễn Thị Thập, Phú Thuận, Quận 7, Hồ Chí ",
            "phone": "02829284186",
            "lat": 10.739751,
            "lng": 106.7027951
          },
          "id": "658520b69306924eec519b38",
          "quantity": 2,
          "totalPrice": 80000,
          "shippingFee": 0,
          "paymentType": 1,
          "createdAt": 1703223478062,
          "shipDistance": 11844603.19264867
        },
        {
          "receiver": {
            "name": "Any",
            "phone": "+84327165374",
            "address": "Landmark",
            "lat": 10,
            "lng": 100
          },
          "store": {
            "name": "TCC Nguyễn Thị Thập",
            "address": "322 Nguyễn Thị Thập, Phú Thuận, Quận 7, Hồ Chí ",
            "phone": "02829284186",
            "lat": 10.739751,
            "lng": 106.7027951
          },
          "id": "658500c37441f45df03cb5b2",
          "quantity": 1,
          "totalPrice": 55000,
          "shippingFee": 0,
          "paymentType": 0,
          "createdAt": 1703215299492,
          "shipDistance": 738550.4061370749
        },
        {
          "receiver": {
            "name": "Tín",
            "phone": "+84931592381",
            "address": "233 Test street, Hồ Chí Minh",
            "lat": 0,
            "lng": 0
          },
          "store": {
            "name": "TCC Nguyễn Thị Thập",
            "address": "322 Nguyễn Thị Thập, Phú Thuận, Quận 7, Hồ Chí ",
            "phone": "02829284186",
            "lat": 10.739751,
            "lng": 106.7027951
          },
          "id": "6584d898005f24bae856b814",
          "quantity": 1,
          "totalPrice": 61000,
          "shippingFee": 0,
          "paymentType": 1,
          "createdAt": 1703205016661,
          "shipDistance": 11844603.19264867
        },
        {
          "receiver": {
            "name": "Dhien",
            "phone": "+84931592381",
            "address": "233 Nguyễn Văn Cừ, An Hòa, Cần Thơ",
            "lat": 0,
            "lng": 0
          },
          "store": {
            "name": "TCC Nguyễn Thị Thập",
            "address": "322 Nguyễn Thị Thập, Phú Thuận, Quận 7, Hồ Chí ",
            "phone": "02829284186",
            "lat": 10.739751,
            "lng": 106.7027951
          },
          "id": "6584d785005f24bae856b7cb",
          "quantity": 2,
          "totalPrice": 96000,
          "shippingFee": 0,
          "paymentType": 1,
          "createdAt": 1703204741687,
          "shipDistance": 11844603.19264867
        },
        {
          "receiver": {
            "name": "VinhNQ",
            "phone": "+84327456789",
            "address": "224A Điện Biên Phủ, Quận 3, Hồ Chí Minh",
            "lat": 0,
            "lng": 0
          },
          "store": {
            "name": "TCC Nguyễn Thị Thập",
            "address": "322 Nguyễn Thị Thập, Phú Thuận, Quận 7, Hồ Chí ",
            "phone": "02829284186",
            "lat": 10.739751,
            "lng": 106.7027951
          },
          "id": "6584d6d8005f24bae856b754",
          "quantity": 1,
          "totalPrice": 75000,
          "shippingFee": 0,
          "paymentType": 1,
          "createdAt": 1703204568276,
          "shipDistance": 11844603.19264867
        },
        {
          "receiver": {
            "name": "Dhien",
            "phone": "+84931592381",
            "address": "233 Nguyễn Văn Cừ, An Hòa, Cần Thơ",
            "lat": 0,
            "lng": 0
          },
          "store": {
            "name": "TCC Nguyễn Thị Thập",
            "address": "322 Nguyễn Thị Thập, Phú Thuận, Quận 7, Hồ Chí ",
            "phone": "02829284186",
            "lat": 10.739751,
            "lng": 106.7027951
          },
          "id": "6584d2b1005f24bae856b6e6",
          "quantity": 2,
          "totalPrice": 64000,
          "shippingFee": 0,
          "paymentType": 1,
          "createdAt": 1703203505730,
          "shipDistance": 11844603.19264867
        },
        {
          "receiver": {
            "name": "VinhNQ",
            "phone": "+84327456789",
            "address": "224A Điện Biên Phủ, Quận 3, Hồ Chí Minh",
            "lat": 0,
            "lng": 0
          },
          "store": {
            "name": "TCC Nguyễn Thị Thập",
            "address": "322 Nguyễn Thị Thập, Phú Thuận, Quận 7, Hồ Chí ",
            "phone": "02829284186",
            "lat": 10.739751,
            "lng": 106.7027951
          },
          "id": "6584d170005f24bae856b6cc",
          "quantity": 5,
          "totalPrice": 229000,
          "shippingFee": 0,
          "paymentType": 1,
          "createdAt": 1703203184288,
          "shipDistance": 11844603.19264867
        },
        {
          "receiver": {
            "name": "Tin",
            "phone": "+84344234584",
            "address": "string",
            "lat": 10.715183720857304,
            "lng": 106.73752531942976
          },
          "store": {
            "name": "TCC Huỳnh Tấn Phát",
            "address": "400 Huỳnh Tấn Phát, Phú Thuận, Quận 7, Hồ Chí M",
            "phone": "02823040993",
            "lat": 10.7467194,
            "lng": 106.7288213
          },
          "id": "65849fca26f3f5ea2f6f6ed7",
          "quantity": 1,
          "totalPrice": 35000,
          "shippingFee": 0,
          "paymentType": 0,
          "createdAt": 1703190474911,
          "shipDistance": 3637.3248903369176
        }
      ].map((e) => OrderModel.fromMap(e)).toList(),
    );
  }

  @override
  Future<ResponseModel<bool>> updateOrderState(
      {required String orderId, int? status}) {
    // TODO: implement updateOrderState
    throw UnimplementedError();
  }
}
