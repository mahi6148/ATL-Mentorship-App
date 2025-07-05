import 'dart:math';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:atl_membership/models/ModelProvider.dart';
import 'package:flutter/foundation.dart';

class TeamTableService{
  static Future<String?> createTeam(String userId)async {
    try{
      final teamCode = _generateTeamCode(userId);
      final TeamTable team= TeamTable(
        team_code: teamCode,
          team_members:[userId]
      );
      final request = ModelMutations.create(
        team,
        authorizationMode: APIAuthorizationType.userPools,
      );
      final response = await Amplify.API.mutate(request: request).response;
      if (response.hasErrors) {
        safePrint("Response errors: ${response.errors}");
        return null;
      }
      safePrint(response.data);
      return response.data?.id;

    }catch (e) {
      if (kDebugMode) {
        print('Error updating policy: $e');
      }
      return null;
    }

  }

 static  String _generateTeamCode(String userId) {
    // Get current timestamp (last 6 digits for brevity)
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final timestampStr = timestamp.toString();
    final shortTimestamp = timestampStr.substring(timestampStr.length - 6);

    // Get first 3 characters of userId (or pad if shorter)
    final userPrefix = userId.length >= 3
        ? userId.substring(0, 3).toUpperCase()
        : userId.padRight(3, 'X').toUpperCase();

    // Simple random 2-digit number (0-99)
    final random = Random().nextInt(100);
    final randomStr = random.toString().padLeft(2, '0');

    // Combine: USER + TIMESTAMP + RANDOM
    // Example: ABC123456789 -> ABC345689
    return '$userPrefix$shortTimestamp$randomStr';
  }



  static Future<void> exitTeam(String teamCode,String userId) async{
    try{
      final queryPredicate = TeamTable.ID.eq(teamCode);

      final teamRequest = ModelQueries.list<TeamTable>(TeamTable.classType,where: queryPredicate,limit: 1,authorizationMode: APIAuthorizationType.userPools);
      final teamResponse =await Amplify.API.query(request: teamRequest).response;
      final team = teamResponse.data?.items.first;

      if(team==null){
        safePrint("team response is $team and does not exist");
        return;
      }

      final newTeamMembers = team.team_members;
      newTeamMembers?.remove(userId);

      final updateTeamRequest = ModelMutations.update(
        team.copyWith(team_members: newTeamMembers),
        where: queryPredicate,
        authorizationMode: APIAuthorizationType.userPools
      );
      final updateTeamResponse = await Amplify.API.mutate(request: updateTeamRequest).response;
      final updatedTeam = updateTeamResponse.data;
      if(updatedTeam==null||updateTeamResponse.hasErrors){
        safePrint("error while exiting team: ${updateTeamResponse.errors}");
        return;
      }
      return;
    }catch (e) {
      if (kDebugMode) {
        print('Error updating policy: $e');
      }
    }
  }
}