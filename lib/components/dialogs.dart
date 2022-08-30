import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:unicons/unicons.dart';
import 'package:url_launcher/url_launcher.dart' as ulaunch;

import '../app.dart';
import '../services/photon_sender.dart';

void privacyPolicyDialog(BuildContext context, String data) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Privacy policy'.tr()),
          content: SizedBox(
              height: MediaQuery.of(context).size.height / 2,
              width: MediaQuery.of(context).size.height / 1.2,
              child: Markdown(
                  listItemCrossAxisAlignment:
                      MarkdownListItemCrossAxisAlignment.start,
                  data: data)),
          actions: [
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Okay'.tr()))
          ],
        );
      });
}

progressPageAlertDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Alert'.tr()),
        content: const Text('Make sure that transfer is completed !'.tr()),
        actions: [
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Stay'.tr())),
          ElevatedButton(
            onPressed: () async {
              // ignore: use_build_context_synchronously
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/home', (Route<dynamic> route) => false);
            },
            child: const Text('Go back'.tr()),
          )
        ],
      );
    },
  );
}

progressPageWillPopDialog(context) async {
  bool willPop = false;
  await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Alert'.tr()),
        content: const Text('Make sure that download is completed !'.tr()),
        actions: [
          ElevatedButton(
              onPressed: () {
                willPop = false;
                Navigator.of(context).pop();
              },
              child: const Text('Stay'.tr())),
          ElevatedButton(
            onPressed: () async {
              willPop = true;
              // ignore: use_build_context_synchronously
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/home', (Route<dynamic> route) => false);
            },
            child: const Text('Go back'.tr()),
          )
        ],
      );
    },
  );
  return willPop;
}

sharePageAlertDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Server alert'.tr()),
        content: const Text('Would you like to terminate the current session'.tr()),
        actions: [
          ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Stay'.tr())),
          ElevatedButton(
            onPressed: () async {
              await PhotonSender.closeServer(context);
              // ignore: use_build_context_synchronously
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const App()),
                  (route) => false);
            },
            child: const Text('Terminate'.tr()),
          )
        ],
      );
    },
  );
}

sharePageWillPopDialog(context) async {
  bool willPop = false;
  await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Server alert'.tr()),
        content:
            const Text('Would you like to terminate the current session ?'.tr()),
        actions: [
          ElevatedButton(
              onPressed: () {
                willPop = false;
                Navigator.of(context).pop();
              },
              child: const Text('Stay'.tr())),
          ElevatedButton(
            onPressed: () async {
              await PhotonSender.closeServer(context);
              willPop = true;
              // ignore: use_build_context_synchronously
              Navigator.of(context).pop();
              // Navigator.of(context).pushAndRemoveUntil(
              //     MaterialPageRoute(builder: (context) => const App()),
              //     (route) => false);
            },
            child: const Text('Terminate'.tr()),
          )
        ],
      );
    },
  );
  return willPop;
}

senderRequestDialog(BuildContext context, String username, String os) async {
  bool allowRequest = false;
  await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Request from receiver'.tr()),
          content: Text(
              "$username ($os) is requesting for files. Would you like to share with them ?".tr()),
          actions: [
            ElevatedButton(
              onPressed: () {
                allowRequest = false;
                Navigator.of(context).pop();
              },
              child: const Text('Deny'.tr()),
            ),
            ElevatedButton(
              onPressed: () {
                allowRequest = true;
                Navigator.of(context).pop();
              },
              child: const Text('Accept'.tr()),
            )
          ],
        );
      });

  return allowRequest;
}

about(context) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('About'.tr()),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text(
                '',
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.close),
            )
          ],
        );
      });
}

credits(context) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Credits'.tr()),
          content: SizedBox(
            width: MediaQuery.of(context).size.width / 2,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Icons'.tr()),
                GestureDetector(
                  onTap: () {
                    ulaunch.launchUrl(Uri.parse('https://www.svgrepo.com'));
                  },
                  child: const Text(
                    'https://www.svgrepo.com/',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.blue,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text('Animations'.tr()),
                GestureDetector(
                  onTap: () {
                    ulaunch.launchUrl(Uri.parse('https://lottiefiles.com/'));
                  },
                  child: const Text(
                    'https://lottiefiles.com/',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.blue,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text('Font'.tr(), textAlign: TextAlign.center),
                GestureDetector(
                  onTap: () {
                    ulaunch.launchUrl(Uri.parse(
                        'https://scripts.sil.org/cms/scripts/page.php?site_id=nrsi&id=OFL'));
                  },
                  child: const Text(
                    """ Font license""",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
          ),
          actionsAlignment: MainAxisAlignment.end,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.close),
            )
          ],
        );
      });
}
