// ignore_for_file: public_member_api_docs, sort_constructors_first
/*
  Product model , includes all info about product :
  - pid > int
  - imUrl > String
  - title > String 
  - price > double
  - shortDexcription > String 
  - longDescriptiotion > String
  - review > int
  - rating > double
  - isSelected > bool
  - qty > int
 */
class ProductModel {
  final int pid;
  final String imgUrl;
  final String title;
  final double price;
  final String shortDescription;
  final String longDescription;
  final int review;
  final double rating;
  final bool isSelected;
  final int qty;
  final bool liked;

  // constructor
  ProductModel({
    required this.pid,
    required this.imgUrl,
    required this.title,
    required this.price,
    required this.shortDescription,
    required this.longDescription,
    required this.review,
    required this.rating,
    this.isSelected = false,
    this.qty = 1,
    this.liked = false
  });

  ProductModel copyWith({
    int? pid,
    String? imgUrl,
    String? title,
    double? price,
    String? shortDescrip,
    String? longDescrip,
    int? review,
    double? rating,
    bool? isSelected,
    int? qty,
    bool ? liked 
  }) {
    return ProductModel(
      pid: pid ?? this.pid,
      imgUrl: imgUrl ?? this.imgUrl,
      title: title ?? this.title,
      price: price ?? this.price,
      shortDescription: shortDescrip ?? this.shortDescription,
      longDescription: longDescrip ?? this.longDescription,
      review: review ?? this.review,
      rating: rating ?? this.rating,
      isSelected: isSelected ?? this.isSelected,
      qty: qty ?? this.qty,
      liked: liked ?? this.liked
    );
  }
}
