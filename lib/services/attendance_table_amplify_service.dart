import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/foundation.dart';
import '../models/attendanceTable.dart';

class AttendanceTableAmplifyService {
  static Future<attendanceTable?> getAttendanceById(String attendanceId) async {
    try {
      final queryPredicate = attendanceTable.ID.eq(attendanceId);
      final request = ModelQueries.list<attendanceTable>(
        attendanceTable.classType,
        limit: 1,
        where: queryPredicate,
        authorizationMode: APIAuthorizationType.userPools,
      );
      final response = await Amplify.API.query(request: request).response;

      if (response.hasErrors) {
        safePrint("Error getting attendance: ${response.errors}");
        return null;
      }
      return response.data?.items.firstOrNull;
    } catch (e) {
      if (kDebugMode) {
        print('Error getting attendance: $e');
      }
      return null;
    }
  }

  /// Create new attendance record
  static Future<bool> createAttendance(attendanceTable attendance) async {
    try {
      final request = ModelMutations.create(
        attendance,
        authorizationMode: APIAuthorizationType.userPools,
      );
      final response = await Amplify.API.mutate(request: request).response;

      if (response.hasErrors) {
        for (final error in response.errors) {
          safePrint("GraphQL Error: ${error.message}");
        }
        return false; // Return false on GraphQL errors
      }

      return true; // Successfully created attendance
    } catch (e) {
      if (kDebugMode) {
        print('Error creating attendance: $e');
      }
      return false; // Return false on exception
    }
  }

  static Future<bool> saveAttendance({
    required DateTime date,
    required double latitude,
    required double longitude,
    required int no_of_boys,
    required int no_of_girls,
    required int total,
    required String teachers, // Should be number of teachers as string
    required String start_time, // use HH:mm format
    required String end_time,
    required List<String> class_attended,
    required String module_name,
    required int module_no,
    required String remarks,
    required String topics_covered,
  }) async {
    try {
      // Convert time strings to proper format if needed
      String formatTimeString(String timeStr) {
        // If time is in "h:mm AM/PM" format, convert to 24-hour "HH:mm" format
        if (timeStr.contains('AM') || timeStr.contains('PM')) {
          // Parse and reformat
          final parts = timeStr.split(' ');
          final timePart = parts[0];
          final period = parts[1];

          final timeParts = timePart.split(':');
          int hour = int.parse(timeParts[0]);
          final minute = timeParts[1];

          if (period == 'PM' && hour != 12) {
            hour += 12;
          } else if (period == 'AM' && hour == 12) {
            hour = 0;
          }

          return '${hour.toString().padLeft(2, '0')}:$minute';
        }
        return timeStr; // Already in correct format
      }

      final newRecord = attendanceTable(
        date: TemporalDate(date),
        latitude: latitude,
        longitude: longitude,
        no_of_boys: no_of_boys,
        no_of_girls: no_of_girls,
        total: total,
        teachers: int.parse(teachers),
        start_time: TemporalTime.fromString(formatTimeString(start_time)),
        end_time: TemporalTime.fromString(formatTimeString(end_time)),
        class_attended: class_attended.join(','),
        module_name: module_name,
        module_no: module_no,
        remarks: remarks,
        topics_covered: topics_covered,
        timestamp: TemporalTimestamp.now(),
      );

      // Use the existing createAttendance method
      return await createAttendance(newRecord);

    } catch (e) {
      if (kDebugMode) {
        print('Error saving attendance: $e');
      }
      return false;
    }
  }
}