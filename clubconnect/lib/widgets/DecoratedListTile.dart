import 'package:flutter/material.dart';

class DecoratedListTile extends StatelessWidget {
  final String title;
  final IconData leadingIcon;
  final VoidCallback onTap;

  const DecoratedListTile({
    Key? key,
    required this.title,
    required this.leadingIcon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
         // borderRadius: BorderRadius.circular(8),
          color: Colors.transparent,
          //border: Border.all(
           // color: Colors.white,
            //width: 1,
          //),
        ),
        margin: EdgeInsets.symmetric(vertical: 4),
        child: ListTile(
          leading: Icon(
            leadingIcon,
            color: Colors.black,
            size: 24,
          ),
          title: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
