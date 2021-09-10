import 'package:flutter/material.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:resume_builder/module/user.dart';
import 'package:resume_builder/screens/resume/resume_tablet_wrapper/resume_tablet_screen_wrapper.dart';
import 'package:resume_builder/screens/utils_ui/my_drawer_ui.dart';

class CheckAdminTabletUI extends StatefulWidget {

  final ResumeUser user;

  const CheckAdminTabletUI({Key? key, required this.user}) : super(key: key);

  @override
  _CheckAdminTabletUIState createState() => _CheckAdminTabletUIState();
}

class _CheckAdminTabletUIState extends State<CheckAdminTabletUI> with SingleTickerProviderStateMixin {

  final parser = EmojiParser();

  bool isDrawerOpen = true;

  late AnimationController animatedIconController;

  String widgetStatus = "CheckAdmin";


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animatedIconController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 450),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    animatedIconController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Are you Admin${parser.getName('question').code}"),
        centerTitle: true,
        leading: IconButton (
          onPressed: () {
            if (isDrawerOpen == false ){
              setState(() {
                isDrawerOpen = true;
                animatedIconController.reverse();
              });
            } else {
              setState(() {
                isDrawerOpen = false;
                animatedIconController.forward();
              });
            }
          },
          icon: AnimatedIcon(icon: AnimatedIcons.close_menu, progress: animatedIconController),
        ),
      ),
      body: Center(
        child: Row(
          children: <Widget>[
            // Todo: Creating a navigation drawer to navigate
            isDrawerOpen ? Expanded(
              flex: 0,
              child: MyDrawer(updateWidget: (val) {
                setState(() {
                  widgetStatus = val;
                });
              },),
            ) : Container(),
            Expanded(
              flex: 1,
              child: ResumeTabletScreenWrapperUI(user: widget.user, widgetName: widgetStatus,),
            )
          ],
        ),
      ),
    );
  }
}


