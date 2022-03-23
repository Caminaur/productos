import 'package:flutter/material.dart';

dynamic showMyDialog(context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.grey[100],
        title: Text('Seleccione una imagen o tome una fotografía'),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                child: Column(
                  children: [
                    Icon(Icons.camera_alt, size: 50, color: Colors.indigo),
                    TextButton(
                      child: const Text('Cámara',
                          style: TextStyle(fontSize: 17, color: Colors.indigo)),
                      onPressed: () {
                        Navigator.of(context).pop(1);
                      },
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.of(context).pop(1);
                },
              ),
              InkWell(
                  child: Column(
                    children: [
                      Icon(Icons.storage, size: 50, color: Colors.indigo),
                      TextButton(
                        child: const Text('Galería',
                            style:
                                TextStyle(fontSize: 17, color: Colors.indigo)),
                        onPressed: () {
                          Navigator.of(context).pop(2);
                        },
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.of(context).pop(2);
                  }),
              Column(
                children: [
                  TextButton(
                    child:
                        Icon(Icons.close_rounded, color: Colors.red, size: 40),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      );
    },
  );
}
