import 'package:amazon_clone/common/widgets/loader.dart';
import 'package:amazon_clone/constant/global_var.dart';
import 'package:amazon_clone/feature/admin/models/sales.dart';
import 'package:amazon_clone/feature/admin/services/admin_services.dart';
import 'package:amazon_clone/model/order.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:velocity_x/velocity_x.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  final AdminServices adminServices = AdminServices();
  int? totalSales;
  List<Sales>? earnings;
  List<OrderModel>? orders;
  int numOfProd = 0;
  int numOfPendOrder = 0;
  int numOfDelOrder = 0;
  late List<_ChartData> data;
  late TooltipBehavior _tooltip;

  @override
  void initState() {
    super.initState();
    getEarnings();
    fetchAllTheOrders();
  }

  void fetchAllTheOrders() async {
    orders = await adminServices.fetchAllOrders(context);
    setState(() {});

    findNoOfProduct();
    findNoOfStatusOfOrders();
  }

  void getEarnings() async {
    var earningsData = await adminServices.getEarnings(context);
    totalSales = earningsData['totalEarnings'];
    earnings = earningsData['sales'];
    setState(() {});
    data = [
      _ChartData(earnings![0].label, earnings![0].earning.toDouble()),
      _ChartData(earnings![1].label, earnings![1].earning.toDouble()),
      _ChartData("Appliance", earnings![2].earning.toDouble()),
      _ChartData(earnings![3].label, earnings![3].earning.toDouble()),
      _ChartData(earnings![4].label, earnings![4].earning.toDouble()),
    ];
    _tooltip = TooltipBehavior(enable: true);
    setState(() {});
  }

  void findNoOfProduct() {
    for (int i = 0; i < orders!.length; i++) {
      for (int j = 0; j < orders![i].products.length; j++) {
        numOfProd++;
      }
    }
    setState(() {});
  }

  void findNoOfStatusOfOrders() {
    for (int i = 0; i < orders!.length; i++) {
      for (int j = 0; j < orders![i].products.length; j++) {
        if (orders![i].status == 0) {
          numOfPendOrder++;
        } else if (orders![i].status == 3) {
          numOfDelOrder++;
        }
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return totalSales == null || earnings == null
        ? const Loader()
        : SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                "Order Details".text.bold.xl3.make().px16(),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    "No of Orders : ".text.size(15).make(),
                    orders!.length.text.bold.make(),
                  ],
                ).px16(),
                const SizedBox(
                  height: 4,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    "No of Products : ".text.size(15).make(),
                    numOfProd.text.bold.make(),
                  ],
                ).px16(),
                const SizedBox(
                  height: 4,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    "Pending Orders : ".text.size(15).make(),
                    numOfPendOrder.text.bold.make(),
                  ],
                ).px16(),
                const SizedBox(
                  height: 4,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    "Delivered Orders : ".text.size(15).make(),
                    numOfDelOrder.text.bold.make(),
                  ],
                ).px16(),
                const SizedBox(
                  height: 4,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    "Total Earning : ".text.size(15).make(),
                    "\$${totalSales!}".text.xl.bold.color(Colors.red).make(),
                  ],
                ).px16(),
                const SizedBox(height: 30),
                Container(
                  height: 2,
                  color: Colors.black12,
                ).px16(),
                const SizedBox(height: 26),
                "Category Wise Earnings".text.bold.xl3.make().px(18),
                const SizedBox(
                  height: 25,
                ),
                SizedBox(
                  height: 350,
                  child: AspectRatio(
                    aspectRatio: 1.2,
                    child: SfCartesianChart(
                        primaryXAxis: const CategoryAxis(),
                        primaryYAxis: NumericAxis(
                            minimum: 0,
                            maximum: totalSales!.toDouble() + 10000.0,
                            interval: 10000),
                        tooltipBehavior: _tooltip,
                        series: <CartesianSeries<_ChartData, String>>[
                          ColumnSeries<_ChartData, String>(
                            dataSource: data,
                            xValueMapper: (_ChartData data, _) => data.x,
                            yValueMapper: (_ChartData data, _) => data.y,
                            name: 'Category',
                            gradient: GlobalVariables.appBarGradient,
                            // color: Color.fromRGBO(8, 142, 255, 1),
                          ),
                        ]),
                    // BarChart(
                    //   swapAnimationDuration: Duration(milliseconds: 150),
                    //   BarChartData(
                    //       // backgroundColor: Colors.black12,
                    //       borderData: FlBorderData(
                    //         border: const Border(
                    //           left: BorderSide(width: 1),
                    //           bottom: BorderSide(width: 1),
                    //           top: BorderSide.none,
                    //           right: BorderSide.none,
                    //         ),
                    //       ),
                    //       groupsSpace: 10,
                    //       barGroups: [
                    //         BarChartGroupData(x: 1, barRods: [
                    //           BarChartRodData(
                    //               toY: earnings![0].earning.toDouble(),
                    //               fromY: 0,
                    //               width: 20,
                    //               color: GlobalVariables.mainColor),
                    //         ]),
                    //         BarChartGroupData(x: 2, barRods: [
                    //           BarChartRodData(
                    //               toY: earnings![1].earning.toDouble(),
                    //               fromY: 0,
                    //               width: 20,
                    //               color: GlobalVariables.mainColor),
                    //         ]),
                    //         BarChartGroupData(x: 3, barRods: [
                    //           BarChartRodData(
                    //               toY: earnings![2].earning.toDouble(),
                    //               fromY: 0,
                    //               width: 20,
                    //               color: GlobalVariables.mainColor),
                    //         ]),
                    //         BarChartGroupData(x: 4, barRods: [
                    //           BarChartRodData(
                    //               toY: earnings![3].earning.toDouble(),
                    //               fromY: 0,
                    //               width: 20,
                    //               color: GlobalVariables.mainColor),
                    //         ]),
                    //         BarChartGroupData(x: 5, barRods: [
                    //           BarChartRodData(
                    //               toY: earnings![4].earning.toDouble(),
                    //               fromY: 0,
                    //               width: 20,
                    //               color: GlobalVariables.mainColor),
                    //         ]),
                    //       ]),
                    // ),
                  ),
                ).px(5)
              ],
            ),
          );
  }
}

// import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';

// class MyHomePage extends StatefulWidget {
//   // ignore: prefer_const_constructors_in_immutables
//   MyHomePage({Key? key}) : super(key: key);

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   late List<_ChartData> data;
//   late TooltipBehavior _tooltip;

//   @override
//   void initState() {
//     data = [
//       _ChartData('CHN', 12),
//       _ChartData('GER', 15),
//       _ChartData('RUS', 30),
//       _ChartData('BRZ', 6.4),
//       _ChartData('IND', 14)
//     ];
//     _tooltip = TooltipBehavior(enable: true);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('Syncfusion Flutter chart'),
//         ),
//         body: SfCartesianChart(
//             primaryXAxis: CategoryAxis(),
//             primaryYAxis: NumericAxis(minimum: 0, maximum: 40, interval: 10),
//             tooltipBehavior: _tooltip,
//             series: <CartesianSeries<_ChartData, String>>[
//               ColumnSeries<_ChartData, String>(
//                   dataSource: data,
//                   xValueMapper: (_ChartData data, _) => data.x,
//                   yValueMapper: (_ChartData data, _) => data.y,
//                   name: 'Gold',
//                   color: Color.fromRGBO(8, 142, 255, 1))
//             ])
//             );
//   }
// }

class _ChartData {
  _ChartData(this.x, this.y);

  final String x;
  final double y;
}
