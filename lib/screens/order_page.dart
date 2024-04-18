import 'package:flutter/material.dart';
import 'package:sayaaratukcom/models/order_model.dart';
import 'package:sayaaratukcom/styles/dimentions.dart';
import 'package:sayaaratukcom/utils/format_timestamp.dart';
import 'package:sayaaratukcom/widgets/widgets.dart';
import 'package:uicons/uicons.dart';

class OrderPage extends StatefulWidget {
  final OrderModel order;
  const OrderPage({super.key, required this.order});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    OrderModel order = widget.order;

    return Scaffold(
      appBar: pageBar(context,
          title: order.service.label),
      body: Padding(
        padding: Dimensions.bodyPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
                order.description != "" ? order.description : order.service.description),
            gap(height: 25),
            moreItem(context,
                label: "#${order.id}", icon: UIcons.regularRounded.id_badge),
            moreItem(context,
                label: timeAgo(order.createdAt), icon: UIcons.regularRounded.time_oclock),
            moreItem(context,
                label: order.paymentOption, icon: UIcons.regularRounded.wallet),
            moreItem(context,
                label: order.status,
                icon: UIcons.regularRounded.list_check),
            gap(height: 25),
            orderPathIndicator(context, [order.originAddress, order.destinationAddress]),
            gap(height: 25),
            section(context, title: "العروض", noPadding: true),
            gap(height: 10),
            offer(context, order)
          ],
        ),
      ),
    );
  }
}
