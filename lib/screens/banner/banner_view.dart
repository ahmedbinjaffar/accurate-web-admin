import 'package:admin/app_provider/app_provider.dart';
import 'package:admin/models/models/banner_model/banner_model.dart';
import 'package:admin/screens/banner/widget/single_banner.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets/custom_app_bar/custom_app_bar.dart';

class BannerView extends StatefulWidget {
  const BannerView({super.key});

  @override
  State<BannerView> createState() => _BannerViewState();
}

class _BannerViewState extends State<BannerView> {
  @override
  void initState() {
    super.initState();
    Provider.of<AppProvider>(context, listen: false).getBannerss();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(name: 'Banner View'),
      body: Consumer<AppProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (provider.getBanners.isEmpty) {
            return const Center(child: Text('No Banner events found.'));
          } else {
            return _buildCalendarList(provider.getBanners);
          }
        },
      ),
    );
  }

  Widget _buildCalendarList(List<BannerModel> events) {
    final Size size = MediaQuery.of(context).size;
    final bool isSmallScreen = size.width < 650;

    return GridView.builder(
      padding: const EdgeInsets.all(8.0),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: isSmallScreen ? 600 : 500,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20.0,
        childAspectRatio: 1.6,
      ),
      itemCount: events.length,
      itemBuilder: (context, index) {
        return SingleBannerItem(
          singleBanner: events[index],
          index: index,
        );
      },
    );
  }
}
