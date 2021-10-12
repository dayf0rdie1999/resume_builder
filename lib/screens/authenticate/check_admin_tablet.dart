import 'package:flutter/material.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:resume_builder/enum/admin_status.dart';
import 'package:resume_builder/module/user.dart';
import 'package:resume_builder/screens/resume/contact/contactdata.dart';
import 'package:resume_builder/screens/resume/resume_tablet_wrapper/resume_tablet_screen_wrapper.dart';
import 'package:resume_builder/screens/utils_ui/my_drawer_ui.dart';

class CheckAdminTabletUI extends StatefulWidget {

  final ResumeUser user;

  final bool isFromPhone;

  final AdminStatus status;

  const CheckAdminTabletUI({Key? key, required this.user, required this.isFromPhone, required this.status}) : super(key: key);

  @override
  _CheckAdminTabletUIState createState() => _CheckAdminTabletUIState();
}

class _CheckAdminTabletUIState extends State<CheckAdminTabletUI> with SingleTickerProviderStateMixin {

  final parser = EmojiParser();

  bool isDrawerOpen = true;

  late AnimationController animatedIconController;

  late String widgetStatus;

  late String appBarTitle;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animatedIconController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 450),
    );
    widgetStatus = checkStatus();
    appBarTitle = getAppBarTitle();
  }

  String checkStatus() {
    if (widget.status == AdminStatus.Admin) {
      return "Education";
    } else if (widget.status == AdminStatus.User) {
      return "Education";
    } else {
      return "CheckAdmin";
    }
  }

  String getAppBarTitle() {
    if (widgetStatus == "CheckAdmin") {
      return "Are you Admin${parser.getName('question').code}";
    } else if (widgetStatus == "Education") {
      return "Education ${parser.getName('mortar_board').code}";
    } else if (widgetStatus == "Jobs") {
      return "Work Experience ${parser.getName('briefcase').code}";
    } else {
      return "Project Experience ${parser.getName('clipboard').code}";
    }
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
        // "Are you Admin${parser.getName('question').code}"
        title: Text(appBarTitle),
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
        actions: <Widget>[

          IconButton(
            onPressed: (){

              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ContactData(user: widget.user,)),
              );

            },
            icon: Icon(Icons.email),
          ),
        ],
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
              },currentWidget: widgetStatus,),
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


