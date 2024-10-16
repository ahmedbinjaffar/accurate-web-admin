// import 'package:admin/constants/asset_image.dart';
// import 'package:admin/constants/colors.dart';
// import 'package:admin/models/RecentFile.dart';
// import 'package:admin/models/models/product_model/product_model.dart';
// import 'package:flutter/material.dart';

// Container recentlyAdded(BuildContext context) {
//   return Container(
//       padding: EdgeInsets.all(defaultPadding),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.all(Radius.circular(10)),
//         color: secondaryColor,
//       ),
//       child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//         Text(
//           'Recently Added',
//           style: Theme.of(context)
//               .textTheme
//               .titleMedium
//               ?.copyWith(color: Colors.white),
//         ),
//         SizedBox(
//           width: double.infinity,
//           child: DataTable(
//               horizontalMargin: 0,
//               columnSpacing: defaultPadding,
//               columns: [
//                 DataColumn(
//                   label: Text('Product Name'),
//                 ),
//                 DataColumn(
//                   label: Text('Price'),
//                 ),
//                 DataColumn(
//                   label: Text('Date'),
//                 ),
//               ],
//               rows: List.generate(demoRecentFiles.length,
//                   (index) => recentProductData(demoRecentFiles[index]))),
//         )
//       ]));
// }

// DataRow recentProductData(ProductModel singleProduct) {
//   return DataRow(cells: [
//     DataCell(Row(
//       children: [
//         Image.asset(
//           AssetsImages.instance.logoimage,
//           width: 30,
//           height: 30,
//         ),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
//           child: Text(singleProduct.name),
//         )
//       ],
//     )),
//     DataCell(Text(singleProduct.name)),
//     DataCell(Text(singleProduct.name))
//   ]);
// }
