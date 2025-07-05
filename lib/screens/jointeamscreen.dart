import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:atl_membership/controllers/AuthController.dart';
import 'package:atl_membership/controllers/UserTableController.dart';
import 'package:atl_membership/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/TeamTableService.dart';

class JoinTeamscreen extends StatefulWidget {
  const JoinTeamscreen({super.key});

  @override
  State<JoinTeamscreen> createState() => _JoinTeamscreenState();
}

class _JoinTeamscreenState extends State<JoinTeamscreen> {
  late final TextEditingController _searchController;
  late final UserController _userController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _searchController = TextEditingController();
    _userController = Get.find<UserController>();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _searchController.dispose();
    super.dispose();
  }

  void _createTeam() async {
    safePrint("user id is : ${_userController.userId}");
    final String? teamCode = await TeamTableService.createTeam(_userController.userId.value);
    if(teamCode!= null){
      safePrint("team code generated is $teamCode");
      Get.toNamed('${Routes.HOME}${Routes.TEAM}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          forceMaterialTransparency: true,
          backgroundColor: Colors.transparent,
          leading:IconButton(onPressed: (){Get.back();}, icon: Icon(Icons.arrow_back,color: Colors.black,size: 40,)) ,
        ),
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xFFEEF1F5),
        body: SingleChildScrollView(
          child: SizedBox(
            height: Get.height,
            width: Get.width,
            child: Column(
              spacing: 15,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image(image: AssetImage('assets/images/Emblem_of_Andhra_Pradesh.png'),height: 200,width: 200,),
                Text(
                  'Create team',
                  style: TextStyle(color: Colors.black, fontSize: 32),
                ),
                OutlinedButton(
                  onPressed: () => {
                    // Get.offNamed('${Routes.HOME}${Routes.TEAM}')
                    _createTeam()

                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  child: Text(
                    'Create new team',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      width: Get.width/3,
                      height: 1,
                      color: Colors.black,
                    ),
                    Text('or'),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      width: Get.width/3,
                      height: 1,
                      color: Colors.black,
                    ),
                  ],
                ),
                Text(
                  'Find a team',
                  style: TextStyle(color: Colors.black, fontSize: 32),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width/8),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue,width:2))
                    ),
                  ),
                ),
                OutlinedButton(onPressed: (){
                  safePrint("team code is ${_userController.teamId.value}");
                },style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ), child: Text('search',style: TextStyle(color: Colors.white),)),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
