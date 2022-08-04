import 'package:flutter/cupertino.dart';

class LoadingPlaceholder extends StatelessWidget {
  const LoadingPlaceholder({Key? key, this.message = 'Cargando'})
      : super(key: key);
  final String message;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CupertinoActivityIndicator(),
          const SizedBox(height: 20),
          Text(message),
        ],
      ),
    );
  }
}
