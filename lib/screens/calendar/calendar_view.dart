import 'package:admin/app_provider/app_provider.dart';
import 'package:admin/screens/calendar/widgets/single_calendar_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/models/calendar_model/calendar_model.dart';
import '../../widgets/custom_app_bar/custom_app_bar.dart';

class CalendarView extends StatefulWidget {
  const CalendarView({super.key});

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  @override
  void initState() {
    super.initState();
    Provider.of<AppProvider>(context, listen: false).getPrice();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(name: 'Catalog View'),
      body: Consumer<AppProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (provider.getPricing.isEmpty) {
            return const Center(child: Text('No Catalog events found.'));
          } else {
            return _buildCalendarList(provider.getPricing);
          }
        },
      ),
    );
  }

  Widget _buildCalendarList(List<PricingModel> events) {
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
        return SingleCalendarItem(
          singleCalendar: events[index],
          index: index,
        );
      },
    );
  }
}
