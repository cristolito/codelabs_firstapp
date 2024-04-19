// lib/screens/home_page.dart

import 'package:codelabs_firstapp/screens/mixedlist_page.dart';
import 'package:flutter/material.dart';
import 'package:codelabs_firstapp/screens/generator_page.dart';
import 'package:codelabs_firstapp/screens/favorite_page.dart';
import 'package:codelabs_firstapp/screens/gridview_page.dart';
import 'package:codelabs_firstapp/screens/listview_page.dart';
import 'package:codelabs_firstapp/screens/layout1_page.dart';
import 'package:codelabs_firstapp/screens/form_page.dart';
import 'package:codelabs_firstapp/screens/snackbar_page.dart';
import 'package:codelabs_firstapp/screens/animate_widgets/image1_page.dart';
import 'package:codelabs_firstapp/screens/animate_widgets/image2_page.dart';
import 'package:codelabs_firstapp/screens/animate_widgets/third_page.dart';
import 'package:codelabs_firstapp/screens/networking/parse_json.dart';
import 'package:codelabs_firstapp/screens/networking/fetch.dart';
import 'package:codelabs_firstapp/screens/networking/update.dart';
import 'package:codelabs_firstapp/screens/networking/delete.dart';
import 'package:codelabs_firstapp/screens/networking/websocket.dart';
import 'package:codelabs_firstapp/screens/persistence/sqlite.dart';
import 'package:codelabs_firstapp/screens/persistence/readwrite.dart';
import 'package:codelabs_firstapp/screens/persistence/keyvalue.dart';
import 'package:codelabs_firstapp/screens/animations/pageroutetransition.dart';
import 'package:codelabs_firstapp/screens/animations/physicssimulations.dart';
import 'package:codelabs_firstapp/screens/animations/propertiescontainer.dart';
import 'package:codelabs_firstapp/screens/animations/fadewidget.dart';
import 'package:codelabs_firstapp/screens/effects/download_button.dart';
import 'package:codelabs_firstapp/screens/effects/navigationflow.dart';
import 'package:codelabs_firstapp/screens/effects/photofilter.dart';
import 'package:codelabs_firstapp/screens/effects/parallaxeffect.dart';
import 'package:codelabs_firstapp/screens/effects/loadingeffect.dart';
import 'package:codelabs_firstapp/screens/effects/menuanimation.dart';
import 'package:codelabs_firstapp/screens/effects/typingindicator.dart';
import 'package:codelabs_firstapp/screens/effects/expandablefab.dart';
import 'package:codelabs_firstapp/screens/effects/gradientchatbubbles.dart';
import 'package:codelabs_firstapp/screens/effects/dragui.dart';
import 'package:codelabs_firstapp/screens/gestures/touchripples.dart';
import 'package:codelabs_firstapp/screens/gestures/handletaps.dart';
import 'package:codelabs_firstapp/screens/gestures/swipedismiss.dart';

