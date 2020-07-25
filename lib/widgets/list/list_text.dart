import "package:flutter/material.dart";

class ListText extends StatelessWidget {
  const ListText({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Container(
          height: 170,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment:MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: 10.0),
                      child: Text("恋上不一样的春天（荷兰比利时德国游记）", style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                    Container(
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 4,
                            height: 28,
                            color: Color(0xFF4abdcc),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 5.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("2018.5.2", style: TextStyle(color: Colors.white, fontSize: 14.0)),
                                Text("比利时,根特", style: TextStyle(color: Colors.white, fontSize: 14.0))
                              ],
                            ),
                          )
                        ],
                      )
                    )
                  ],
                ),
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 30,
                      height: 30,
                      child: CircleAvatar(
                        radius: 36.0,
                        backgroundImage: NetworkImage("http://photos.breadtrip.com/avatar_f1_4f_b1e996072051f4ad38781bdb41e82b0faabc728b.jpg-avatar.m"),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Text("by 比利时,根特", style: TextStyle(color: Colors.white, fontSize: 12.0))
                    )
                  ],
                ),
              ),
            ],
          )
        )
      )
    );
  }
}