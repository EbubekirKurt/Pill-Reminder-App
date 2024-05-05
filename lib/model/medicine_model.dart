import 'package:intl/intl.dart';

class MedicineModel {
  String? name;
  String? time;
  int? count;
  int? period;
  String? userId;
  String? id;
  stateEnum? state;

  MedicineModel({this.name, this.time, this.count, this.period, this.userId,this.state=stateEnum.notYet});

  MedicineModel.fromJson(Map<String, dynamic> json) {
    json['stats'];
    name = json['name'];
    time = json['time'];
    count = json['count'];
    period = json['period'];
    userId = json['user_id'];
    id = json['id'];

    state = json['stats'].toString().contains("stateEnum.notYet")? stateEnum.notYet  : json['stats'].toString().contains("stateEnum.skip") ? stateEnum.skip:  json['stats'].toString().contains("stateEnum.take") ? stateEnum.take :stateEnum.reschedule;

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = name;
    data['time'] = time;
    data['count'] = count;
    data['period'] = period;
    data['user_id'] = userId;
    data['id'] = id;
    data['state']=state;
    return data;
  }

  String getTimeWithAmPm(String time) {
    // Parse the time string (assuming it's in HH:mm format)
    List<String> timeParts = time.split(':');
    int hour = int.parse(timeParts[0]);
    int minute = int.parse(timeParts[1]);

    // Create a DateTime object with today's date and the parsed hour and minute
    DateTime dateTime = DateTime(DateTime.now().year, DateTime.now().month,
        DateTime.now().day, hour, minute);

    // Format the DateTime object to include AM/PM
    DateFormat format = DateFormat.jm(); // Use 'jm' format for AM/PM in Arabic
    return format.format(dateTime);
  }

  String getTime(String time) {
    // Parse the time string (assuming it's in HH:mm format)
    List<String> timeParts = time.split(':');
    int hour = int.parse(timeParts[0]);
    int minute = int.parse(timeParts[1]);

    // Create a DateTime object with today's date and the parsed hour and minute
    DateTime dateTime = DateTime(DateTime.now().year, DateTime.now().month,
        DateTime.now().day, hour, minute);

    // Format the DateTime object to include AM/PM
    DateFormat format = DateFormat.Hm();
    return format.format(dateTime);
  }
}

enum stateEnum{skip,take,reschedule,notYet}