const routeHome = '/';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;

  Widget _getPage() {
    switch (selectedIndex) {
      case 0:
        return GeneratorPage();
      case 1:
        return FavoritePage();
      case 2:
        return GridViewPage();
      case 3:
        return ListViewPage();
      case 4:
        return Layout1Page();
      case 5:
        return FormPage();
      case 6:
        return SnackBarPage();
      case 7:
        return MixedListPage(
          items: List<ListItem>.generate(
            100,
            (i) => i % 6 == 0
                ? HeadingItem('Heading $i')
                : MessageItem('Sender $i', 'Message body $i'),
          ),
        );
      case 8:
        return FirstRoute();
      case 9:
        return MainScreen();
      case 10:
        return ThirdPage();
      
      case 12:
        return Fetch();
      case 13:
        return UpdatePage();
      case 14:
        return Delete();
      case 15:
        return WebSocket();
      case 16:
        return Parse();
      case 17:
        return Sqlite();
      case 18:
        return ReadWrite(storage: CounterStorage());
      case 19:
        return KeyValuePage();
      case 20:
        return Page1();
      case 21:
        return PhysicsCardDragDemo();
      case 22:
        return AnimatedContainerApp();
      case 23:
        return Fade();
      case 24:
        return ExampleCupertinoDownloadButton();
      case 25:
        return FlowPage();
      case 26:
        return ExampleInstagramFilterSelection();
      case 27:
        return ExampleParallax();
      case 28:
        return ExampleUiLoadingAnimation();
      case 29:
        return ExampleStaggeredAnimations();
      case 30:
        return ExampleIsTyping();
      case 31: 
        return ExampleExpandableFab();
      case 32: 
        return ExampleGradientBubbles();
      case 33: 
        return ExampleDragAndDrop();
      case 34:
        return Touch();
      case 35:
        return HandleTaps();
      case 36:
        return Dismiss();
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          appBar: AppBar(title: Text('App de Gustavo Hernández')),
          body: _getPage(),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
               DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
              ),
              child: Text('Encabezado Drawer'),
            ),
            ListTile(
              title: const Text('Generador Palabras'),
              onTap: () {
                setState(() {
                      selectedIndex = 0;
                    });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Favoritos/Lista horizontal'),
              onTap: () {
                setState(() {
                      selectedIndex = 1;
                    });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Grid/cambio # en orientacion'),
              onTap: () {
                setState(() {
                      selectedIndex = 2;
                    });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Lista+floating app+image'),
              onTap: () {
                setState(() {
                      selectedIndex = 3;
                    });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Layout'),
              onTap: () {
                setState(() {
                      selectedIndex = 4;
                    });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Form/POST'),
              onTap: () {
                setState(() {
                      selectedIndex = 5;
                    });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Snackbar,GoogleFonts,TabBar'),
              onTap: () {
                setState(() {
                      selectedIndex = 6;
                    });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Lista de items mezclados'),
              onTap: () {
                setState(() {
                      selectedIndex = 7;
                    });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Widget animado/firstroute'),
              onTap: () {
                setState(() {
                      selectedIndex = 8;
                    });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Widget animado con imagen'),
              onTap: () {
                setState(() {
                      selectedIndex = 9;
                    });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('navigator.pushnamed'),
              onTap: () {
                setState(() {
                      selectedIndex = 10;
                    });
                Navigator.pop(context);
              },
            ),
            
            ListTile(
              title: const Text('Fetch/GET'),
              onTap: () {
                setState(() {
                      selectedIndex = 12;
                    });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Update/PUT'),
              onTap: () {
                setState(() {
                      selectedIndex = 13;
                    });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Delete/DELETE'),
              onTap: () {
                setState(() {
                      selectedIndex = 14;
                    });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('WebSocket'),
              onTap: () {
                setState(() {
                      selectedIndex = 15;
                    });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('parseJSON'),
              onTap: () {
                setState(() {
                      selectedIndex = 16;
                    });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Sqlite CRUD'),
              onTap: () {
                setState(() {
                      selectedIndex = 17;
                    });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Read/Write local file'),
              onTap: () {
                setState(() {
                      selectedIndex = 18;
                    });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Keyvalue storage'),
              onTap: () {
                setState(() {
                      selectedIndex = 19;
                    });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Pageroute transition'),
              onTap: () {
                setState(() {
                      selectedIndex = 20;
                    });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Physics simulations'),
              onTap: () {
                setState(() {
                      selectedIndex = 21;
                    });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Properties of a container'),
              onTap: () {
                setState(() {
                      selectedIndex = 22;
                    });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Fade container'),
              onTap: () {
                setState(() {
                      selectedIndex = 23;
                    });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Download button'),
              onTap: () {
                setState(() {
                      selectedIndex = 24;
                    });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Navigation flow'),
              onTap: () {
                setState(() {
                      selectedIndex = 25;
                    });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Photo filter carrousel'),
              onTap: () {
                setState(() {
                      selectedIndex = 26;
                    });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Parallax effect'),
              onTap: () {
                setState(() {
                      selectedIndex = 27;
                    });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Loading effect'),
              onTap: () {
                setState(() {
                      selectedIndex = 28;
                    });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Menu animation'),
              onTap: () {
                setState(() {
                      selectedIndex = 29;
                    });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Typing animation'),
              onTap: () {
                setState(() {
                      selectedIndex = 30;
                    });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Expandable FAB'),
              onTap: () {
                setState(() {
                      selectedIndex = 31;
                    });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Gradient chat bubbles'),
              onTap: () {
                setState(() {
                      selectedIndex = 32;
                    });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Draggable UI element'),
              onTap: () {
                setState(() {
                      selectedIndex = 33;
                    });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Touch ripple'),
              onTap: () {
                setState(() {
                      selectedIndex = 34;
                    });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Handle Taps'),
              onTap: () {
                setState(() {
                      selectedIndex = 35;
                    });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Swipe to dismiss'),
              onTap: () {
                setState(() {
                      selectedIndex = 36;
                    });
                Navigator.pop(context);
              },
            ),
          ],
            ),
          ),
        );
      },
    );
  }
}
