import 'package:cryptotracker/helper/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  Widget shimmer(Widget child) {
    return Shimmer.fromColors(
      child: child,
      baseColor: baseColor,
      highlightColor: highlightColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: ListTile(
        title: shimmer(
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(color: black, child: const Text('crypto name')),
              const SizedBox(width: 5),
              const Icon(CupertinoIcons.heart_fill, size: 18),
            ],
          ),
        ),
        subtitle: shimmer(
          Container(color: black, child: const Text("symbol")),
        ),
        leading: shimmer(const CircleAvatar(radius: 35)),
        trailing: shimmer(
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(color: black, child: const Text("00000000")),
              const SizedBox(height: 2),
              Container(color: black, child: const Text("00000000")),
            ],
          ),
        ),
      ),
    );
  }
}
