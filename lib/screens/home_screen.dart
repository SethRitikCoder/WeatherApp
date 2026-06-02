import 'dart:math';

import 'package:flutter/material.dart';
import 'package:weatherapp/providers/weather_provider.dart';
import 'package:weatherapp/widgets/uihelper.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:intl/intl.dart';

class MyWeatherScreen extends StatefulWidget {
  const MyWeatherScreen({super.key});

  @override
  State<MyWeatherScreen> createState() => _MyWeatherScreenState();
}

class _MyWeatherScreenState extends State<MyWeatherScreen> {
  List<String> cities = [
    "Delhi",
    "Mumbai",
    "Kolkata",
    "Chennai",
    "Bangalore",
    "Hyderabad",
    "Pune",
    "Ahmedabad",
    "Jaipur",
    "Lucknow",
  ];
  final random = Random();

  late String randomcity = cities[random.nextInt(cities.length)];
  // String get randomcity => cities[random.nextInt(cities.length)];

  TextEditingController searchcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final screenheight = MediaQuery.of(context).size.height;
    final screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(backgroundColor: Colors.blue, elevation: 0),
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF4FACFE), Color(0xFF00F2FE)],
              begin: AlignmentGeometry.topCenter,
              end: AlignmentGeometry.bottomCenter,
            ),
          ),
          child: Column(
            children: [
              SizedBox(height: screenwidth * 0.03),
              Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: TextFormField(
                        textInputAction: TextInputAction.search, //new
                        onFieldSubmitted: (value) {
                          if (value.isNotEmpty) {
                            context.read<WeatherProvider>().fetchData(
                              searchcontroller.text,
                            );
                            FocusScope.of(context).unfocus();
                          }
                        },
                        controller: searchcontroller,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: InputDecoration(
                          hintText: "Search $randomcity",
                          hintStyle: TextStyle(
                            color: Colors.white.withValues(alpha: 0.7),
                            fontWeight: FontWeight.bold,
                          ),
                          isDense: true,
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.orange.shade700,
                          ),
                          prefixIconColor: Colors.orange.shade700,

                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          fillColor: Colors.white.withValues(alpha: 0.3),
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              width: 4,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 5),
                    SizedBox(
                      child: Uihelper.custombutton(
                        buttonName: "Search",
                        callback: () {
                          if (searchcontroller.text.isNotEmpty) {
                            context.read<WeatherProvider>().fetchData(
                              searchcontroller.text,
                            );
                            FocusScope.of(context).unfocus();
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: Consumer<WeatherProvider>(
                  builder: (context, provider, child) {
                    if (provider.isLoading) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (provider.errormessage.isNotEmpty) {
                      return Center(child: Text(provider.errormessage));
                    }
                    if (provider.weatherdata != null) {
                      final weathers = provider.weatherdata!;
                      final sunrise = DateTime.fromMillisecondsSinceEpoch(
                        weathers.sys!.sunrise! * 1000,
                      );
                      final sunriseTime = DateFormat('hh:mm a').format(sunrise);

                      final sunset = DateTime.fromMillisecondsSinceEpoch(
                        weathers.sys!.sunset! * 1000,
                      );

                      final sunsetTime = DateFormat('hh:mm a').format(sunset);

                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              height: screenheight * 0.07,
                              width: screenwidth * 0.9,
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.5),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Colors.white,
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Image.network(
                                    "https://openweathermap.org/img/wn/${weathers.weather[0]!.icon}@4x.png",
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Uihelper.customText(
                                          data:
                                              "${weathers.weather[0]!.description}",
                                          size: 13.5,
                                          color: Colors.black,
                                          weight: FontWeight.bold,

                                          family: "Inter24",
                                        ),

                                        Uihelper.customText(
                                          data:
                                              "Feels Like-${weathers.main?.feelsLike.round() ?? ""}°C",
                                          size: 15,
                                          color: Colors.black,
                                          weight: FontWeight.bold,

                                          family:
                                              GoogleFonts.poppins().fontFamily,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: screenheight * 0.01),
                            Container(
                              height: screenheight * 0.07,
                              width: screenwidth * 0.9,

                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.5),
                                borderRadius: BorderRadius.circular(10),

                                border: Border.all(
                                  color: Colors.white,
                                  width: 1,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 20,
                                ),
                                child: Row(
                                  // mainAxisAlignment:
                                  // MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          WeatherIcons.sunrise,
                                          color: Colors.orange.shade700,
                                        ),
                                        SizedBox(width: screenwidth * 0.026),
                                        Uihelper.customText(
                                          data:
                                              "SunRise:-${sunriseTime.toString()}",
                                          size: 13,
                                          color: Colors.black,
                                          weight: FontWeight.bold,

                                          family: "Inter24",
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: screenwidth * 0.02),

                                    Row(
                                      children: [
                                        Icon(
                                          WeatherIcons.sunset,
                                          color: Colors.orange.shade700,
                                        ),
                                        SizedBox(width: screenwidth * 0.026),
                                        Uihelper.customText(
                                          data:
                                              "SunSet:-${sunsetTime.toString()}",
                                          size: 13,
                                          color: Colors.black,
                                          weight: FontWeight.bold,

                                          family: "Inter24",
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            SizedBox(height: screenheight * 0.01),
                            Container(
                              height: screenheight * 0.38,
                              width: screenwidth * 0.9,
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                  color: Colors.white,
                                ),
                                color: Colors.white.withValues(alpha: 0.4),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      BoxedIcon(
                                        WeatherIcons.thermometer,
                                        color: Colors.orange.shade700,
                                        size: 40,
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.location_pin,
                                            color: Colors.orange.shade700,
                                          ),
                                          Uihelper.customText(
                                            data: "${weathers.name}",
                                            size: 22,
                                            color: Colors.black,
                                            weight: FontWeight.bold,
                                            family: "Inter24",
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Uihelper.customText(
                                        data:
                                            "${weathers.main?.temp.toStringAsFixed(1) ?? 0}",

                                        // data:"${weathers.main!.tempMax}°C",
                                        size: 125,
                                        color: Colors.white,
                                        weight: FontWeight.w100,
                                        family: GoogleFonts.oswald().fontFamily,
                                      ),
                                      Uihelper.customText(
                                        data: "°C",

                                        // data:"${weathers.main!.tempMax}°C",
                                        size: 50,
                                        color: Colors.white,
                                        weight: FontWeight.w100,
                                        family: "Oswald",
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: screenheight * 0.03),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.end, //round() ka use
                                    children: [
                                      Uihelper.customText(
                                        data:
                                            "Max:${weathers.main?.tempMax.toStringAsFixed(1) ?? ""}°C /Min:${weathers.main?.tempMin.toStringAsFixed(1) ?? ""}°C",
                                        size: 15,
                                        color: Colors.black,
                                        weight: FontWeight.bold,

                                        family:
                                            GoogleFonts.poppins().fontFamily,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      height: screenheight * 0.12,
                                      width: screenwidth * 0.4,
                                      decoration: BoxDecoration(
                                        color: Colors.white.withValues(
                                          alpha: 0.4,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 1,
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          BoxedIcon(
                                            WeatherIcons.humidity,
                                            color: Colors.orange.shade700,
                                            size: 40,
                                          ),
                                          Uihelper.customText(
                                            data:
                                                "humidity:${weathers.main?.humidity ?? ""}%",
                                            size: 13,
                                            family: "Inter24",
                                            color: Colors.black,
                                            weight: FontWeight.w800,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Container(
                                      height: screenheight * 0.12,
                                      width: screenwidth * 0.4,
                                      decoration: BoxDecoration(
                                        color: Colors.white.withValues(
                                          alpha: 0.4,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 1,
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          BoxedIcon(
                                            WeatherIcons.strong_wind,
                                            color: Colors.orange.shade700,
                                            size: 40,
                                          ),
                                          Uihelper.customText(
                                            data:
                                                "Wind Speed:${weathers.wind?.speed ?? ""}Km/hr",
                                            size: 13,
                                            family: "Inter24",
                                            color: Colors.black,
                                            weight: FontWeight.w800,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: screenheight * 0.04),
                            // Divider(
                            //   color: Colors.white24,
                            //   indent: 40,
                            //   endIndent: 40,
                            // ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.code,
                                  color: Colors.black.withValues(alpha: 0.5),
                                  size: 13,
                                ),
                                Uihelper.customText(
                                  data: "Made By Ritik ",
                                  size: 13,
                                  color: Colors.black.withValues(alpha: 0.5),
                                  family: GoogleFonts.nunito().fontFamily,
                                  weight: FontWeight.bold,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.cloud,
                                  size: 13,
                                  color: Colors.black.withValues(alpha: 0.5),
                                ),
                                Uihelper.customText(
                                  data: "Data Provided By OpenWeathermap.org",
                                  size: 15,
                                  color: Colors.black.withValues(alpha: 0.5),
                                  family: "Caveat",
                                  weight: FontWeight.bold,
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }
                    return Center(
                      child: Uihelper.customText(
                        data: "Please Search Your City",
                        size: 22,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
