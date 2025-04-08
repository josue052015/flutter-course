import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:img_caching/screens/custom_cache_manager.dart';
import 'package:img_caching/screens/img_screen.dart';
import 'package:visibility_detector/visibility_detector.dart';
//import 'package:img_caching/screens/img_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  // This widget is the root of your application.
  late ScrollController _scrollController;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _initialAnimationDone = false;
  bool _isTitleVisible = true;

  void initState() {
    super.initState();

    _scrollController = ScrollController();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 0), // usaremos el value directamente
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    // Ejecutar animación inicial
    _animationController.forward().whenComplete(() {
      // Después de la animación inicial, conectamos con el scroll
      setState(() {
        _initialAnimationDone = true;
      });
    });

    _scrollController.addListener(() {
      if (_initialAnimationDone) {
        // Mapea el offset del scroll entre 0 y 200 (puedes ajustarlo)
        double scrollOffset = _scrollController.offset.clamp(0, 100);
        double value = 1 - (scrollOffset / 100); // 1.0 → 0.0
        _animationController.value = value;
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Scaffold(
        appBar: AppBar(
          // title: Center(child: Text('Image caching')),
          backgroundColor: Color(0xFF213E4C),
          leading: IconButton(
            icon: Icon(Icons.close),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF223a44),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ), // Ícono con cuadritos
            onPressed: () {
              // Acción al presionar el ícono de cuadritos
            },
          ),
          title: _isTitleVisible ? Text('') : Text('klk', style: TextStyle(color: Colors.white, ),),
          actions: [
            IconButton(
              icon: Icon(Icons.grid_view),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF223a44),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ), // Ícono con cuadritos
              onPressed: () {
                // Acción al presionar el ícono de cuadritos
              },
            ),
            IconButton(
              icon: Icon(Icons.upload),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF223a44),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ), // Ícono con cuadritos
              onPressed: () {
                // Acción al presionar el ícono de cuadritos
              },
            ),
          ],
        ),
        body: Container(
          color: Color(0xFF213E4C),
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Container(
              margin: EdgeInsets.only(top: 35),
              padding: const EdgeInsets.only(left: 16, right: 16),
              decoration: BoxDecoration(
                color: Color(0xFF1a202e),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Column(
                    children: [
                      const Divider(height: 20, color: Colors.transparent),
                      // Sección superior (por ejemplo, el nombre/ID + emojis)
                      Row(
                        children: [
                          SizedBox(width: 100),
                          // Texto (ejemplo de dirección o nombre de usuario)
                          Expanded(
                            child: VisibilityDetector(
                              key: Key('a1123'),
                              onVisibilityChanged: (VisibilityInfo info) {
                                setState(() {
                                  _isTitleVisible = info.visibleFraction > 0;
                                });
                              },
                              child: Text(
                                'shdDTMAL4ghcsLQUB4Vp',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          // Podrías poner algunos emojis o íconos a la derecha
                          // Ejemplo: Icon(Icons.emoji_emotions)
                        ],
                      ),

                      // Línea divisoria (opcional)
                      const Divider(height: 30, color: Colors.transparent),

                      // Opciones en forma de ListTiles
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFF222737),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ListTile(
                          iconColor: Colors.white,
                          textColor: Colors.white,
                          leading: const Icon(Icons.lock),
                          title: const Text('Backup recovery phrase'),
                          // Podemos simular un badge de notificación en trailing:
                          trailing: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              const Icon(Icons.arrow_forward_ios, size: 16),
                              // Indicador rojo (badge)
                              Positioned(
                                right: 14,
                                top: -4,
                                child: Container(
                                  width: 8,
                                  height: 8,
                                  decoration: const BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          onTap: () {
                            // Acción al pulsar
                          },
                        ),
                      ),
                      const Divider(height: 20, color: Colors.transparent),
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFF222737),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          children: [
                            // Primer ListTile: "Edit Profile"
                            ListTile(
                              iconColor: Colors.white,
                              textColor: Colors.white,
                              leading: Icon(Icons.edit), // Ícono de edición
                              title: Text('Edit Profile'),
                              trailing: Icon(
                                Icons.arrow_forward_ios,
                                size: 16,
                                color: Colors.white,
                              ),
                              onTap: () {
                                // Acción al pulsar en "Edit Profile"
                              },
                            ),
                            // Separador entre los dos ListTiles
                            Divider(
                              color: Colors.white12,
                              thickness: 1,
                              height: 1,
                            ),
                            // Segundo ListTile: "Password"
                            ListTile(
                              iconColor: Colors.white,
                              textColor: Colors.white,
                              leading: Icon(Icons.lock), // Ícono de candado
                              title: Text('Password'),
                              trailing: Icon(
                                Icons.arrow_forward_ios,
                                size: 16,
                                color: Colors.white,
                              ),
                              onTap: () {
                                // Acción al pulsar en "Password"
                              },
                            ),
                          ],
                        ),
                      ),
                      const Divider(height: 20, color: Colors.transparent),
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFF222737),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          children: [
                            // ListTile: "Messages"
                            ListTile(
                              iconColor: Colors.white,
                              textColor: Colors.white,
                              leading: Icon(
                                Icons.message,
                              ), // Icono para "Messages"
                              title: Text('Messages'),
                              trailing: Icon(
                                Icons.arrow_forward_ios,
                                size: 16,
                                color: Colors.white,
                              ),
                              onTap: () {
                                // Acción al pulsar "Messages"
                              },
                            ),
                            Divider(
                              color: Colors.white12,
                              thickness: 1,
                              height: 1,
                            ),
                            // ListTile: "Wallet"
                            ListTile(
                              iconColor: Colors.white,
                              textColor: Colors.white,
                              leading: Icon(
                                Icons.account_balance_wallet,
                              ), // Icono de cartera
                              title: Text('Wallet'),
                              trailing: Icon(
                                Icons.arrow_forward_ios,
                                size: 16,
                                color: Colors.white,
                              ),
                              onTap: () {
                                // Acción al pulsar "Wallet"
                              },
                            ),
                            Divider(
                              color: Colors.white12,
                              thickness: 1,
                              height: 1,
                            ),
                            // ListTile: "Keycard"
                            ListTile(
                              iconColor: Colors.white,
                              textColor: Colors.white,
                              leading: Icon(
                                Icons.credit_card,
                              ), // Icono de tarjeta
                              title: Text('Keycard'),
                              trailing: Icon(
                                Icons.arrow_forward_ios,
                                size: 16,
                                color: Colors.white,
                              ),
                              onTap: () {
                                // Acción al pulsar "Keycard"
                              },
                            ),
                          ],
                        ),
                      ),

                      const Divider(height: 20, color: Colors.transparent),
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFF222737), // Fondo oscuro
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          children: [
                            // 1. Privacy and security
                            ListTile(
                              iconColor: Colors.white,
                              textColor: Colors.white,
                              leading: Icon(Icons.lock_outline),
                              title: Text('Privacy and security'),
                              trailing: Icon(
                                Icons.arrow_forward_ios,
                                size: 16,
                                color: Colors.white,
                              ),
                              onTap: () {
                                // Acción al pulsar
                              },
                            ),
                            Divider(
                              color: Colors.white12,
                              thickness: 1,
                              height: 1,
                            ),
                            // 2. Syncing
                            ListTile(
                              iconColor: Colors.white,
                              textColor: Colors.white,
                              leading: Icon(Icons.sync),
                              title: Text('Syncing'),
                              trailing: Icon(
                                Icons.arrow_forward_ios,
                                size: 16,
                                color: Colors.white,
                              ),
                              onTap: () {
                                // Acción al pulsar
                              },
                            ),
                            Divider(
                              color: Colors.white12,
                              thickness: 1,
                              height: 1,
                            ),
                            // 3. Notifications
                            ListTile(
                              iconColor: Colors.white,
                              textColor: Colors.white,
                              leading: Icon(Icons.notifications_outlined),
                              title: Text('Notifications'),
                              trailing: Icon(
                                Icons.arrow_forward_ios,
                                size: 16,
                                color: Colors.white,
                              ),
                              onTap: () {
                                // Acción al pulsar
                              },
                            ),
                            Divider(
                              color: Colors.white12,
                              thickness: 1,
                              height: 1,
                            ),
                            // 4. Appearance
                            ListTile(
                              iconColor: Colors.white,
                              textColor: Colors.white,
                              leading: Icon(Icons.format_paint),
                              title: Text('Appearance'),
                              trailing: Icon(
                                Icons.arrow_forward_ios,
                                size: 16,
                                color: Colors.white,
                              ),
                              onTap: () {
                                // Acción al pulsar
                              },
                            ),
                            Divider(
                              color: Colors.white12,
                              thickness: 1,
                              height: 1,
                            ),
                            // 5. Language and currency
                            ListTile(
                              iconColor: Colors.white,
                              textColor: Colors.white,
                              leading: Icon(Icons.language),
                              title: Text('Language and currency'),
                              trailing: Icon(
                                Icons.arrow_forward_ios,
                                size: 16,
                                color: Colors.white,
                              ),
                              onTap: () {
                                // Acción al pulsar
                              },
                            ),
                          ],
                        ),
                      ),

                      const Divider(height: 20, color: Colors.transparent),
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFF222737), // Fondo oscuro
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ListTile(
                          iconColor: Colors.white,
                          textColor: Colors.white,
                          leading: Icon(
                            Icons.settings_outlined,
                          ), // Ícono de engrane
                          title: Text('Advanced'),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                            color: Colors.white,
                          ),
                          onTap: () {
                            // Acción al pulsar "Advanced"
                          },
                        ),
                      ),

                      const Divider(height: 20, color: Colors.transparent),
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFF222737),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          children: [
                            ListTile(
                              iconColor: Colors.white,
                              textColor: Colors.white,
                              leading: Icon(Icons.explore),
                              title: Text('Explore'),
                              trailing: Icon(
                                Icons.arrow_forward_ios,
                                size: 16,
                                color: Colors.white,
                              ),
                              onTap: () {
                                // Acción para Explore
                              },
                            ),
                            Divider(
                              color: Colors.white12,
                              thickness: 1,
                              height: 1,
                            ),
                            ListTile(
                              iconColor: Colors.white,
                              textColor: Colors.white,
                              leading: Icon(Icons.settings),
                              title: Text('Settings'),
                              trailing: Icon(
                                Icons.arrow_forward_ios,
                                size: 16,
                                color: Colors.white,
                              ),
                              onTap: () {
                                // Acción para Settings
                              },
                            ),
                            Divider(
                              color: Colors.white12,
                              thickness: 1,
                              height: 1,
                            ),
                            ListTile(
                              iconColor: Colors.white,
                              textColor: Colors.white,
                              leading: Icon(Icons.notifications),
                              title: Text('Notifications'),
                              trailing: Icon(
                                Icons.arrow_forward_ios,
                                size: 16,
                                color: Colors.white,
                              ),
                              onTap: () {
                                // Acción para Notifications
                              },
                            ),
                            Divider(
                              color: Colors.white12,
                              thickness: 1,
                              height: 1,
                            ),
                            ListTile(
                              iconColor: Colors.white,
                              textColor: Colors.white,
                              leading: Icon(Icons.person),
                              title: Text('Profile'),
                              trailing: Icon(
                                Icons.arrow_forward_ios,
                                size: 16,
                                color: Colors.white,
                              ),
                              onTap: () {
                                // Acción para Profile
                              },
                            ),
                          ],
                        ),
                      ),

                      const Divider(height: 20, color: Colors.transparent),
                    ],
                  ),
                  Positioned(
                    left: 5,
                    top: -20,
                    child: ScaleTransition(
                      scale: _scaleAnimation,
                      child: ClipOval(
                        child: CachedNetworkImage(
                          imageUrl:
                              "https://tripleenableapi.triplecyber.com/api/v1/Profile/UserPhoto/velvetlullaby2044@tripleenableanonymous.com?height=300&width=300",
                          cacheManager: MyCustomCacheManager(),
                          width: 80,
                          height: 80,
                          fit:
                              BoxFit
                                  .cover, // Para que la imagen cubra el círculo
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
