import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tdd_clean_architecture/presentation/bloc/weather_bloc.dart';
import 'package:flutter_tdd_clean_architecture/presentation/widgets/weather_data.dart';

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
