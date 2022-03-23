import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _profilePic(size),
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              margin: EdgeInsets.all(12),
              child: Text(
                'Nombre del usuario',
                style: TextStyle(
                  fontSize: 35,
                ),
              ),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Pais',
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
                Text(
                  'Edad: ',
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Profesión: ',
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                  Text(
                    'Signo ',
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(),
            ),
            BottomAppBarDesing(),
          ],
        ),
        Positioned(
          top: 50,
          left: 15,
          child: FloatingActionButton(
            backgroundColor: Colors.indigo[500],
            child: Icon(Icons.keyboard_return, color: Colors.white, size: 30),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
      ]),
    );
  }

  Container _profilePic(Size size) {
    return Container(
      height: size.height / 2,
      width: double.infinity,
      color: Colors.transparent,
      child: FadeInImage(
        fit: BoxFit.cover,
        placeholder: AssetImage('assets/jar-loading.gif'),
        // image: AssetImage('assets/no-image.png'),
        image: NetworkImage(
            'https://cloudfront-us-east-1.images.arcpublishing.com/elcomercio/W6ADOV64VBES5OEO6RVDHJCMD4.jpg'),
      ),
    );
  }
}

class BottomAppBarDesing extends StatelessWidget {
  const BottomAppBarDesing({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(50),
        topRight: Radius.circular(50),
      ),
      child: BottomAppBar(
        color: Colors.indigo,
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10.0, left: 50.0, right: 50.0),
          child: Container(
            margin: EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FloatingActionButton(
                  heroTag: null,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.edit,
                    size: 30,
                    color: Colors.indigo,
                  ),
                  onPressed: () {},
                ),
                FloatingActionButton(
                  backgroundColor: Colors.red,
                  heroTag: null,
                  child: Icon(
                    Icons.delete,
                    size: 30,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
