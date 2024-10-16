// ignore_for_file: prefer_const_constructors

import 'package:admin/app_provider/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Chart extends StatefulWidget {
  const Chart({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ChartState createState() => _ChartState();
}

class _ChartState extends State<Chart> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          // Optionally handle animation completion
        }
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startAnimation() {
    _controller.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);

    // Ensure there's data available for the PieChart
    if (appProvider.getProducts.isEmpty &&
        appProvider.getPricing.isEmpty &&
        appProvider.getCategoriesList.isEmpty &&
        appProvider.getYoutube.isEmpty) {
      return const Center(child: Text('No data available'));
    }

    return SizedBox(
      height: 200,
      child: Stack(
        children: [
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Transform(
                transform: Matrix4.identity()
                  ..rotateZ(_controller.value * 2.0 * 3.141592653589793)
                  ..scale(
                    1.0 +
                        0.1 *
                            (_controller.value < 0.5
                                ? _controller.value * 2
                                : (1 - _controller.value) * 2),
                  ),
                alignment: Alignment.center,
                child: child,
              );
            },
            child: SfCircularChart(
              series: _doughnutChartSelectionDatas(appProvider),
              centerX: '50%',
              centerY: '50%',
            ),
          ),
          Positioned.fill(
            child: Center(
              child: GestureDetector(
                onTap: _startAnimation,
                child: const Icon(Icons.two_wheeler),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<DoughnutSeries<_ChartData, String>> _doughnutChartSelectionDatas(
      AppProvider appProvider) {
    final List<_ChartData> data = [
      _ChartData(
          'Products', appProvider.getProducts.length.toDouble(), Colors.blue),
      _ChartData('Pricing', appProvider.getPricing.length.toDouble(),
          const Color.fromARGB(255, 128, 255, 251)),
      _ChartData('Categories', appProvider.getCategoriesList.length.toDouble(),
          Colors.yellow),
      _ChartData(
          'YouTube', appProvider.getYoutube.length.toDouble(), Colors.red),
      _ChartData('Banner', appProvider.getBanners.length.toDouble(),
          Color.fromARGB(255, 158, 15, 253)),
    ];

    // Ensure there is at least one section with a value greater than 0
    return data.any((element) => element.value > 0)
        ? [
            DoughnutSeries<_ChartData, String>(
              dataSource: data,
              xValueMapper: (_ChartData data, _) => data.x,
              yValueMapper: (_ChartData data, _) => data.value,
              pointColorMapper: (_ChartData data, _) => data.color,
              dataLabelSettings: const DataLabelSettings(isVisible: false),
              innerRadius: '70%',
            )
          ]
        : [];
  }
}

class _ChartData {
  _ChartData(this.x, this.value, this.color);

  final String x;
  final double value;
  final Color color;
}
