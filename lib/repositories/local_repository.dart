import 'dart:async';
import 'package:fluttercast/models/weather_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class SQLiteDbProvider {
  SQLiteDbProvider._();

  static final SQLiteDbProvider db = SQLiteDbProvider._();
  static Database _database;

  static final currentWeatherTable = "current_weather";
  static final futureWeatherTable = "future_weather";

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  initDB() async {
    var documentsDirectory = await getApplicationDocumentsDirectory();
    var path = join(documentsDirectory.path, "WeatherDB.db");

    return await openDatabase(path, version: 3, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE $currentWeatherTable ("
          "id INTEGER PRIMARY KEY,"
          "icon TEXT,"
          "location TEXT,"
          "weather TEXT,"
          "temperature REAL,"
          "humidity REAL,"
          "wind_speed REAL,"
          "sunrise INTEGER,"
          "sunset INTEGER,"
          "date INTEGER,"
          "sync_date INTEGER)");

      await db.execute("CREATE TABLE $futureWeatherTable ("
          "id INTEGER PRIMARY KEY,"
          "icon TEXT,"
          "location TEXT,"
          "weather TEXT,"
          "temperature REAL,"
          "humidity REAL,"
          "wind_speed REAL,"
          "sunrise INTEGER,"
          "sunset INTEGER,"
          "date INTEGER,"
          "sync_date INTEGER)");
    });
  }

  Future<List<WeatherModel>> getForecast() async {
    final db = await database;

    List<Map> results = await db.query(futureWeatherTable,
        columns: WeatherModel.columns, orderBy: "id ASC");

    List<WeatherModel> forecast = new List();
    results.forEach((result) {
      WeatherModel weather = WeatherModel.fromMap(result);
      forecast.add(weather);
    });
    return forecast;
  }

  Future<WeatherModel> getWeather() async {
    final db = await database;
    var result =
        await db.query(currentWeatherTable, columns: WeatherModel.columns);

    return result.isNotEmpty ? WeatherModel.fromMap(result.first) : Null;
  }

  insert(WeatherModel weather, String table) async {
    final db = await database;

    var result = await db.rawInsert(
        "REPLACE Into $table (id, icon, location, weather, temperature, humidity, wind_speed, sunrise, sunset, date, sync_date)"
        " VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
        [
          weather.id,
          weather.icon,
          weather.location,
          weather.weather,
          weather.temperature,
          weather.humidity,
          weather.windSpeed,
          weather.sunrise,
          weather.sunset,
          weather.date,
          weather.syncDate
        ]);

    return result;
  }
}
