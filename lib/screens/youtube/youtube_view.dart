import 'package:admin/app_provider/app_provider.dart';
import 'package:admin/models/models/youtube_model/youtube_model.dart';
import 'package:admin/screens/youtube/widgets/single_youtube_item.dart';
import 'package:admin/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class YoutubeView extends StatefulWidget {
  const YoutubeView({Key? key}) : super(key: key);

  @override
  State<YoutubeView> createState() => _YoutubeViewState();
}

class _YoutubeViewState extends State<YoutubeView> {
  @override
  void initState() {
    super.initState();
    Provider.of<AppProvider>(context, listen: false).getYotubes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(name: 'YouTube Videos'),
      body: Consumer<AppProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (provider.getYoutube.isEmpty) {
            return const Center(child: Text('No YouTube videos found.'));
          } else {
            return _buildYouTubeList(provider.getYoutube);
          }
        },
      ),
    );
  }

  Widget _buildYouTubeList(List<YoutubeModel> videos) {
    final Size size = MediaQuery.of(context).size;
    final bool isSmallScreen = size.width < 650;

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: isSmallScreen ? 600 : 600,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20.0,
        childAspectRatio: 1.6,
      ),
      itemCount: videos.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleYoutubeItem(
            singleYoutube: videos[index],
            index: index,
            containerWidth: isSmallScreen ? 600 : 460,
          ),
        );
      },
    );
  }
}
