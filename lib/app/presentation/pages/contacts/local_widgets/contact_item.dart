import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:testquick/app/domain/entities/user.dart';

import '../contacts_controller.dart';

class ContactItem extends StatelessWidget {
  final User contact;
  final ContactsController _contactsCtrl = Get.find<ContactsController>();

  ContactItem({
    Key key,
    @required this.contact,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.h,
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
      ),
      margin: EdgeInsets.only(
        bottom: 13.h,
      ),
      child: Material(
        child: InkWell(
          borderRadius: BorderRadius.circular(20.r),
          onTap: () => _contactsCtrl.goChat(
            contact: contact,
          ),
          child: Row(
            children: [
              _imgAvatar(
                context: context,
              ),
              Container(
                width: 260.w,
                height: 60.h,
                margin: EdgeInsets.only(
                  left: 12.w,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _informationTop(
                      context: context,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _imgAvatar({
    BuildContext context,
  }) {
    return CircleAvatar(
      child: Text(
        contact.firstName[0],
        style: Theme.of(context).textTheme.headline5.copyWith(
              color: Colors.white,
            ),
      ),
      foregroundImage:
          (contact.avatar != null) ? NetworkImage(contact.avatar) : null,
      backgroundColor: Theme.of(context).accentColor,
      radius: 30.r,
    );
  }

  Widget _informationTop({
    BuildContext context,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "${contact.firstName} ${contact.lastName}",
          style: Theme.of(context).textTheme.headline5.copyWith(
                fontSize: 20.sp,
              ),
        ),
      ],
    );
  }
}
