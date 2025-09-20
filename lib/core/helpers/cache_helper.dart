import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper{
  static SharedPreferences? sharedPreferences ;

  static init()async{
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static putString({required String key,required String value})async
  {

    await init();
    return await sharedPreferences?.setString(key, value);

  }
  static putLanguage({required String value})async
  {

    await init();
    return await sharedPreferences?.setString('lang', value);

  }
  static putInt({required int value, required String key})async
  {

    await init();
    return await sharedPreferences?.setInt(key, value);

  }
  static Future<bool?> putBoolean(
      {
        required String key,
        required bool value,
      })async
  {
    return  await sharedPreferences?.setBool(key, value);
  }

  static bool? getBoolean(
      {
        required String key,
      })
  {
    return  sharedPreferences?.getBool(key);
  }


  static getData({required key})async
  {

    await init();
    return sharedPreferences?.getString(key);

  }
  static getInt({required key})async
  {

    await init();
    return sharedPreferences?.getInt(key);

  }

  static removeData({required key})async
  {

    await init();
    return sharedPreferences?.remove(key);

  }

}