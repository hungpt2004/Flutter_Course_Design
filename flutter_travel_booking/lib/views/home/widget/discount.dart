import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_travel_booking/theme/response/response_size.dart';
import 'package:flutter_travel_booking/theme/space/space.dart';
import 'package:flutter_travel_booking/theme/text/text_style.dart';
import 'package:ticket_material/ticket_material.dart';

import '../../../model/ticket.dart';
import '../../../theme/color/color.dart';

class DiscountWidget extends StatefulWidget {
  const DiscountWidget({super.key});

  @override
  State<DiscountWidget> createState() => _DiscountWidgetState();
}

class _DiscountWidgetState extends State<DiscountWidget> {
  late List<Ticket> tickets;
  final boxSpace = BoxSpace();
  final textStyleCustom = TextStyleCustom();

  @override
  void initState() {
    tickets = ticketList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: tickets.length,
        itemBuilder: (context, index) {
          final ticketIndex = tickets[index];
          return _cardDiscount(ticketIndex);
        });
  }

  Widget _cardDiscount(Ticket ticketIndex){
    return Card(
      elevation: 4,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: const LinearGradient(
              colors: [lightPink, white],
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
              stops: [0.1, 1],
            )),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/vectors/${ticketIndex.url}',
                width: 20,
                height: 20,
              ),
              boxSpace.spaceWidth(10, context),
              Column(
                  children: List.generate(5, (index) {
                    return Container(
                      width: StyleSize(context).widthPercent(1),
                      height: StyleSize(context).heightPercent(3),
                      color: Colors.grey.withOpacity(0.8),
                      margin: EdgeInsets.symmetric(vertical: StyleSize(context).moderateScale(2)),
                    );
                  })
              ),
              boxSpace.spaceWidth(10, context),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ticketIndex.title,
                    maxLines: 1,
                    style: textStyleCustom.textStyleForm(
                        10, FontWeight.w400, Colors.redAccent),
                  ),
                  Text(ticketIndex.content,
                      maxLines: 1,
                      style: textStyleCustom.textStyleForm(
                          12, FontWeight.w600, Colors.redAccent))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

}
