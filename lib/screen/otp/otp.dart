import 'package:flutter/material.dart';

import '../../one_signal/services/notification_serv.dart';

class Otp extends StatelessWidget {
  const Otp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          children: [
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter your OTPCode',
              ),
            ),
            const SizedBox(height: 25),
            ElevatedButton(
              onPressed: () {
                String userExternalId = "83674";
                sendNotification(userExternalId);
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
