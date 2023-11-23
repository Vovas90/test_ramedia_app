import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:io';

class Services {
  static Future<bool> checkConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

  static bool checkIP(String ip) {
    final ipv4RegExp = RegExp(
      r'^([0-9]{1,3}\.){3}[0-9]{1,3}$',
    );

    return ipv4RegExp.hasMatch(ip);
  }

  static Future<bool> checkLocationAllowed() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print('Access to location denied');
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      print('Location permissions are permanently denied');
      return false;
    }

    return true;
  }

  ///ДОПОЛНИТЕЛЬНЫЕ МЕТОДЫ ФИЛЬТРАЦИИ
  static bool checkUserCountry(String country) {
    if (country == "USA" || country == "Ukraine") {
      return true;
    }
    return false;
  }

  static bool checkUserAge(int age) {
    if (age >= 18) {
      return true;
    }
    return false;
  }

  static bool checkUserOS() {
    if (Platform.isAndroid) {
      return true;
    }
    return false;
  }

  ///ДОСТУП К ГАЛЕРЕЕ И ФАЙЛАМ
  //Этот метод демонстрирует, как получить доступ к галерее и документам на устройстве
  Future<void> pickFiles() async {
    try {
      //Можно настроить типы файлов и другие параметры
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.any, //Можно ограничить тип файла, если нужно
      );

      if (result != null) {
        PlatformFile file = result.files.first;

        //Здесь можно использовать файл, например, загрузить его
        //или использовать его содержимое
        print('File selected: ${file.name}');
      } else {
        //В случае, если юзер отменил выбор файла
        print('File canceled');
      }
    } catch (e) {
      // Обработка ошибок
      print('Error is: $e');
    }
  }
}
