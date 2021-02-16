// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:songlyrics/logic/weatherbloc/bloc/weather_bloc.dart';
// import 'package:songlyrics/models/weather_condition_model.dart';
// import 'package:songlyrics/theme/color.dart';
// import 'package:songlyrics/theme/mediaquery.dart';
// import 'package:weather_icons/weather_icons.dart';

// class HomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     DeviceOrientation deviceOrientation = DeviceOrientation();
//     deviceOrientation.init(context);
//     return Container(
//       height: DeviceOrientation.screenHeight,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           BlocConsumer<WeatherBloc, WeatherState>(
//             listener: (context, state) {
//               if (state is WeatherLoadError) {
//                 ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                   backgroundColor: Pallete.errorColor,
//                   content: Text('Check Internet Connection'),
//                 ));
//               }
//             },
//             builder: (context, state) {
//               if (state is WeatherLoaded) {
//                 return Expanded(child: upperWeatherContainer(state));
//               }
//               if (state is WeatherLoading) {
//                 return Expanded(
//                   child: Center(child: SpinKitCircle(color: Pallete.color2)),
//                 );
//               }
//               if (state is WeatherLoadError) {
//                 // BlocProvider.of<WeatherBloc>(context)
//                 //     .add(FetchedWeatherTypedCity(query: 'London'));
//               }
//               return Expanded(
//                 child: Center(
//                   child: SpinKitFadingFour(
//                     duration: Duration(seconds: 1),
//                     color: Pallete.color2,
//                   ),
//                 ),
//               );
//             },
//           ),
//           foreCastContainer(),
//         ],
//       ),
//     );
//   }
// }

// upperWeatherContainer(WeatherLoaded state) {
//   return Column(
//     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//     crossAxisAlignment: CrossAxisAlignment.center,
//     children: [
//       countryName(state),
//       SizedBox(height: DeviceOrientation.screenHeight * 0.02),
//       weatherDetailsContainer(state),
//       windDetails(state)
//     ],
//   );
// }

// Column windDetails(WeatherLoaded state) {
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.center,
//     children: [
//       Text(
//         'Wind',
//         style: Pallete.textStyle.copyWith(
//             fontSize: 17, fontWeight: FontWeight.w100, fontFamily: 'Bold'),
//       ),
//       Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           BoxedIcon(
//             WeatherIcons.barometer,
//             color: Pallete.color4,
//             size: DeviceOrientation.longestSide * 0.035,
//           ),
//           SizedBox(width: DeviceOrientation.screenWidth * 0.025),
//           Text('${state.weather.windSpeed.toInt()}m/s',
//               style: Pallete.textStyle.copyWith(fontSize: 17)),
//         ],
//       )
//     ],
//   );
// }

// countryName(WeatherLoaded state) {
//   var cityName = state.weather.cityName;
//   var temp = state.weather.temperature;
//   var long = state.weather.longitude;
//   var lat = state.weather.latitude;
//   var country = state.weather.countryName;
//   return Column(
//     children: [
//       SizedBox(height: DeviceOrientation.screenHeight * 0.03),
//       Text(
//         '$cityName/$country',
//         style: TextStyle(
//           color: Pallete.textColor,
//           fontSize: 20,
//           fontFamily: 'Bold',
//         ),
//       ),
//       Text(
//         'Now',
//         style: TextStyle(
//           color: Pallete.textColor.withOpacity(0.7),
//           fontSize: 20,
//           fontFamily: 'Medium',
//         ),
//       ),
//     ],
//   );
// }

// Container weatherDetailsContainer(WeatherLoaded state) {
//   var cityName = state.weather.cityName;
//   var temp = state.weather.temperature;
//   var long = state.weather.longitude;
//   var lat = state.weather.latitude;
//   var country = state.weather.countryName;
//   var condition = state.weather.condition;
//   return Container(
//     // height: DeviceOrientation.screenHeight * 0.5,
//     child: Column(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Container(
//           height: DeviceOrientation.screenHeight * 0.3,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               BoxedIcon(
//                 WeatherCondition.getIcon(condition),
//                 color: Pallete.textColor,
//                 size: DeviceOrientation.longestSide * 0.09,
//               ),
//               Text(
//                 '${temp.toInt()}°',
//                 style: TextStyle(
//                     color: Pallete.textColor,
//                     fontSize: DeviceOrientation.longestSide * 0.08,
//                     fontFamily: 'Bold',
//                     fontWeight: FontWeight.bold),
//               ),
//               Text(
//                 WeatherCondition.getMessage(condition),
//                 style: Pallete.textStyle.copyWith(fontSize: 17),
//               ),
//             ],
//           ),
//         ),
//         SizedBox(height: 20),
//       ],
//     ),
//   );
// }

// foreCastContainer() {
//   return Container(
//     color: Pallete.color3,
//     height: DeviceOrientation.screenHeight * 0.25,
//     child: ListView.builder(
//       itemCount: 4,
//       itemBuilder: (context, _) {
//         return Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             Text(
//               'Tue,Apr 14',
//               style: Pallete.textStyle.copyWith(fontSize: 15),
//             ),
//             BoxedIcon(WeatherIcons.day_rain, color: Pallete.textColor),
//             Text(
//               '11°23°',
//               style: Pallete.textStyle.copyWith(fontSize: 15),
//             )
//           ],
//         );
//       },
//     ),
//   );
// }

// // Widget searchTextFiled({Function(String) onChanged}) {
// //   return TextField(
// //     onChanged: onChanged,
// //   );
// // }
