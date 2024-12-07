import 'dart:ui';

import 'package:flutter/material.dart';

import '../theme/color/color.dart';

class MessageButton {
  String url;
  String title;
  Color color;

  MessageButton(this.url, this.title, this.color);
}

List<MessageButton> msgButtonList = [
  MessageButton('chat.svg', 'Chats', const Color(0xFFABECEC)),
  MessageButton('doc.svg', 'Bookings', Color(0xFF95B3DE)),
  MessageButton('reward.svg', 'Rewards', const Color(0xFFFFE8B6)),
  MessageButton('gift.svg', 'Promotions', const Color(0xFFEF4666)),
  MessageButton('activities.svg', 'Activities', Colors.grey.shade300),
];

