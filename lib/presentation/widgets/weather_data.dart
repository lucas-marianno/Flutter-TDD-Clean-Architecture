import 'package:flutter/material.dart';
import 'package:flutter_tdd_clean_architecture/core/constants/constants.dart';
import 'package:flutter_tdd_clean_architecture/domain/entities/weather.dart';

class WeatherData extends StatelessWidget {
  const WeatherData({required this.data, super.key});
  final WeatherEntity data;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${data.cityName} - ${data.country}',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            Image(
              image: NetworkImage(
                Urls.weatherIcon(data.iconCode),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          "${data.main} | ${data.description}",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 30),
        Center(
          child: Table(
            border: TableBorder.all(),
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              TableRow(children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Temperature'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    (data.temperature - 273.15).toStringAsFixed(2),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ]),
              TableRow(children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Pressure'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    data.pressure.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ]),
              TableRow(children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Humidity'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    data.humidity.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ])
            ],
          ),
        )
      ],
    );
  }
}
