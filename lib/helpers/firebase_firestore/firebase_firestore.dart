import 'dart:developer';
import 'dart:typed_data';
import 'package:admin/constants/constants.dart';
import 'package:admin/helpers/firebase_storage_helper/firebase_storage_helper.dart';
import 'package:admin/models/models/banner_model/banner_model.dart';
import 'package:admin/models/models/calendar_model/calendar_model.dart';
import 'package:admin/models/models/category_model/category_model.dart';
import 'package:admin/models/models/product_model/product_model.dart';
import 'package:admin/models/models/youtube_model/youtube_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseFirestoreHelper {
  static FirebaseFirestoreHelper instance = FirebaseFirestoreHelper();
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<List<CategoryModel>> getCategories() async {
    log("getCategories");
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore
              .collection("categories")
              .orderBy(
                'timestamp',
              ) // Order by timestamp, descending
              .get();

      List<CategoryModel> categoriesList = querySnapshot.docs
          .map((e) => CategoryModel.fromJson(e.data(), e.id))
          .toList();
      log("Length : ${categoriesList.length}");
      return categoriesList;
    } catch (e) {
      showMessage(e.toString());
      return [];
    }
  }

  Future<String> deleteSingleCategory(String id) async {
    try {
      await _firebaseFirestore.collection("categories").doc(id).delete();
      return "Successfully Deleted";
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> updateSingleCategory(CategoryModel categoryModel) async {
    try {
      await _firebaseFirestore
          .collection("categories")
          .doc(categoryModel.id)
          .update(categoryModel.toJson());
    } catch (e) {
      showMessage(e.toString());
    }
  }

  Future<CategoryModel> addSingleCategory(
      Uint8List image, String fileName) async {
    CollectionReference reference =
        FirebaseFirestore.instance.collection('categories');

    // Upload the image and get the URL
    String imageUrl =
        await FirebaseStorageHelper.instance.uploadUserImage(image, fileName);

    // Generate a new document reference to get a unique ID
    DocumentReference docRef = reference.doc();

    // Create the CategoryModel with the generated unique ID and current timestamp
    CategoryModel addCategory = CategoryModel(
      id: docRef.id,
      name: fileName,
      image: imageUrl,
      timestamp: DateTime.now(), // Set the current time as the timestamp
    );

    // Add the category to Firestore with the generated ID
    await docRef.set(addCategory.toJson());

    // Return the newly added category
    return addCategory;
  }

  // //Product//
  Future<List<ProductModel>> getProducts() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await _firebaseFirestore.collectionGroup('products').get();
    List<ProductModel> productList =
        querySnapshot.docs.map((e) => ProductModel.fromJson(e.data())).toList();
    return productList;
  }

  Future<String> deleteProduct(String categoryid, String productId) async {
    try {
      await _firebaseFirestore
          .collection("categories")
          .doc(categoryid)
          .collection('products')
          .doc(productId)
          .delete();

      return "Successfully Deleted";
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> updateSingleProduct(ProductModel productModel) async {
    try {
      await _firebaseFirestore
          .collection("categories")
          .doc(productModel.categoryid)
          .collection('products')
          .doc(productModel.id)
          .update(productModel.toJson());
      // ignore: empty_catches
    } catch (e) {}
  }

  Future<ProductModel> addSingleProduct(
    Uint8List image,
    String categoryId,
    dynamic price,
    String url,
    String description,
    String fileName,
  ) async {
    CollectionReference reference = _firebaseFirestore
        .collection('categories')
        .doc(categoryId)
        .collection('products');
    String imageUrl =
        await FirebaseStorageHelper.instance.uploadUserImage(image, fileName);
    DocumentReference docRef = reference.doc();
    ProductModel addProduct = ProductModel(
      image: imageUrl,
      id: docRef.id,
      name: fileName,
      categoryid: categoryId,
      price: price,
      url: url,
      isFavourite: false,
      description: description,
    );
    await docRef.set(addProduct.toJson());
    return addProduct;
  }

  // //Youtube//

  Future<List<YoutubeModel>> getYouTubeVideos() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore.collection("youtube").get();

      List<YoutubeModel> youtubeList = querySnapshot.docs
          .map((e) => YoutubeModel.fromJson(e.data()))
          .toList();
      return youtubeList;
    } catch (e) {
      showMessage(e.toString());
      return [];
    }
  }

  Future<String> deleteSingleYoutube(String id) async {
    try {
      await _firebaseFirestore.collection("youtube").doc(id).delete();
      return "Successfully Deleted";
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> updateSingleYoutube(YoutubeModel youtubeModel) async {
    try {
      await _firebaseFirestore
          .collection("youtube")
          .doc(youtubeModel.id)
          .update(youtubeModel.toJson());
      // ignore: empty_catches
    } catch (e) {}
  }

  Future<YoutubeModel> addSingleYoutube(String name, url) async {
    CollectionReference reference = _firebaseFirestore.collection('youtube');
    // String imageUrl =
    //     await FirebaseStorageHelper.instance.uploadUserImage(image);
    DocumentReference docRef = reference.doc();
    YoutubeModel addYoutube = YoutubeModel(id: docRef.id, name: name, url: url);
    await docRef.set(addYoutube.toJson());
    return addYoutube;
  }

  // //Calendar//

  Future<List<PricingModel>> getPricings() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore.collection("calendar").get();

      List<PricingModel> calendarList = querySnapshot.docs
          .map((e) => PricingModel.fromJson(e.data()))
          .toList();
      return calendarList;
    } catch (e) {
      showMessage(e.toString());
      return [];
    }
  }

  Future<String> deleteSingleCalendar(String id) async {
    try {
      await _firebaseFirestore.collection("calendar").doc(id).delete();
      return "Successfully Deleted";
    } catch (e) {
      return e.toString();
    }
  }

  Future<PricingModel> addSingleCalendar(Uint8List image) async {
    CollectionReference reference = _firebaseFirestore.collection('calendar');
    String imageUrl =
        await FirebaseStorageHelper.instance.uploadUserImage2(image);
    DocumentReference docRef = reference.doc();
    PricingModel addCalendar = PricingModel(image: imageUrl, id: docRef.id);
    await docRef.set(addCalendar.toJson());
    return addCalendar;
  }

  //Banner//

  Future<List<BannerModel>> getBanner() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore.collection("banner").get();

      List<BannerModel> bannerList = querySnapshot.docs
          .map((e) => BannerModel.fromJson(e.data()))
          .toList();
      return bannerList;
    } catch (e) {
      showMessage(e.toString());
      return [];
    }
  }

  Future<String> deleteSingleBanner(String id) async {
    try {
      await _firebaseFirestore.collection("banner").doc(id).delete();
      return "Successfully Deleted";
    } catch (e) {
      return e.toString();
    }
  }

  Future<BannerModel> addSingleBanner(Uint8List image) async {
    CollectionReference reference = _firebaseFirestore.collection('banner');
    String imageUrl =
        await FirebaseStorageHelper.instance.uploadUserImage2(image);
    DocumentReference docRef = reference.doc();
    BannerModel addBanner = BannerModel(image: imageUrl, id: docRef.id);
    await docRef.set(addBanner.toJson());
    return addBanner;
  }

//   Future<List<YoutubeModel>> getYouTubeVideos() async {
//     try {
//       QuerySnapshot<Map<String, dynamic>> querySnapshot =
//           await _firebaseFirestore.collection("youtube").get();

//       List<YoutubeModel> youtubeList = querySnapshot.docs
//           .map((e) => YoutubeModel.fromJson(e.data()))
//           .toList();
//       return youtubeList;
//     } catch (e) {
//       showMessage(e.toString());
//       return [];
//     }
//   }
}
