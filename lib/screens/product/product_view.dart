import 'package:admin/app_provider/app_provider.dart';
import 'package:admin/screens/product/widgets/single_product_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductView extends StatefulWidget {
  const ProductView({Key? key}) : super(key: key);

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  late Future<void> _loadData;

  @override
  void initState() {
    super.initState();
    _loadData =
        Provider.of<AppProvider>(context, listen: false).callBackFunction();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product View'),
      ),
      body: FutureBuilder<void>(
        future: _loadData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading data.'));
          } else {
            return Consumer<AppProvider>(
              builder: (context, appProvider, child) {
                if (appProvider.getProducts.isEmpty) {
                  return const Center(child: Text('No products found.'));
                } else {
                  return GridView.builder(
                    padding: const EdgeInsets.all(20),
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 280,
                      mainAxisSpacing: 20.0,
                      crossAxisSpacing: 20.0,
                      childAspectRatio: _getChildAspectRatio(size.width),
                    ),
                    itemCount: appProvider.getProducts.length,
                    itemBuilder: (context, index) {
                      final product = appProvider.getProducts[index];
                      return SingleProductView(
                        singleProduct: product,
                        index: index,
                      );
                    },
                  );
                }
              },
            );
          }
        },
      ),
    );
  }

  double _getChildAspectRatio(double width) {
    if (width < 650) {
      return 0.8;
    } else if (width < 896) {
      return 0.7;
    } else {
      return 1.0;
    }
  }
}
