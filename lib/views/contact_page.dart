import 'package:flutter/material.dart';
import 'package:mailto/mailto.dart';
import 'package:unicons/unicons.dart';
import 'package:url_launcher/url_launcher.dart' as ulaunch;

class ContactPage extends StatefulWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Me'.tr()),
      ),
      body: Column(
        children: [
          ListTile(
            leading: const Icon(
              Icons.email_rounded,
              color: Colors.redAccent,
            ),
            onTap: () {
              var url = Mailto(
                to: ['ettet1001@gmail.com'],
              ).toString();
              ulaunch.launchUrl(Uri.parse(url));
            },
            title: const Text('Email'.tr()),
            subtitle: const Text('ettet1001@gmail.com'),
          ),
          
        ],
      ),
    );
  }
}
