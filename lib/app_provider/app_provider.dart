import 'package:admin/models/models/calendar_model/calendar_model.dart';
import 'package:admin/models/models/product_model/product_model.dart';
import 'package:admin/models/models/youtube_model/youtube_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:admin/helpers/firebase_firestore/firebase_firestore.dart';
import 'package:admin/models/models/category_model/category_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

import '../models/models/banner_model/banner_model.dart';

class AppProvider with ChangeNotifier {
  List<CategoryModel> _categoriesList = [];
  List<ProductModel> _productsList = [];
  List<YoutubeModel> _youtubeList = [];
  List<PricingModel> _pricingList = [];
  List<BannerModel> _bannerList = [];

  bool _isLoading = false;

  List<CategoryModel> get getCategoriesList => _categoriesList;
  List<ProductModel> get getProducts => _productsList;
  List<YoutubeModel> get getYoutube => _youtubeList;
  List<PricingModel> get getPricing => _pricingList;
  List<BannerModel> get getBanners => _bannerList;
  int get bannerCount => _bannerList.length;

  bool get isLoading => _isLoading;

  Future<void> callBackFunction() async {
    await Future.wait([
      getCategoriesListFun(),
      getProduct(),
      getYotubes(),
      getPrice(),
      getBannerss(),
    ]);
  }

  void _safeNotifyListeners() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  Future<void> getCategoriesListFun() async {
    try {
      _isLoading = true;
      _safeNotifyListeners();

      _categoriesList = await FirebaseFirestoreHelper.instance.getCategories();

      _isLoading = false;
      _safeNotifyListeners();
    } catch (e) {
      _isLoading = false;
      _safeNotifyListeners();
    }
  }

  Future<void> deleteCategoryFromFirebase(CategoryModel categoryModel) async {
    try {
      _isLoading = true;
      _safeNotifyListeners();

      String value = await FirebaseFirestoreHelper.instance
          .deleteSingleCategory(categoryModel.id);
      if (value == 'Successfully Deleted') {
        _categoriesList.remove(categoryModel);
      }
    } catch (e) {
      // Handle error
    } finally {
      _isLoading = false;
      _safeNotifyListeners();
    }
  }

  Future<void> updateCategoryList(
      int index, String newName, Uint8List? newImage) async {
    try {
      _isLoading = true;
      _safeNotifyListeners();

      String? newImageUrl;
      if (newImage != null) {
        newImageUrl = await uploadImageToStorage(newImage);
      }

      CategoryModel updatedCategory = _categoriesList[index].copyWith(
        name: newName,
        image: newImageUrl ?? _categoriesList[index].image,
      );

      await FirebaseFirestoreHelper.instance
          .updateSingleCategory(updatedCategory);

      _categoriesList[index] = updatedCategory;
    } catch (e) {
      // Handle error
    } finally {
      _isLoading = false;
      _safeNotifyListeners();
    }
  }

  Future<void> addCategory(Uint8List image, String fileName) async {
    try {
      _isLoading = true;
      _safeNotifyListeners();

      CategoryModel categoryModel = await FirebaseFirestoreHelper.instance
          .addSingleCategory(image, fileName);
      _categoriesList.add(categoryModel);
    } catch (e) {
      // Handle error
    } finally {
      _isLoading = false;
      _safeNotifyListeners();
    }
  }

  Future<String> uploadImageToStorage(Uint8List image) async {
    try {
      String fileName = const Uuid().v4();
      Reference reference =
          FirebaseStorage.instance.ref().child('categories/$fileName.jpg');

      UploadTask uploadTask = reference.putData(image);
      TaskSnapshot snapshot = await uploadTask.whenComplete(() {});

      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      throw Exception('Failed to upload image: $e');
    }
  }

  Future<void> getProduct() async {
    try {
      _isLoading = true;
      _safeNotifyListeners();
      _productsList = await FirebaseFirestoreHelper.instance.getProducts();
      _isLoading = false;
      _safeNotifyListeners();
    } catch (e) {
      _isLoading = false;
      _safeNotifyListeners();
    }
  }

  Future<void> deleteProductFromFirebase(ProductModel productModel) async {
    try {
      _isLoading = true;
      _safeNotifyListeners();
      String value = await FirebaseFirestoreHelper.instance
          .deleteProduct(productModel.categoryid, productModel.id);
      if (value == 'Successfully Deleted') {
        _productsList.remove(productModel);
      }
    } finally {
      _isLoading = false;
      _safeNotifyListeners();
    }
  }

