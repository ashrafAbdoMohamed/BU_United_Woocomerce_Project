/*
import 'package:bu_united_flutter_app/utils/AppColors.dart';
import 'package:configurable_expansion_tile/configurable_expansion_tile.dart';
import 'package:flutter/material.dart';

class ExpansionInfo extends StatelessWidget {
  final String title;
  final bool expand;
  final List<Widget>? children;
  final Widget? child;

  ExpansionInfo(
      {required this.title, this.children, this.child ,this.expand = false});

  @override
  Widget build(BuildContext context) {

    List<String> list = ['A'];

    return ConfigurableExpansionTile(
      initiallyExpanded: expand,
      bottomBorderOn: false,
      topBorderOn: false,
      headerExpanded: Flexible(
        child: Container(
            decoration: BoxDecoration(
              color: appColorWhite.withOpacity(0.3),
              borderRadius: BorderRadius.circular(6),
            ),
            padding: const EdgeInsets.symmetric(vertical: 13.0, horizontal: 10),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title.toUpperCase(),
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2!
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.keyboard_arrow_up,
                    color: Theme.of(context).accentColor,
                    size: 20,
                  ),
                ])),
      ),
      header: Flexible(
        child: Container(
            margin: const EdgeInsets.only(bottom: 2),
            decoration: BoxDecoration(
              // color: Theme.of(context).primaryColorLight.withOpacity(0.5),
              color: appColorWhite.withOpacity(0.2),
              borderRadius: BorderRadius.circular(6),
            ),
            padding: const EdgeInsets.symmetric(vertical: 13.0, horizontal: 10),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    title.toUpperCase(),
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2!
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                  Icon(
                    Icons.keyboard_arrow_right,
                    color: Theme.of(context).accentColor,
                    size: 20,
                  )
                ])),
      ),
      children: children ,
    );
  }
}
*/
