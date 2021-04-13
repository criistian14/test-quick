import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:testquick/app/data/models/user_model.dart';

class ImageAvatar extends StatelessWidget {
  final UserModel user;
  final double radius;
  final Function onTap;

  const ImageAvatar({
    Key key,
    @required this.user,
    this.radius,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (user == UserModel() || user == null) {
      return Container();
    }

    ImageProvider image;
    if (user.avatar != null) {
      image = NetworkImage(user.avatar);
    }
    if (user.avatarFile != null) {
      image = FileImage(user.avatarFile);
    }

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Align(
          alignment: Alignment.center,
          child: CircleAvatar(
            child: Text(
              user.firstName[0],
              style: Theme.of(context).textTheme.headline5.copyWith(
                    color: Colors.white,
                  ),
            ),
            foregroundImage: image,
            backgroundColor: Theme.of(context).accentColor,
            radius: radius,
          ),
        ),
        if (onTap != null)
          Positioned(
            bottom: -10,
            left: MediaQuery.of(context).size.width / 2,
            child: GestureDetector(
              onTap: onTap,
              child: Container(
                padding: EdgeInsets.all(5.w),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).shadowColor,
                ),
                child: Icon(
                  Icons.edit,
                  color: Theme.of(context).accentColor,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
