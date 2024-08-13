import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tdd_clean_architecture/core/constants/constants.dart';
import 'package:flutter_tdd_clean_architecture/domain/entities/weather.dart';
import 'package:flutter_tdd_clean_architecture/presentation/bloc/weather_bloc.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        centerTitle: true,
        title: const Text(
          'WEATHER',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(
                fillColor: Colors.grey[200],
                filled: true,
                border: const OutlineInputBorder(borderSide: BorderSide.none),
                hintText: 'Enter city name',
              ),
              onChanged: (value) {
                context.read<WeatherBloc>().add(CityChanged(value));
              },
            ),
            const SizedBox(height: 50),
            BlocBuilder<WeatherBloc, WeatherState>(
              builder: (context, state) {
                if (state is WeatherLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is WeatherLoaded) {
                  final data = state.weatherResult;
                  return WeatherData(
                    data: data,
                    key: const Key('weather_data'),
                  );
                }
                if (state is WeatherLoadFailure) {
                  return Center(child: Text(state.failure));
                } else {
                  return const SizedBox();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

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
