import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:op123/app/models/SettingResponse.dart';
import 'package:op123/app/services/RemoteService.dart';

final settingResponseProvider =
    StateNotifierProvider<SettingState, SettingResponse?>((ref) {
  return SettingState(null);
});

class SettingState extends StateNotifier<SettingResponse?> {
  SettingState(SettingResponse? state) : super(state) {
    fetch();
  }

  void change(SettingResponse? response) => state = response!;

  void fetch() async {
    Response response = await RemoteService().getSettings();
    if (response.statusCode == 200) {
      state = settingResponseFromMap(response.body);
    } else {
      throw Exception("Settings Can't be Loaded");
    }
  }
}
