import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_ayot/data/enums/permission_status.dart';
import 'package:task_ayot/data/models/coordinate_model.dart';
import 'package:task_ayot/logic/main_screen_cubit.dart';

import '../widgets/coordinate_widget.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  CoordinateModel? currentCoordinate;

  Widget _locationWidgetSelector(PermissionStatus status) {
    switch (status) {
      case PermissionStatus.denied:
        return _deniedLocation("Please grant location permission!");
      case PermissionStatus.permanentlyDenied:
        return _deniedLocation(
            "You permanently denied location permission! change this from settings");
      case PermissionStatus.unableToDetermine:
        return const Text("Turn on GPS!");
      default:
        return const Text("Somethings went wrong!");
    }
  }

  Widget _deniedLocation(String message) {
    return Column(
      children: [
        Text(message),
        OutlinedButton(
            onPressed: () {
              context.read<MainScreenCubit>().requestPermission();
            },
            child: const Text("Grant permission"))
      ],
    );
  }

  Widget _currentLocation() {
    return Column(
      children: [
        const Text("Your current location"),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: StreamBuilder(
            stream: context.read<MainScreenCubit>().periodicStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data != null) {
                  currentCoordinate = snapshot.data;
                }
              }
              return CoordinateWidget(
                  coordinateModel: currentCoordinate,
                  refreshMode: snapshot.data == null);
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {



        },
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: Colors.grey, borderRadius: BorderRadius.circular(16)),
            child: Center(
              child: BlocBuilder<MainScreenCubit, MainScreenState>(
                buildWhen: (previous, current) => current is PermissionState,
                builder: (context, state) {
                  if (state is PermissionState) {
                    return _currentLocation();
                  }
                  return const Text("Somethings went wrong!");
                },
              ),
            ),
          ),
          // Container(
          //   padding: const EdgeInsets.all(16),
          //   margin: const EdgeInsets.all(16),
          //   decoration: BoxDecoration(
          //       color: Colors.grey, borderRadius: BorderRadius.circular(16)),
          //   child: ListView.builder(itemBuilder: itemBuilder),
          // )
        ],
      ),
    );
  }
}