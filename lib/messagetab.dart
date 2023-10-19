import 'package:flutter/material.dart';


class MessagesTab extends StatefulWidget {
  @override
  _MessagesTabState createState() => _MessagesTabState();
}

class _MessagesTabState extends State<MessagesTab>
    with SingleTickerProviderStateMixin {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
 late TabController _controller;
  bool _switchButton = false;

  List<Widget> list = [
    Tab(
      icon:Icon( Icons.message),
      height: 20,
    ),
    Tab(
      icon:   Icon(Icons.message),
        height: 20,
      ),

  ];

  List _choices = [
    {
      'title': 'Interest\nAccepted',
      'icon': 'assets/icons/dash/M2.6.1_InterestsAccepted.svg',
    },
    {
      'title': 'Swayamwar\nReminder',
      'icon': 'assets/icons/dash/M2.6.2_SwayamwarReminder.svg',
    },
    {
      'title': 'Voice Call\nReminder',
      'icon': 'assets/icons/dash/M2.6.3_VoiceCallReminder.svg',
    },
    {
      'title': 'Video Call\nReminder',
      'icon': 'assets/icons/dash/M2.6.4_VideoCallReminder.svg',
    },
    {
      'title': 'Meet\nReminder',
      'icon': 'assets/icons/dash/M2.6.5_MeetReminder.svg',
    },
  ];
  int _selectedChoice = 0;

  void _onSelectedChoice(int index) {
    setState(() {
      _selectedChoice = index;
    });
  }

  bool ?_allSelected = true;

  List _filters = [
    {
      'title': 'Highly Rated',
      'icon': Icons.thumb_up_outlined,
    },
    {
      'title': 'Highly Viewed',
      'icon': Icons.local_fire_department_outlined,
    },
    {
      'title': 'Verified',
      'icon': Icons.check_circle_outlined,
    },
    {
      'title': 'New',
      'icon': Icons.person_add_outlined,
    },
    {
      'title': 'In Abroad',
      'icon': Icons.flight_outlined,
    }
  ];

  int _selectedCard = 0;

  selectCard(int index) {
    setState(() {
      _selectedCard = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TabController(length: list.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
      automaticallyImplyLeading: false,
      // leading: IconButton(
      //   icon: Icon(
      //     Icons.arrow_back_outlined,
      //     color: Colors.white,
      //   ),
      //   onPressed: () {
      //     Navigator.pop(context);
      //   },
      // ),
      title: Text("Messages"),
      backgroundColor: Colors.grey.shade800,
      elevation: 0,
      actions: [
        Row(
          children: [
            Switch(
              value: _switchButton,
              onChanged: (value) {
                setState(() {
                  _switchButton = value;
                });
              },
              activeColor: Colors.lightGreen[400],
            ),
          ],
        ),
      ],
    );
    return Scaffold(
      key: _scaffoldKey,
      appBar: appBar,
      body: LayoutBuilder(builder: (
          BuildContext context,
          BoxConstraints viewportConstraints,
          ) {
        return SingleChildScrollView(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              // call this method here to hide soft keyboard
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: Container(
              constraints:
              BoxConstraints(minHeight: viewportConstraints.biggest.height),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildFilter(),
                  Container(
                    height: viewportConstraints.biggest.height * 0.12,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        return _buildTabs(_choices[index]['icon'],
                            _choices[index]['title'], index);
                      },
                      itemCount: _choices.length,
                    ),
                  ),
                  Container(
                    height: viewportConstraints.biggest.height * 0.85,
                    width: double.infinity,
                    child: Column(
                      children: [
                        Container(
                          height: viewportConstraints.biggest.height * 0.08,
                          padding: EdgeInsets.symmetric(
                           // horizontal: defaultPadding / 2,
                          ),
                          child: Row(
                            children: [
                              Container(
                                child: Icon(
                                  Icons.mic,
                                  size: 30,
                                )
                              ),
                              Container(
                                child: Checkbox(
                                  value: _allSelected,
                                  onChanged: (value) {
                                    setState(() {
                                      _allSelected = value ;
                                    });
                                  },
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  child: TabBar(
                                    onTap: (index) {},
                                    controller: _controller,
                                    tabs: list,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: viewportConstraints.biggest.height * 0.77,
                          child: TabBarView(controller: _controller, children: [
                            ListView.builder(
                              itemCount: 10,
                              itemBuilder: (context, index) => _buildCard(
                                  viewportConstraints,
                                  selectCard,
                                  index,
                                  _selectedCard),
                            ),
                            ListView.builder(
                              itemCount: 10,
                              itemBuilder: (context, index) =>
                                  _buildCard2(viewportConstraints),
                            ),
                          ]),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Container _buildFilter() {
    return Container(
      alignment: Alignment.centerRight,
      child: PopupMenuButton(
        padding: EdgeInsets.zero,
        icon: Icon(
          Icons.more_horiz_outlined,
          color: Colors.grey.shade800,
        ),
        itemBuilder: (BuildContext context) => List.generate(
          _filters.length,
              (index) => PopupMenuItem(
            padding: EdgeInsets.zero,
            child: ListTile(
              leading: Container(
                height: double.infinity,
                child: Icon(
                  _filters[index]['icon'],
                  size: 20,
                  color: Colors.grey.shade800,
                ),
              ),
              title: Text(
                '${_filters[index]['title']}',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabs(String icon, String title, int index) {
    return GestureDetector(
      onTap: () {
        _onSelectedChoice(index);
      },
      child: Container(
        margin: EdgeInsets.only(
         // left: defaultPadding / 4,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
            //  margin: EdgeInsets.only(bottom: defaultMargin / 4),
              child: Icon(
                Icons.mic,

              )
            ),
            Container(
              padding: EdgeInsets.symmetric(
                //horizontal: defaultPadding / 1.5,
              //  vertical: defaultPadding / 6,
              ),
              decoration: BoxDecoration(
                color: _selectedChoice == index ? Colors.grey.shade800 : Colors.grey.shade400,
               // borderRadius: BorderRadius.circular(radius + 20),
              ),
              child: Row(
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: _selectedChoice == index ? Colors.white : Colors.grey.shade800,
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _buildCard(BoxConstraints viewportConstraints, Function selectCard,
      int index, int selectedCard) {
    return Container(
      child: Stack(
        children: [
          Positioned(
            left: -10,
            top: 0,
            bottom: 0,
            child: Transform.scale(
              scale: 0.6,
              child: Radio(
                // fillColor:
                //     MaterialStateProperty.resolveWith((states) => dColor2),
                activeColor: Colors.grey.shade800,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                value: index,
                groupValue: selectedCard,
                onChanged: (int ?index) {
                  selectCard(index);
                },
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              // vertical: defaultPadding / 4,
              // horizontal: defaultPadding,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildProfileSection(viewportConstraints),
                SizedBox(
                 // width: defaultMargin / 4,
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(
                   //   bottom: defaultPadding / 2,
                    ),
                    decoration: BoxDecoration(
                      border: Border(
                     //   bottom: BorderSide(color: dark.withOpacity(0.2)),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 2,
                          child: _buildProfileDetailsSection(),
                        ),
                        SizedBox(
                         // width: defaultMargin / 2,
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.bottomRight,
                                  child: RichText(
                                    text: TextSpan(
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: "left",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey.shade800,
                                          ),
                                        ),
                                        TextSpan(
                                          text: " 9 days",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey.shade800,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                // SizedBox(
                                //   height: defaultMargin,
                                // ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    _buildSkip(),
                                    //_buildMessage(),
                                    _buildCall(),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container _buildCard2(BoxConstraints viewportConstraints) {
    return Container(
      padding: EdgeInsets.symmetric(
        // vertical: defaultPadding / 4,
        // horizontal: defaultPadding,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProfileSection(viewportConstraints),
          SizedBox(
           // width: defaultMargin / 4,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(
              //  bottom: defaultPadding / 2,
              ),
              decoration: BoxDecoration(
                border: Border(
                 // bottom: BorderSide(color: dark.withOpacity(0.2)),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: _buildProfileDetailsSection(),
                  ),
                  SizedBox(
                  //  width: defaultMargin / 2,
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.bottomRight,
                            child: RichText(
                              text: TextSpan(
                                children: <TextSpan>[
                                  TextSpan(
                                    text: "Today 15:24 AM",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey.shade800,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                          //  height: defaultMargin,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              buildMessage(),
                              SizedBox(
                              //  width: defaultMargin,
                              ),
                              _buildSwayamwar(),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Expanded buildMessage() {
    return Expanded(
      child: Container(
        child: Text(
          "hi i am very impressed by your profile",
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  Container _buildSwayamwar() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: CircleAvatar(
              backgroundColor: Colors.grey.shade800,

            )
          ),
        ],
      ),
    );
  }

  Container _buildCall() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child:CircleAvatar(
              backgroundColor: Colors.grey.shade800,

            )
          ),
          SizedBox(
            //height: defaultMargin / 4,
          ),
          Container(
            child: Text(
              "Call",
              style: TextStyle(fontSize: 12, color: Colors.grey.shade800),
            ),
          )
        ],
      ),
    );
  }

  // Widget _buildMessage() {
  //   return GestureDetector(
  //     onTap: () {
  //       Navigator.push(context, MaterialPageRoute(builder: (ctx) {
  //         return MessageChat();
  //       }));
  //     },
  //     child: Container(
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           Container(
  //             child: SvgPicture.asset(
  //               'assets/icons/dash/M2.6.7_MessageWrite.svg',
  //               height: 20,
  //             ),
  //           ),
  //           SizedBox(
  //             height: defaultMargin / 4,
  //           ),
  //           Container(
  //             child: Text(
  //               "Message",
  //               style: TextStyle(fontSize: 12, color: dark),
  //             ),
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Container _buildSkip() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Container(
          //   child: SvgPicture.asset(
          //     'assets/icons/dash/M2.1.0.1.1Skip.svg',
          //     height: 20,
          //   ),
          //),
          SizedBox(
           // height: defaultMargin / 4,
          ),
          Container(
            child: Text(
              "Skip",
              style: TextStyle(fontSize: 12, color: Colors.grey.shade800),
            ),
          )
        ],
      ),
    );
  }

  ProfileContent _buildProfileDetailsSection() {
    return ProfileContent();
  }

  Container _buildProfileSection(BoxConstraints viewportConstraints) {
    return Container(
      child: Column(
        children: [
          _buildRating(viewportConstraints.biggest),
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10 + 50),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10 + 50),
              child: Image.network(
                "https://media.istockphoto.com/id/1453715348/photo/nishikawa-gorge-a-beautiful-canyon-in-japan.jpg?s=1024x1024&w=is&k=20&c=yBEY7-oU4qJ8agdynFA69uhk4Cr_sOlyIZnRg0kkuyA=",
                fit: BoxFit.fill,
              ),
            ),
          )
        ],
      ),
    );
  }

  Container _buildRating(Size size) {
    return Container(
      width: size.width / 6,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            "3.5",
            style: TextStyle(
              color: Colors.grey.shade800,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          Icon(
            Icons.star,
            size: 12,
          )
        ],
      ),
    );
  }
}

class ProfileContent extends StatefulWidget {
  const ProfileContent({
     Key? key,
  }) : super(key: key);

  @override
  _ProfileContentState createState() => _ProfileContentState();
}

class _ProfileContentState extends State<ProfileContent> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Axxxxxxxx',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade800,
                        ),
                      ),
                      TextSpan(
                        text: '\nSuper Star',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade800,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: Text(
              '24, 5\'5\" ',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade800,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Text(
                  '5 Lakhs, CA ',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade800,
                  ),
                ),
              ),
              Container(
                child: Text(
                  'Faridabad,India',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade800,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
            width: 10,
            child: Icon(
              Icons.arrow_drop_down_outlined,
              size: 24,
              color: Colors.grey.shade800,
            ),
          ),
        ],
      ),
    );
  }
}
