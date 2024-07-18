import 'package:flutter/material.dart';
import 'package:task_ayot/data/models/coordinate_model.dart';

class CoordinateWidget extends StatelessWidget {
  const CoordinateWidget(
      {super.key, this.coordinateModel, this.refreshMode = false});

  final CoordinateModel? coordinateModel;
  final bool refreshMode;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (refreshMode)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(strokeWidth: 1)),
            ),
          Text(
            "Latitude: ${coordinateModel == null ? "__.__" : coordinateModel!.latitude}\nLongitude: ${coordinateModel == null ? "__.__" : coordinateModel!.longitude}",
            style: const TextStyle(fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
