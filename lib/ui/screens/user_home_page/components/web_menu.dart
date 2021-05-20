import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:xopinionx/controllers/menu_controller.dart';
import 'package:xopinionx/ui/global/constants.dart';
import 'package:get/get.dart';
import 'package:xopinionx/ui/global/utils.dart';

class WebMenu extends StatelessWidget {
  final MenuController _controller = Get.put(MenuController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        height: screenHeight,
        color: kSecondaryColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: List.generate(
            _controller.menuItems.length,
            (index) => WebMenuItem(
              mainMenuItem: _controller.menuItems[index],
              isActive: index == _controller.selectedIndex,
              press: () => _controller.setMenuIndex(index),
            ),
          ),
        ),
      ),
    );
  }
}

class WebMenuItem extends StatefulWidget {
  final bool isActive;
  final MainMenuItem mainMenuItem;
  final VoidCallback press;

  const WebMenuItem({Key key, this.isActive, this.mainMenuItem, this.press})
      : super(key: key);

  @override
  _WebMenuItemState createState() => _WebMenuItemState();
}

class _WebMenuItemState extends State<WebMenuItem> {
  bool _isHover = false;

  Color _buttonColor() {
    if (widget.isActive) {
      return Colors.black54;
    } else if (!widget.isActive & _isHover) {
      return Colors.black.withOpacity(0.4);
    }
    return Colors.transparent;
  }

  Color _borderColor() {
    if (widget.isActive) {
      return Colors.green;
    }
    // else if (!widget.isActive & _isHover) {
    //   return Colors.green.withOpacity(0.4);
    // }
    return Colors.transparent;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.press,
      onHover: (value) {
        setState(() {
          _isHover = value;
        });
      },
      child: AnimatedContainer(
        child: Padding(
          padding: EdgeInsets.all(6.0),
          child: Container(
            // color: _borderColor(),
            padding: EdgeInsets.symmetric(horizontal: kDefaultPadding / 2.8),
            child: Row(
              children: [
                Icon(
                  widget.mainMenuItem.icon,
                  color: kMenuTextColor,
                  size: 16,
                ),
                SizedBox(width: kDefaultPadding / 3),
                Text(
                  widget.mainMenuItem.title,
                  style: TextStyle(
                    color: kMenuTextColor,
                    fontSize: 16,
                    fontWeight:
                        widget.isActive ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ),
        // margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
        width: double.infinity,
        duration: kDefaultDuration,
        padding: EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
        decoration: BoxDecoration(
          color: _buttonColor(),
          border: Border(
            right: BorderSide(color: _borderColor(), width: 3),
          ),
        ),
      ),
    );
  }
}
