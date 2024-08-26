import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = {
      'Name': 'UserName',
      'Email': 'xyz@test.com',
      'Gender': 'male',
      'About': 'A passionate film enthusiast who fejk;wn  jktjntwrfe pijt3rj loves exploring new genres.',
      'Age': '20',
      'Favorite Genres': ['Sci-Fi', 'Action', 'Drama'],
    };

    final userKeys = user.keys.toList();
    final userValues = user.values.toList();

    final TextStyle textStyle = TextStyle(
      fontFamily: 'AlfaSlabOne',
      color: Color(0xFF2EFE57),
    );

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Color(0xFFFFEED9)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: const Color(0xFF141414),
      ),
      backgroundColor: const Color(0xFF141414),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Card(
              color: Colors.black,
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage('images/img.png'),
                      backgroundColor: Colors.transparent,
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ShaderMask(
                            shaderCallback: (bounds) => LinearGradient(
                              colors: [Color(0xFF2EFE57), Color(0xFFA3FFE9)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ).createShader(bounds),
                            child: Text(
                              user['Name'].toString(),
                              style: textStyle.copyWith(
                                fontSize: 22,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            user['About'].toString(),
                            style: textStyle.copyWith(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 6,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Card(
              color: Colors.black,
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(userKeys.length, (index) {
                    final key = userKeys[index];
                    final value = userValues[index];

                    if (key == 'Favorite Genres') {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '$key:',
                              style: textStyle,
                            ),
                            SizedBox(height: 8),
                            Wrap(
                              spacing: 8,
                              children: (value as List<String>).map((genre) {
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 4, horizontal: 8),
                                  decoration: BoxDecoration(
                                    color: Color(0xFF2EFE57),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    genre,
                                    style: textStyle.copyWith(
                                      color: Colors.black,
                                      fontSize: 14,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              key,
                              style: textStyle,
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            Expanded(
                              child: Text(
                                value.toString(),
                                textAlign: TextAlign.end,
                                style: textStyle.copyWith(
                                  color: Color(0xFFFFEED9),
                                  fontSize: 12,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 6,
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
