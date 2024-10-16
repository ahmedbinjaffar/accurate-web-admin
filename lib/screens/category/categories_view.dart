import 'package:admin/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:admin/app_provider/app_provider.dart';
import 'package:admin/constants/colors.dart';
import 'package:admin/models/models/category_model/category_model.dart';
import 'package:admin/screens/category/widgets/single_category_item.dart';

class CategoriesView extends StatefulWidget {
  const CategoriesView({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CategoriesViewState createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> {
  @override
  void initState() {
    super.initState();
    Provider.of<AppProvider>(context, listen: false).getCategoriesListFun();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        name: 'Category View',
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Consumer<AppProvider>(
              builder: (context, appProvider, child) {
                if (appProvider.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (appProvider.getCategoriesList.isEmpty) {
                  return const Center(child: Text('No categories found.'));
                } else {
                  return _buildCategoriesList(appProvider.getCategoriesList);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesList(List<CategoryModel> categories) {
    final Size size = MediaQuery.of(context).size;

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 300,
        mainAxisSpacing: 20.0,
        crossAxisSpacing: 20.0,
        childAspectRatio: size.width < 650
            ? 0.8
            : size.width < 896
                ? 0.7
                : 1,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        CategoryModel category = categories[index];
        return Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: SingleCategoryItem(
            singleCategory: category,
            index: index,
          ),
        );
      },
    );
  }
}
