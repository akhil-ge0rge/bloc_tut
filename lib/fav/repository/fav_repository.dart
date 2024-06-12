import 'package:bloc_tut/fav/model/fav_item_model.dart';

class FavRepository {
  Future<List<FavItemModel>> fetchItem() async {
    await Future.delayed(const Duration(seconds: 4));
    return List.from(_generateFavList(10));
  }

  List<FavItemModel> _generateFavList(int length) {
    return List.generate(
      length,
      (index) => FavItemModel(id: index.toString(), value: "Item $index"),
    );
  }
}
