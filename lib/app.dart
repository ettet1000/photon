import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:photon/components/dialogs.dart';
import 'package:photon/views/contact_page.dart';
import 'package:photon/views/widescreen_home.dart';
import 'package:unicons/unicons.dart';

import 'controllers/intents.dart';
import 'views/mobile_home.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  TextEditingController usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: const Color.fromARGB(255, 27, 32, 35),
        appBar: AppBar(
          backgroundColor: Colors.blueGrey.shade900,
          title: const Text(
            'Photon',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        drawer: Shortcuts(
          shortcuts: {
            LogicalKeySet(LogicalKeyboardKey.backspace): GoBackIntent()
          },
          child: Actions(
            actions: {
              GoBackIntent: CallbackAction<GoBackIntent>(onInvoke: (intent) {
                if (scaffoldKey.currentState!.isDrawerOpen) {
                  scaffoldKey.currentState!.openEndDrawer();
                }
                return null;
              })
            },
            child: Drawer(
              child: ListView(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/images/icon.png',
                          width: 75,
                          height: 75,
                        ),
                        const Text('Photon')
                      ],
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.privacy_tip_rounded),
                    onTap: () async {
                      String privacyPolicy = await rootBundle
                          .loadString('assets/texts/privacy_policy.txt');
                      // ignore: use_build_context_synchronously
                      privacyPolicyDialog(context, privacyPolicy);
                    },
                    title: const Text('Privacy policy'.tr()),
                  ),
                  ListTile(
                    title: const Text('Credits'.tr()),
                    leading: SvgPicture.asset('assets/icons/credits.svg',
                        color: Colors.white),
                    onTap: () {
                      credits(context);
                    },
                  ),
                  ListTile(
                    title: const Text('About'.tr()),
                    leading: const Icon(UniconsLine.info_circle),
                    onTap: () {
                      about(context);
                    },
                  ),
                  ListTile(
                    title: const Text('Contact Me'.tr()),
                    leading: const Icon(
                      UniconsLine.mailbox,
                    ),
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return const ContactPage();
                      }));
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Center(
          child: size.width > 720 ? const WidescreenHome() : const MobileHome(),
        ));
  }
}
