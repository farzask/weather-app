import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_weather_app/bloc/weather_bloc_bloc.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget weatherIcon(int code) {
    if (code >= 200 && code <= 232) {
      //thunderstorm
      return Image.asset('assets/1.png', scale: 2);
    }

    //drizzle
    else if (code >= 300 && code <= 321) {
      return Image.asset('assets/2.png', scale: 2);
    }

    //rain
    else if (code >= 500 && code <= 531) {
      return Image.asset('assets/3.png', scale: 2);
    }

    //snow
    else if (code >= 600 && code <= 622) {
      return Image.asset('assets/4.png', scale: 2);
    }

    //mist
    else if (code >= 700 && code <= 741) {
      return Image.asset('assets/5.png', scale: 2);
    }

    //sunny
    else if (code == 800) {
      return Image.asset('assets/6.png', scale: 2);
    }

    //partly cloudy
    else if (code == 801 || code == 802) {
      return Image.asset('assets/7.png', scale: 2);
    }

    //cloudy
    else if (code == 803 || code == 804) {
      return Image.asset('assets/8.png', scale: 2);
    }
    //else
    else {
      return Image.asset('assets/2.png', scale: 2);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color.fromARGB(255, 159, 186, 228),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 30, left: 30, right: 30),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                const Align(
                  alignment: Alignment.topRight,
                  child: Image(
                    image: AssetImage('assets/Vector.png'),
                  ),
                ),
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                    ),
                  ),
                ),
                BlocBuilder<WeatherBlocBloc, WeatherBlocState>(
                  builder: (context, state) {
                    if (state is WeatherBlocSuccess) {
                      return SizedBox(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Image(
                                    image: AssetImage('assets/location.png')),
                                Text(
                                  '${state.weather.areaName}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Center(
                              child: Column(
                                children: [
                                  Text(
                                    'Today, ${DateFormat('EEE dd MMM').format(state.weather.date!)}',
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 26,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'Updated as of ${DateFormat('hh:mm a').format(state.weather.date!)}',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.white,
                                    ),
                                  ),
                                  //getting the weather condition icon
                                  weatherIcon(
                                    state.weather.weatherConditionCode!.toInt(),
                                  ),
                                  //weather condition
                                  Text(
                                    state.weather.weatherMain!,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 25,
                                    ),
                                  ),
                                  Text(
                                    '${state.weather.temperature!.celsius!.round()}°C',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 50,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),

                            //details box
                            Container(
                              height: 170,
                              decoration: BoxDecoration(
                                  color:
                                      const Color(0xffB4D2FF).withOpacity(0.6),
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(14)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        details(
                                            'assets/thermometer.png',
                                            'Feels Like',
                                            '${state.weather.tempFeelsLike!.celsius!.round()}°C'),
                                        details('assets/wind.png', 'Wind Speed',
                                            '${state.weather.windSpeed!} m/s',
                                            scale: 16),
                                      ],
                                    ),
                                    Divider(
                                      color: Colors.white.withOpacity(0.4),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        details('assets/drop.png', 'Humidity',
                                            '${state.weather.humidity} %',
                                            scale: 10),
                                        details(
                                          'assets/thermometer.png',
                                          'High/Low    ',
                                          '${state.weather.tempMax!.celsius!.round()}/${state.weather.tempMin!.celsius!.round()} °C',
                                        ),
                                      ],
                                    ),
                                    Divider(
                                      color: Colors.white.withOpacity(0.4),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        details(
                                            'assets/sun.png',
                                            'Sunrise',
                                            DateFormat().add_jm().format(
                                                state.weather.sunrise!)),
                                        details(
                                            'assets/moon.png',
                                            'Sunset         ',
                                            DateFormat()
                                                .add_jm()
                                                .format(state.weather.sunset!),
                                            scale: 14),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            // Row(
                            //   mainAxisAlignment:
                            //       MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     details('assets/13.png', 'Temp Max',
                            //         '${state.weather.tempMax!.celsius!.round()}°C'),
                            //     details('assets/14.png', 'Temp Min',
                            //         '${state.weather.tempMin!.celsius!.round()}°C'),
                            //   ],
                            // ),
                          ],
                        ),
                      );
                    } else {
                      return Container();
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Row details(String path, String title, String info, {double scale = 8}) {
  return Row(
    children: [
      Image.asset(
        path,
        scale: scale,
      ),
      const SizedBox(
        width: 10,
      ),
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w300,
          ),
        ),
        Text(
          info,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ])
    ],
  );
}
