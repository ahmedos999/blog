import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget textfield(String label, String hint, bool hidden, TextInputType type,
    IconData icon, TextEditingController controller) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(color: Colors.black, fontSize: 16),
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 3,
                offset: const Offset(0, 1), // changes position of shadow
              ),
            ],
          ),
          child: TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            controller: controller,
            obscureText: hidden,
            keyboardType: type,
            style: const TextStyle(color: Colors.black),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintStyle: GoogleFonts.poppins(
                fontSize: 16,
                color: Colors.black45,
              ),
              hintText: hint,
              focusColor: Colors.grey,
              suffixIcon: Icon(icon, size: 25, color: const Color(0xff606470)),
              enabledBorder: UnderlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.white54,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Color(0xff93DEFF)),
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget btn(
  String btnText,
) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xff0099c9),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ) // foreground
        ),
    onPressed: () {
      //   Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => const HomePage()),
      // );
    },
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          Text(
            btnText,
            style: GoogleFonts.poppins(
              fontSize: 20,
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          const Icon(Icons.login)
        ],
      ),
    ),
  );
}

Widget post(String username, String post, String date, String icontext,
    int commentsNum, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 16),
    child: Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xffEAF6F6),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 3,
              blurRadius: 4,
              offset: const Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            children: [
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: const Color(0xffF0E5CF),
                  child: Text(
                    icontext,
                    style: GoogleFonts.poppins(
                        color: const Color(0xff4B6587),
                        fontSize: 22,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                title: Text(
                  username,
                  style: GoogleFonts.poppins(
                      color: const Color(0xff0099c9),
                      fontSize: 18,
                      fontWeight: FontWeight.w400),
                ),
                subtitle: Text(post,
                    style: GoogleFonts.poppins(
                        fontSize: 16, fontWeight: FontWeight.w400)),
                trailing: Text(date,
                    style: GoogleFonts.poppins(
                        fontSize: 12, fontWeight: FontWeight.w400)),
              ),
              Center(
                child: Text(
                  'Comments ($commentsNum)',
                  style: GoogleFonts.poppins(
                      decoration: TextDecoration.underline,
                      fontSize: 18,
                      fontWeight: FontWeight.w400),
                ),
              )
            ],
          ),
        ),
      ),
    ),
  );
}

Widget comment(
    String username, String iconText, String comment, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 25,
          backgroundColor: const Color(0xffF0E5CF),
          child: Text(
            iconText,
            style: GoogleFonts.poppins(
                color: const Color(0xff4B6587),
                fontSize: 22,
                fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: const Color(0xffEAF6F6),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 3,
                blurRadius: 4,
                offset: const Offset(0, 2), // changes position of shadow
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                username,
                style: GoogleFonts.poppins(
                    color: const Color(0xff0099c9),
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
              Text(comment,
                  style: GoogleFonts.poppins(
                      fontSize: 16, fontWeight: FontWeight.w400)),
            ]),
          ),
        )
      ],
    ),
  );
}
