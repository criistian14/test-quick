import 'package:flutter/material.dart';
import 'package:testquick/app/data/models/user_model.dart';

class ImageAvatar extends StatelessWidget {
  final UserModel user;
  final double radius;

  const ImageAvatar({
    Key key,
    @required this.user,
    this.radius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (user == UserModel()) {
      return Container();
    }

    return CircleAvatar(
      child: Text(
        user.firstName[0],
        style: Theme.of(context).textTheme.headline5.copyWith(
              color: Colors.white,
            ),
      ),
      foregroundImage: (user.avatar != null) ? NetworkImage(user.avatar) : null,
      backgroundColor: Theme.of(context).accentColor,
      radius: radius,
    );
  }
}
