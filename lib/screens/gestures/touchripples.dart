import 'package:flutter/material.dart';

class Touch extends StatelessWidget {
  const Touch({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Touch ripple demo'),
      ),
      body: const Center(
        child: MyButton(),
      ),
    );
  }
}

class MyButton extends StatelessWidget {
  const MyButton({super.key});

  @override
  Widget build(BuildContext context) {
    // The InkWell wraps the custom flat button widget.
    return InkWell(
      // When the user taps the button, show a snackbar.
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Tap'),
        ));
      },
      splashColor: Theme.of(context).colorScheme.primary,
      child: Padding(
        padding: EdgeInsets.all(25),
        child: Text('Flat Button'),
      ),
    );
  }
}