  Future<void> updateProductList(
      int index,
      String newName,
      String newDescription,
      dynamic newPrice,
      String newUrl,
      Uint8List? newImage) async {
    try {
      _isLoading = true;
      _safeNotifyListeners();

      String? newImageUrl;
      if (newImage != null) {
        newImageUrl = await uploadImageToStorage(newImage);
      }

      ProductModel updatedProduct = _productsList[index].copyWith(
        name: newName,
        description: newDescription,
        price: newPrice,
        url: newUrl,
        image: newImageUrl ?? _productsList[index].image,
      );

      await FirebaseFirestoreHelper.instance
          .updateSingleProduct(updatedProduct);

      _productsList[index] = updatedProduct;
    } catch (e) {
      // Handle error
    } finally {
      _isLoading = false;
      _safeNotifyListeners();
    }
  }

  Future<void> addProduct(
    Uint8List image,
    String name,
    String categoryId,
    dynamic price,
    String description,
    String url,
  ) async {
    try {
      _isLoading = true;
      _safeNotifyListeners();
      ProductModel productModel =
          await FirebaseFirestoreHelper.instance.addSingleProduct(
        image,
        categoryId,
        price,
        url,
        description,
        name,
      );
      _productsList.add(productModel);
    } catch (e) {
      // Handle error
    } finally {
      _isLoading = false;
      _safeNotifyListeners();
    }
  }

  Future<void> getYotubes() async {
    try {
      _isLoading = true;
      _safeNotifyListeners();
      _youtubeList = await FirebaseFirestoreHelper.instance.getYouTubeVideos();
      _isLoading = false;
      _safeNotifyListeners();
    } catch (e) {
      _isLoading = false;
      _safeNotifyListeners();
    }
  }

  void updateYoutubeList(int index, YoutubeModel youtubeModel) async {
    try {
      _isLoading = true;
      _safeNotifyListeners();

      await FirebaseFirestoreHelper.instance.updateSingleYoutube(youtubeModel);
      _youtubeList[index] = youtubeModel;
    } catch (e) {
      // Handle error
    } finally {
      _isLoading = false;
      _safeNotifyListeners();
    }
  }

  Future<void> deleteYoutubeFromFirebase(YoutubeModel youtubeModel) async {
    try {
      _isLoading = true;
      _safeNotifyListeners();
      String value = await FirebaseFirestoreHelper.instance
          .deleteSingleYoutube(youtubeModel.id);
      if (value == 'Successfully Deleted') {
        _youtubeList.remove(youtubeModel);
      }
    } finally {
      _isLoading = false;
      _safeNotifyListeners();
    }
  }

  void addYoutube(String name, String url) async {
    try {
      _isLoading = true;
      _safeNotifyListeners();
      YoutubeModel youtubeModel =
          await FirebaseFirestoreHelper.instance.addSingleYoutube(name, url);
      _youtubeList.add(youtubeModel);
    } catch (e) {
      // Handle error
    } finally {
      _isLoading = false;
      _safeNotifyListeners();
    }
  }

  Future<void> getPrice() async {
    _pricingList = await FirebaseFirestoreHelper.instance.getPricings();
    _safeNotifyListeners();
  }

  void addCalendar(Uint8List image) async {
    try {
      _isLoading = true;
      _safeNotifyListeners();
      PricingModel calendarModel =
          await FirebaseFirestoreHelper.instance.addSingleCalendar(image);
      _pricingList.add(calendarModel);
    } catch (e) {
      // Handle error
    } finally {
      _isLoading = false;
      _safeNotifyListeners();
    }
  }

  Future<void> deleteCalendarFromFirebase(PricingModel calendarModel) async {
    try {
      _isLoading = true;
      _safeNotifyListeners();
      String value = await FirebaseFirestoreHelper.instance
          .deleteSingleCalendar(calendarModel.id);
      if (value == 'Successfully Deleted') {
        _pricingList.remove(calendarModel);
      }
    } finally {
      _isLoading = false;
      _safeNotifyListeners();
    }
  }

  Future<void> getBannerss() async {
    _bannerList = await FirebaseFirestoreHelper.instance.getBanner();
    _safeNotifyListeners();
  }

  void addBanner(Uint8List image) async {
    try {
      _isLoading = true;
      _safeNotifyListeners();
      BannerModel bannerModel =
          await FirebaseFirestoreHelper.instance.addSingleBanner(image);
      _bannerList.add(bannerModel);
    } catch (e) {
      // Handle error
    } finally {
      _isLoading = false;
      _safeNotifyListeners();
    }
  }

  Future<void> deleteBannerFromFirebase(BannerModel bannerModel) async {
    try {
      _isLoading = true;
      _safeNotifyListeners();
      String value = await FirebaseFirestoreHelper.instance
          .deleteSingleBanner(bannerModel.id);
      if (value == 'Successfully Deleted') {
        _bannerList.remove(bannerModel);
      }
    } finally {
      _isLoading = false;
      _safeNotifyListeners();
    }
  }
}
