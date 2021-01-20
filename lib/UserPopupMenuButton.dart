import 'package:flutter/material.dart';
import 'Services/UserService.dart';
import 'WidgetUtils/GeneralUtils.dart';

class UserPopupMenuButton extends StatelessWidget {
  final UserService userService = new UserService();

  String _getUsername() {
    return userService?.user?.name != null ? userService.user.name : 'NO USERNMAE';
  }

  String _getUserMail() {
    return userService?.user?.mail != null ? userService.user.mail : 'NO MAIL';
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (BuildContext context) {
        List<PopupMenuItem> items = new List();
        items.add(
          new PopupMenuItem(
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.person,
                  color: Colors.black,
                ),
                Header(
                  'My Profile',
                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  fontSize: 18.0,
                )
              ],
            ),
          ),
        );
        items.add(
          new PopupMenuItem(
            child: Row(
              children: <Widget>[
                Chip(
                  avatar: Icon(Icons.email_outlined,
                      size: 18.0, color: Colors.black),
                  label: Text(
                    _getUserMail(),
                    style: TextStyle(fontSize: 12.0),
                  ),
                ),
                Chip(
                  avatar: Icon(
                    Icons.person_outline,
                    color: Colors.black,
                    size: 18.0,
                  ),
                  label: Text(
                    _getUsername(),
                    style: TextStyle(fontSize: 12.0),
                  ),
                ),
              ],
            ),
          ),
        );
        if (userService.isAdmin()) {
          items.add(new PopupMenuItem(
            value: 'manage_vehicles',
            child: CenteredText('Manage Vehicles'),
          ));
          items.add(new PopupMenuItem(
            value: 'manage_persons',
            child: CenteredText('Manage Users'),
          ));
        }
        items.add(new PopupMenuItem(value: 'logout', child: Text('LogOut')));
        return items;
      },
      onSelected: (value) => {
        if (value == 'manage_vehicles')
          {Navigator.pushNamed(context, '/manage-vehicles')}
        else if (value == 'manage_persons')
          {Navigator.pushNamed(context, '/manage-persons')}
        else if (value == 'logout')
            {userService.logout(context)}
      },
      child: CircleAvatar(
        child: Icon(Icons.person),
      ),
    );
  }
}