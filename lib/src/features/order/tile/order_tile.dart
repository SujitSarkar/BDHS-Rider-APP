import 'package:flutter/Material.dart';
import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/app_string.dart';
import '../../../../core/constants/text_size.dart';
import '../../../../core/router/app_router.dart';
import '../model/order_list_data_model.dart';
import '../screen/order_details_screen.dart';

class OrderTile extends StatelessWidget {
  const OrderTile(
      {super.key,
        required this.model,
        required this.orderType});

  final OrderListDataModel model;
  final String orderType;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, AppRouter.orderDetails,
            arguments: OrderDetailsScreen(orderModel: model, orderType: orderType));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        decoration: BoxDecoration(
            color: AppColor.cardColor,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 10,
                  offset: const Offset(4, 6))
            ]),
        child: Row(
          children: [
            ///Serial Number & Time
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  child: Text('#S${model.id}\n'),
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: TextStyle(
                        color: AppColor.textColor,
                        fontSize: TextSize.extraSmallText),
                    children: const [
                      TextSpan(text: '25\n'),
                      TextSpan(
                        text: 'minute ago',
                        style: TextStyle(color: AppColor.secondaryColor),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            ///Vertical Divider
            Container(
              height: 60,
              width: 0.5,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              color: Colors.black,
            ),

            ///Name
            Expanded(
                child: Row(children: [
                  Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const FittedBox(
                            child: Text('Customer Name',
                                style: TextStyle(fontSize: TextSize.buttonText)),
                          ),
                          Text('Order Time',
                              style: TextStyle(
                                  fontSize: TextSize.smallText,
                                  color: AppColor.secondaryTextColor)),
                          Text('Payment Type',
                              style: TextStyle(
                                  fontSize: TextSize.smallText,
                                  color: AppColor.secondaryTextColor)),
                          Text('Amount',
                              style: TextStyle(
                                  fontSize: TextSize.smallText,
                                  color: AppColor.secondaryTextColor)),
                        ],
                      ))
                ])),

            ///Value
            Expanded(
                child: Row(children: [
                  Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FittedBox(
                            child: Text(': ${model.customer??'N/A'}',
                                style: const TextStyle(fontSize: TextSize.buttonText)),
                          ),
                          Text(': 09:35',
                              style: TextStyle(
                                  fontSize: TextSize.smallText,
                                  color: AppColor.secondaryTextColor)),
                          Text(': COD',
                              style: TextStyle(
                                  fontSize: TextSize.smallText,
                                  color: AppColor.secondaryTextColor)),
                          Text(': ${model.payment?.payable??'N/A'} ৳',
                              style: TextStyle(
                                  fontSize: TextSize.smallText,
                                  color: AppColor.secondaryTextColor)),
                        ],
                      ))
                ])),
            const SizedBox(width: 4),

            Stack(
              alignment: Alignment.center,
              children: [
                CircleAvatar(
                    backgroundColor: orderType == AppString.orderType.first
                        ? Colors.red
                        : orderType == AppString.orderType[1]
                        ? AppColor.warningColor
                        : AppColor.primaryColor,
                    radius: 9),
                Container(
                  height: 15,
                  width: 15,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 2),
                      color: orderType == AppString.orderType.first
                          ? Colors.red
                          : orderType == AppString.orderType[1]
                          ? AppColor.warningColor
                          : AppColor.primaryColor,
                      borderRadius:
                      const BorderRadius.all(Radius.circular(10))),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
