import 'package:bdhs_rider_app/core/widgets/shimmer_widget.dart';
import 'package:bdhs_rider_app/src/features/authentication/repository/auth_repository.dart';
import 'package:flutter/Material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/dummy_data.dart';
import '../../../../core/constants/text_size.dart';
import '../../../../core/router/app_router.dart';
import '../provider/home_provider.dart';
import '../tile/home_grid_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    final HomeProvider homeProvider = Provider.of(context,listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_)async{
      await homeProvider.initializeData();
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final HomeProvider homeProvider = Provider.of(context);
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          body: homeProvider.initialLoading
              ? ShimmerWidget(child: _bodyUI(context, homeProvider, size))
              : _bodyUI(context, homeProvider, size)),
    );
  }

  Widget _bodyUI(BuildContext context, HomeProvider homeProvider, Size size) =>
      Column(
        children: [
          ///Header
          InkWell(
            onTap: ()=> Navigator.pushNamed(context, AppRouter.profile),
            child: Stack(
              children: [
                Image.asset(
                  'assets/images/rider.jpg',
                  width: size.width,
                  height: size.height * .3,
                  fit: BoxFit.cover,
                ),
                Container(
                    alignment: Alignment.center,
                    width: size.width,
                    height: size.height * .3,
                    color: Colors.black.withOpacity(0.4),
                    child: Stack(
                      alignment: Alignment.center,
                      fit: StackFit.expand,
                      children: [
                        Positioned(
                            left: 16,
                            right: 16,
                            top: 8,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const CircleAvatar(
                                  backgroundColor: AppColor.appBodyBg,
                                  radius: 24,
                                  child: Icon(Icons.person,
                                      size: 36, color: AppColor.primaryColor),
                                ),
                                const SizedBox(width: 8),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      homeProvider.loginResponseModel?.user?.name??'N/A',
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: TextSize.bodyText,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 4),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 2),
                                      decoration: const BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                      child: Text(
                                        homeProvider.loginResponseModel?.user?.roleType??'N/A',
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: TextSize.smallText),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                        Center(
                          child: Text(
                            '${homeProvider.dashboardDataModel?.data?.processingOrder??'0'} Order Processing',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: TextSize.headerText,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    )),
              ],
            ),
          ),

          ///Body
          SizedBox(
            height: size.height * .7 - (MediaQuery.of(context).padding.top),
            child: Column(
              children: [
                ///Order Card
                Expanded(
                  child: GridView(
                    physics: const BouncingScrollPhysics(),
                    padding:
                        const EdgeInsets.only(top: 20, left: 16, right: 16),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20,
                            childAspectRatio: 1.8),
                    children: [
                      HomeGridTile(
                          onTap: () {
                            Navigator.pushNamed(context, AppRouter.orderList);
                          },
                          leadingAsset:
                              'assets/images/home/processing_order.png',
                          title:'${homeProvider.dashboardDataModel?.data?.processingOrder??'0.0'}',
                          subtitle: 'Processing Order',
                          titleColor: AppColor.secondaryColor,
                          borderColor: AppColor.secondaryColor),
                      HomeGridTile(
                          onTap: () {
                            Navigator.pushNamed(context, AppRouter.orderList);
                          },
                          leadingAsset: 'assets/images/home/ride_complete.png',
                          title: '${homeProvider.dashboardDataModel?.data?.rideComplete??'0.0'}',
                          subtitle: 'Ride Complete',
                          titleColor: AppColor.primaryColor,
                          borderColor: AppColor.primaryColor),
                      HomeGridTile(
                          onTap: () {
                            Navigator.pushNamed(context, AppRouter.orderList);
                          },
                          leadingAsset: 'assets/images/home/star.png',
                          title: '${homeProvider.dashboardDataModel?.data?.totalRating??'0.0'}',
                          subtitle: 'Your Review',
                          titleColor: AppColor.primaryColor,
                          borderColor: AppColor.primaryColor),
                      HomeGridTile(
                          onTap: () {},
                          leadingAsset: 'assets/images/home/payment.png',
                          title: '${homeProvider.dashboardDataModel?.data?.totalPayment??'0.0'}',
                          subtitle: 'Payment',
                          titleColor: AppColor.secondaryColor,
                          borderColor: AppColor.secondaryColor),
                    ],
                  ),
                ),

                ///Graph
                Expanded(
                    child: PieChart(
                  dataMap: homeProvider.orderPieChartDataMap,
                  animationDuration: const Duration(milliseconds: 1200),
                  chartLegendSpacing: 32,
                  chartRadius: MediaQuery.of(context).size.width / 3.2,
                  colorList: colorList,
                  initialAngleInDegree: 0,
                  chartType: ChartType.ring,
                  ringStrokeWidth: 32,
                  centerText: "",
                  legendOptions: const LegendOptions(
                    showLegendsInRow: false,
                    legendPosition: LegendPosition.right,
                    showLegends: true,
                    legendShape: BoxShape.circle,
                    legendTextStyle: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  chartValuesOptions: const ChartValuesOptions(
                      showChartValueBackground: false,
                      showChartValues: true,
                      showChartValuesInPercentage: true,
                      showChartValuesOutside: true,
                      decimalPlaces: 1),
                  // gradientList: ---To add gradient colors---
                  // emptyColorGradient: ---Empty Color gradient---
                ))
              ],
            ),
          )
        ],
      );
}
