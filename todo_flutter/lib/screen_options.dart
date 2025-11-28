import 'package:flutter/material.dart';

class ScreenOptions extends StatelessWidget {
  const ScreenOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose'),
      ),
      body: GridView(
        padding: EdgeInsets.all(16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 25),
        children: [
          MenuWidget(
              menuTitle: 'ServerPod',
              ontap: () {
                //---------------servopod section is disabled because of other features.
                //---------------will cause inititate errors.

                // if (sessionManager!.isSignedIn) {

                //   Navigator.of(context).pushReplacement(MaterialPageRoute(
                //     builder: (context) => ScreenLogin(),
                //   ));
                // } else {
                //   Navigator.of(context).pushReplacement(MaterialPageRoute(
                //     builder: (context) => ScreenHome(),
                //   ));
                // }
              }),
          MenuWidget(
            menuTitle: 'SqlFlite DB Demo',
            ontap: () {},
          )
        ],
      ),
    );
  }
}

class MenuWidget extends StatelessWidget {
  const MenuWidget({
    super.key,
    required this.menuTitle,
    required this.ontap,
  });

  final String menuTitle;
  final VoidCallback ontap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.blue),
            borderRadius: BorderRadius.circular(8),
            color: Colors.blue.withValues(alpha: 0.2)),
        height: 200,
        child: Center(
          child: Text('test'),
        ),
      ),
    );
  }
}
