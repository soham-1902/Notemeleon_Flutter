import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sign_up/firebase_options.dart';
import 'package:flutter_sign_up/src/common_widgets/notes_card.dart';
import 'package:flutter_sign_up/src/features/authentication/screens/note_editor.dart';
import 'package:flutter_sign_up/src/features/authentication/screens/note_reader.dart';
import 'package:flutter_sign_up/src/features/authentication/screens/welcome_screen.dart';
import 'package:flutter_sign_up/src/my_style/AppStyle.dart';
import 'package:flutter_sign_up/src/repository/authentication_repository/authentication_repository.dart';
import 'package:flutter_sign_up/src/utils/themes/theme.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform).then((value) => Get.put(AuthenticationRepository()));

  runApp(const MyApp());
}

class Globals {
  static var uId = (FirebaseAuth.instance.currentUser?.email)!;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const WelcomeScreen(),
    );
  }
}

class AppHome extends StatefulWidget {
  const AppHome({Key? key}) : super(key: key);

  @override
  State<AppHome> createState() => _AppHomeState();
}

class _AppHomeState extends State<AppHome> {

  @override
  void initState() {
    super.initState();
    Globals.uId = (FirebaseAuth.instance.currentUser?.email)!;
  }

  @override
  Widget build(BuildContext context) {
    Globals.uId = (FirebaseAuth.instance.currentUser?.email)!;
    return Scaffold(
      backgroundColor: AppStyle.mainColor,
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.green,
              ),
              child: Align(
                alignment: Alignment.topCenter,
                child: SvgPicture.asset("assets/images/chameleon_image.svg"),
              ),
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                AuthenticationRepository.instance.logout();
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text("Notemeleon"),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text('Add Note'),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => NoteEditorScreen()));
        },
        icon: Icon(Icons.add),

      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Your Notes", style: GoogleFonts.roboto(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              fontSize: 22
              ),),
            /*ElevatedButton(onPressed: () {
              FirebaseFirestore.instance.collection(Globals.uId).add({
                "key":"value" //your data which will be added to the collection and collection will be created after this
              }).then((_){
                print("collection created");
              }).catchError((_){
                print("an error occured");
              });
            }, child: Text('Press')),*/
            SizedBox(
              height: 20.0,
            ),
            Flexible(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection(Globals.uId).snapshots(),
                builder: (context, AsyncSnapshot snapshot) {
                  if(snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if(snapshot.hasData) {
                    return GridView(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                      children: snapshot.data!.docs.map<Widget>((note) => NoteCard(() {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => NoteReaderScreen(note)));
                      }, note)).toList(),
                    );
                  }
                  return Text("There are no notes!", style: GoogleFonts.nunito(color: Colors.white,),);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
