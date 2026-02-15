import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override

  State createState()=>_MyAppState();
}

class _MyAppState extends State{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQNWBCY0mLUJlEWqBCzmoYXcJEoqYBAyUYzgg&s"),
          actions: [
            const Icon(Icons.notifications_none_outlined),
            const SizedBox(width: 5,),
            Image.network("https://media.licdn.com/dms/image/v2/C560BAQH7Vl5ot85nSA/company-logo_200_200/company-logo_200_200/0/1633669069792/core2web_technologies_logo?e=2147483647&v=beta&t=DQeLvVfWsmpgSiF9cV1kMucS-9PDRYDSctSpag2krjQ",
            height: 30,
            ),
          ],
        ),
        body: 
        ListView(
          //scrollDirection: Axis.vertical,
          shrinkWrap: true,
          children: [
            Column(
                children: [
                  const Row(
                    children: [
                      SizedBox(width: 20,),
                      Text("For you"),
                      SizedBox(width: 20,),
                      Text("Top charts"),
                      SizedBox(width: 20,),
                      Text("Kids"),
                      SizedBox(width: 20,),
                      Text("Premium"),
                      SizedBox(width: 20,),
                      Text("Categories"),
                    ],
                  ),
                  const SizedBox(height: 20,),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        const SizedBox(width: 10,),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: 
                          SizedBox(
                            height: 300,
                            width: 300,
                            //color: Colors.red,
                            child:Image.asset("assets/images/game3.webp"),
                        ),
                      ),
                      const SizedBox(width: 10,),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: 
                        SizedBox(
                          height: 300,
                          width: 300,
                          //color: Colors.purple,
                          child:Image.asset("assets/images/game2.webp"),
                        ),
                      ),
                    ],
                  ),
                 ),
                const SizedBox(height: 20,),
                const Row(
                  children: [
                    SizedBox(width: 10,),
                    Text("Sponsored",style: TextStyle(fontSize: 12),),
                    SizedBox(width: 10,),
                    Text("Suggested for You",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                    SizedBox(width: 80,),
                    Icon(Icons.more_vert)
                  ],
                ),
                const SizedBox(height: 20,),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      const SizedBox(width: 10,),
                      SizedBox(
                        width: 300,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  height: 60,
                                  width: 60,
                                  child:Image.network("https://img.tapimg.net/market/lcs/f4549c8811eca01a8cbb1c2dbd44feb9_360_v2.png")
                                ),
                                const SizedBox(width: 10,),
                                const Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Battlegrounds Mobile India"),
                                    Row(
                                      children: [
                                        Text("Action",style: TextStyle(fontSize: 10),),
                                        SizedBox(width:5),
                                        Text("Tactical shooter",style: TextStyle(fontSize: 10),),
                                        SizedBox(width:5),
                                        Text("Competitive",style: TextStyle(fontSize: 10),)
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text("4.1",style: TextStyle(fontSize: 10),),
                                        Icon(Icons.star,size: 10,),
                                        SizedBox(width: 5,),
                                        Text("1.2 GB",style: TextStyle(fontSize: 10),),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(height: 20,),
                            Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    height: 60,
                                    width: 60,
                                    color: Colors.black,
                                    child:Image.network("https://media.istockphoto.com/id/1305165458/vector/racing-sports-glyph-icon.jpg?s=612x612&w=0&k=20&c=Sl5309tmTPOrIbDb2Wm_dPdd0kTOaFRx8IJ0NwdpDhU=")
                                  ),
                                ),
                                const SizedBox(width: 10,),
                                const Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Car racing"),
                                    Row(
                                      children: [
                                        Text("Adventure",style: TextStyle(fontSize: 10),),
                                        SizedBox(width:5),
                                        Text("Casual",style: TextStyle(fontSize: 10),),
                                        SizedBox(width:5),
                                        Text("Racing",style: TextStyle(fontSize: 10),)
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text("3.1",style: TextStyle(fontSize: 10),),
                                        Icon(Icons.star,size: 10,),
                                        SizedBox(width: 5,),
                                        Text("12 MB",style: TextStyle(fontSize: 10),),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(height: 20,),
                            Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: SizedBox(
                                    height: 60,
                                    width: 60,
                                    child:Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSRWIazm2xn5J-IH5ib7TVV3qJ3WljJVH3pfA&s")
                                  ),
                                ),
                                const SizedBox(width: 10,),
                                const Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Candy Crush Saga"),
                                    Row(
                                      children: [
                                        Text("Puzzle",style: TextStyle(fontSize: 10),),
                                        SizedBox(width:5),
                                        Text("Casual",style: TextStyle(fontSize: 10),),
                                        SizedBox(width:5),
                                        Text("Offline",style: TextStyle(fontSize: 10),)
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text("4.0",style: TextStyle(fontSize: 10),),
                                        Icon(Icons.star,size: 10,),
                                        SizedBox(width: 5,),
                                        Text("100 MB",style: TextStyle(fontSize: 10),),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 40,),
                       Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                height: 60,
                                width: 60,
                                child:Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSGl0fgybnTXsLmirQGTEZ_ufTVii68-PUtTQ&s")
                              ),
                              const SizedBox(width: 10,),
                                const Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("WCC 2"),
                                    Row(
                                      children: [
                                        Text("Sports",style: TextStyle(fontSize: 10),),
                                        SizedBox(width:5),
                                        Text("Nextwave",style: TextStyle(fontSize: 10),),
                                        SizedBox(width:5),
                                        Text("Competitive",style: TextStyle(fontSize: 10),)
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text("4.8",style: TextStyle(fontSize: 10),),
                                        Icon(Icons.star,size: 10,),
                                        SizedBox(width: 5,),
                                        Text("600 MB",style: TextStyle(fontSize: 10),),
                                      ],
                                    ),
                                  ],
                                )
                            ],
                          ),
                          const SizedBox(height: 20,),
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  height: 60,
                                  width: 60,
                                  color: Colors.black,
                                  child:Image.network("https://cdn.jim-nielsen.com/ios/512/temple-run-2-2021-07-20.png?rf=1024")
                                ),
                              ),
                              const SizedBox(width: 10,),
                                const Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Temple Run"),
                                    Row(
                                      children: [
                                        Text("Fantacy",style: TextStyle(fontSize: 10),),
                                        SizedBox(width:5),
                                        Text("Running",style: TextStyle(fontSize: 10),),
                                        SizedBox(width:5),
                                        Text("Entertainment",style: TextStyle(fontSize: 10),)
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text("4.0",style: TextStyle(fontSize: 10),),
                                        Icon(Icons.star,size: 10,),
                                        SizedBox(width: 5,),
                                        Text("52 MB",style: TextStyle(fontSize: 10),),
                                      ],
                                    ),
                                  ],
                                )
                            ],
                          ),
                          const SizedBox(height: 20,),
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: SizedBox(
                                  height: 60,
                                  width: 60,
                                  child:Image.network("https://5.imimg.com/data5/SELLER/Default/2023/12/367842474/GD/ET/SR/193798871/ludo-king-roomcode-api-500x500.png")
                                ),
                              ),
                              const SizedBox(width: 10,),
                                const Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Ludo King"),
                                    Row(
                                      children: [
                                        Text("Board game",style: TextStyle(fontSize: 10),),
                                        SizedBox(width:5),
                                        Text("Strategy",style: TextStyle(fontSize: 10),),
                                        SizedBox(width:5),
                                        Text("Casual",style: TextStyle(fontSize: 10),)
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text("4.1",style: TextStyle(fontSize: 10),),
                                        Icon(Icons.star,size: 10,),
                                        SizedBox(width: 5,),
                                        Text("79 MB",style: TextStyle(fontSize: 10),),
                                      ],
                                    ),
                                  ],
                                )
                            ],
                          ),
                        ],
                      ),
                       const SizedBox(width: 40,),
                       Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                height: 60,
                                width: 60,
                                child:Image.network("https://img.tapimg.net/market/images/f344f29c571cd98a0cb69c68a5f0d8f5.png/appicon_m")
                              ),
                              const SizedBox(width: 10,),
                                const Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Bullet Echo"),
                                    Row(
                                      children: [
                                        Text("Action",style: TextStyle(fontSize: 10),),
                                        SizedBox(width:5),
                                        Text("Tactical Shooter",style: TextStyle(fontSize: 10),),
                                        SizedBox(width:5),
                                        Text("Casual",style: TextStyle(fontSize: 10),)
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text("4.8",style: TextStyle(fontSize: 10),),
                                        Icon(Icons.star,size: 10,),
                                        SizedBox(width: 5,),
                                        Text("181 MB",style: TextStyle(fontSize: 10),),
                                      ],
                                    ),
                                  ],
                                )
                            ],
                          ),
                          const SizedBox(height: 20,),
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  height: 60,
                                  width: 60,
                                  color: Colors.black,
                                  child:Image.network("https://img.tapimg.net/market/images/7898d7cdebdcea3737ecc823eb246e8a.jpg/appicon")
                                ),
                              ),
                              const SizedBox(width: 10,),
                                const Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Chess Master"),
                                    Row(
                                      children: [
                                        Text("Board game",style: TextStyle(fontSize: 10),),
                                        SizedBox(width:5),
                                        Text("Strategy",style: TextStyle(fontSize: 10),),
                                        SizedBox(width:5),
                                        Text("Casual",style: TextStyle(fontSize: 10),)
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text("4.7",style: TextStyle(fontSize: 10),),
                                        Icon(Icons.star,size: 10,),
                                        SizedBox(width: 5,),
                                        Text("41 MB",style: TextStyle(fontSize: 10),),
                                      ],
                                    ),
                                  ],
                                )
                            ],
                          ),
                          const SizedBox(height: 20,),
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: SizedBox(
                                  height: 60,
                                  width: 60,
                                  child:Image.network("https://img.tapimg.net/market/images/a6446faec16e449b0aad65e069ba9dec.png/appicon")
                                ),
                              ),
                              const SizedBox(width: 10,),
                                const Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Clash of Clans"),
                                    Row(
                                      children: [
                                        Text("Strategy",style: TextStyle(fontSize: 10),),
                                        SizedBox(width:5),
                                        Text("Build & Battle",style: TextStyle(fontSize: 10),),
                                        SizedBox(width:5),
                                        Text("Casual",style: TextStyle(fontSize: 10),)
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text("4.5",style: TextStyle(fontSize: 10),),
                                        Icon(Icons.star,size: 10,),
                                        SizedBox(width: 5,),
                                        Text("289 MB",style: TextStyle(fontSize: 10),),
                                      ],
                                    ),
                                  ],
                                )
                            ],
                          ),
                        ],
                      ),
                       const SizedBox(width: 40,),
                       Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                height: 60,
                                width: 60,
                                child:Image.network("https://img.tapimg.net/market/images/b31aece5fb7bc579c37e97cd045f2907.png/appicon_m")
                              ),
                              const SizedBox(width: 10,),
                                const Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Real Cricket 24"),
                                    Row(
                                      children: [
                                        Text("Sports",style: TextStyle(fontSize: 10),),
                                        SizedBox(width:5),
                                        Text("Cricket",style: TextStyle(fontSize: 10),),
                                        SizedBox(width:5),
                                        Text("Casual",style: TextStyle(fontSize: 10),)
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text("4.2",style: TextStyle(fontSize: 10),),
                                        Icon(Icons.star,size: 10,),
                                        SizedBox(width: 5,),
                                        Text("605 MB",style: TextStyle(fontSize: 10),),
                                      ],
                                    ),
                                  ],
                                )
                            ],
                          ),
                          const SizedBox(height: 20,),
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  height: 60,
                                  width: 60,
                                  color: Colors.black,
                                  child:Image.network("https://img.tapimg.net/market/images/18c89a944fd74434209d04d2ad175d83.png/appicon")
                                ),
                              ),
                              const SizedBox(width: 10,),
                                const Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Dream Cricket"),
                                    Row(
                                      children: [
                                        Text("Sports",style: TextStyle(fontSize: 10),),
                                        SizedBox(width:5),
                                        Text("Cricket",style: TextStyle(fontSize: 10),),
                                        SizedBox(width:5),
                                        Text("Casual",style: TextStyle(fontSize: 10),)
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text("4.4",style: TextStyle(fontSize: 10),),
                                        Icon(Icons.star,size: 10,),
                                        SizedBox(width: 5,),
                                        Text("710 MB",style: TextStyle(fontSize: 10),),
                                      ],
                                    ),
                                  ],
                                )
                            ],
                          ),
                          const SizedBox(height: 20,),
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: SizedBox(
                                  height: 60,
                                  width: 60,
                                  child:Image.network("https://img.tapimg.net/market/images/b556767374e01ffd92a21d88ea29773c.png")
                                ),
                              ),
                              const SizedBox(width: 10,),
                                const Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Subway Runner"),
                                    Row(
                                      children: [
                                        Text("Action",style: TextStyle(fontSize: 10),),
                                        SizedBox(width:5),
                                        Text("Runner",style: TextStyle(fontSize: 10),),
                                        SizedBox(width:5),
                                        Text("Offline",style: TextStyle(fontSize: 10),)
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text("4.0",style: TextStyle(fontSize: 10),),
                                        Icon(Icons.star,size: 10,),
                                        SizedBox(width: 5,),
                                        Text("109 MB",style: TextStyle(fontSize: 10),),
                                      ],
                                    ),
                                  ],
                                )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20,),
                const Row(
                  children: [
                    SizedBox(width: 10,),
                    Text("Based on your recent Activity",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                    SizedBox(width: 80,),
                    Icon(Icons.arrow_forward)
                  ],
                ),
                 const SizedBox(height: 20,),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      const SizedBox(width: 10,),
                      SizedBox(
                        width: 300,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  height: 60,
                                  width: 60,
                                  child:Image.network("https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/39864f6d-f4d2-4a56-adc2-da80c2274026/dg0obe6-9f4e5490-5f34-4a06-a7c8-1b6b9bb9b992.png/v1/fill/w_894,h_894/stardew_valley___icon_by_jfs0393_dg0obe6-pre.png?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7ImhlaWdodCI6Ijw9MTI4MCIsInBhdGgiOiJcL2ZcLzM5ODY0ZjZkLWY0ZDItNGE1Ni1hZGMyLWRhODBjMjI3NDAyNlwvZGcwb2JlNi05ZjRlNTQ5MC01ZjM0LTRhMDYtYTdjOC0xYjZiOWJiOWI5OTIucG5nIiwid2lkdGgiOiI8PTEyODAifV1dLCJhdWQiOlsidXJuOnNlcnZpY2U6aW1hZ2Uub3BlcmF0aW9ucyJdfQ.vsJoquRC1_1azlh2whUShe_6j87n0NlXeoG3Q2g84jA")
                                ),
                                const SizedBox(width: 10,),
                                const Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Stardew Valley"),
                                    Row(
                                      children: [
                                        Text("Build a Farm,\nraise a family\nexplore countryside",style: TextStyle(fontSize: 10),),
                                        //SizedBox(width:5),
                                        //Text("",style: TextStyle(fontSize: 10),),
                                        //SizedBox(width:5),
                                        //Text("Competitive",style: TextStyle(fontSize: 10),)
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text("4.7",style: TextStyle(fontSize: 10),),
                                        Icon(Icons.star,size: 10,),
                                        SizedBox(width: 5,),
                                        Text("245 MB",style: TextStyle(fontSize: 10),),
                                        SizedBox(width: 5,),
                                        //Text("${590.00}",style: TextStyle(fontSize: 10),),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(height: 20,),
                            Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    height: 60,
                                    width: 60,
                                    color: Colors.black,
                                    child:Image.network("https://img.tapimg.net/market/images/809b9798cd2a2b5470cc0345de03e64f.png/appicon")
                                  ),
                                ),
                                const SizedBox(width: 10,),
                                const Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Dead Cells"),
                                    Row(
                                      children: [
                                        Text("Adventure",style: TextStyle(fontSize: 10),),
                                        SizedBox(width:5),
                                        //Text("Casual",style: TextStyle(fontSize: 10),),
                                        SizedBox(width:5),
                                        Text("In App Purchase",style: TextStyle(fontSize: 10),)
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text("4.7",style: TextStyle(fontSize: 10),),
                                        Icon(Icons.star,size: 10,),
                                        SizedBox(width: 5,),
                                        Text("361 MB",style: TextStyle(fontSize: 10),),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(height: 20,),
                            Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: SizedBox(
                                    height: 60,
                                    width: 60,
                                    child:Image.network("https://img.tapimg.net/market/images/edfd14ed62d924b86f2e1ff976b2be5d.png/appicon")
                                  ),
                                ),
                                const SizedBox(width: 10,),
                                const Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Mini Metro"),
                                    Row(
                                      children: [
                                        Text("Design",style: TextStyle(fontSize: 10),),
                                        SizedBox(width:5),
                                       // Text("Casual",style: TextStyle(fontSize: 10),),
                                        SizedBox(width:5),
                                        Text("In App Purchase",style: TextStyle(fontSize: 10),)
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text("4.0",style: TextStyle(fontSize: 10),),
                                        Icon(Icons.star,size: 10,),
                                        SizedBox(width: 5,),
                                        Text("158 MB",style: TextStyle(fontSize: 10),),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 40,),
                       Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                height: 60,
                                width: 60,
                                child:Image.network("https://img.tapimg.net/market/images/f7e535e4b577914dd0cb3ef3b0574a40.png/appicon")
                              ),
                              const SizedBox(width: 10,),
                                const Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Machinarium"),
                                    Row(
                                      children: [
                                        Text("War Game",style: TextStyle(fontSize: 10),),
                                        SizedBox(width:5),
                                        Text("Action",style: TextStyle(fontSize: 10),),
                                        SizedBox(width:5),
                                        Text("Adventure",style: TextStyle(fontSize: 10),)
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text("4.8",style: TextStyle(fontSize: 10),),
                                        Icon(Icons.star,size: 10,),
                                        SizedBox(width: 5,),
                                        Text("241 MB",style: TextStyle(fontSize: 10),),
                                      ],
                                    ),
                                  ],
                                )
                            ],
                          ),
                          const SizedBox(height: 20,),
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  height: 60,
                                  width: 60,
                                  color: Colors.black,
                                  child:Image.network("https://img.tapimg.net/market/images/ebfa90586ee81a7e0ab59369b11c066f.jpg/appicon")
                                ),
                              ),
                              const SizedBox(width: 10,),
                                const Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Slay the Spire"),
                                    Row(
                                      children: [
                                        Text("Fantacy",style: TextStyle(fontSize: 10),),
                                        SizedBox(width:5),
                                        Text("Adventure",style: TextStyle(fontSize: 10),),
                                        SizedBox(width:5),
                                        Text("Action    ",style: TextStyle(fontSize: 10),)
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text("4.5",style: TextStyle(fontSize: 10),),
                                        Icon(Icons.star,size: 10,),
                                        SizedBox(width: 5,),
                                        Text("308 MB",style: TextStyle(fontSize: 10),),
                                      ],
                                    ),
                                  ],
                                )
                            ],
                          ),
                          const SizedBox(height: 20,),
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: SizedBox(
                                  height: 60,
                                  width: 60,
                                  child:Image.network("https://img.tapimg.net/market/images/68e30c5db69d716f257a98a5c2b7c03d.png/appicon_m")
                                ),
                              ),
                              const SizedBox(width: 10,),
                                const Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Vector"),
                                    Row(
                                      children: [
                                        Text("Explore dozens of levels  \n  Contains Ads",style: TextStyle(fontSize: 10),),
                                        SizedBox(width:5),
                                        //Text("Strategy",style: TextStyle(fontSize: 10),),
                                        SizedBox(width:5),
                                        //Text("Casual",style: TextStyle(fontSize: 10),)
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text("4.1",style: TextStyle(fontSize: 10),),
                                        Icon(Icons.star,size: 10,),
                                        SizedBox(width: 5,),
                                        Text("157 MB",style: TextStyle(fontSize: 10),),
                                      ],
                                    ),
                                  ],
                                )
                            ],
                          ),
                        ],
                      ),
                       const SizedBox(width: 40,),
                       Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                height: 60,
                                width: 60,
                                child:Image.network("https://img.tapimg.net/market/images/6511b32cd3e54ddc2d7a3a2455f36794.jpg")
                              ),
                              const SizedBox(width: 10,),
                                const Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Cytus II"),
                                    Row(
                                      children: [
                                        Text("Music  ",style: TextStyle(fontSize: 10),),
                                        SizedBox(width:5),
                                        Text("Gameplay ",style: TextStyle(fontSize: 10),),
                                        SizedBox(width:5),
                                        Text("Casual    ",style: TextStyle(fontSize: 10),)
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text("4.2",style: TextStyle(fontSize: 10),),
                                        Icon(Icons.star,size: 10,),
                                        SizedBox(width: 5,),
                                        Text("3.1 GB",style: TextStyle(fontSize: 10),),
                                      ],
                                    ),
                                  ],
                                )
                            ],
                          ),
                          const SizedBox(height: 20,),
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  height: 60,
                                  width: 60,
                                  color: Colors.black,
                                  child:Image.network("https://img.tapimg.net/market/images/d52e4b8fe3f0a769d9fffecdf82d98ac.png/appicon_m")
                                ),
                              ),
                              const SizedBox(width: 10,),
                                const Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Kingdom Rush"),
                                    Row(
                                      children: [
                                        Text("Fantacy",style: TextStyle(fontSize: 10),),
                                        SizedBox(width:5),
                                        Text("Running",style: TextStyle(fontSize: 10),),
                                        SizedBox(width:5),
                                        Text("Entertainment",style: TextStyle(fontSize: 10),)
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text("4.0",style: TextStyle(fontSize: 10),),
                                        Icon(Icons.star,size: 10,),
                                        SizedBox(width: 5,),
                                        Text("52 MB",style: TextStyle(fontSize: 10),),
                                      ],
                                    ),
                                  ],
                                )
                            ],
                          ),
                          const SizedBox(height: 20,),
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: SizedBox(
                                  height: 60,
                                  width: 60,
                                  child:Image.network("https://img.tapimg.net/market/images/45b5462abc14c6fb18515b4afc7446f2.jpg/appicon_m")
                                ),
                              ),
                              const SizedBox(width: 10,),
                                const Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Among Us"),
                                    Row(
                                      children: [
                                        Text("Board game",style: TextStyle(fontSize: 10),),
                                        SizedBox(width:5),
                                        Text("Strategy",style: TextStyle(fontSize: 10),),
                                        SizedBox(width:5),
                                        Text("Casual",style: TextStyle(fontSize: 10),)
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text("4.1",style: TextStyle(fontSize: 10),),
                                        Icon(Icons.star,size: 10,),
                                        SizedBox(width: 5,),
                                        Text("799 MB",style: TextStyle(fontSize: 10),),
                                      ],
                                    ),
                                  ],
                                )
                            ],
                          ),
                        ],
                      ),
                       const SizedBox(width: 40,),
                       Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                height: 60,
                                width: 60,
                                child:Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQXeUBTC3lYL-12irlnL9cJhtn1VgCb7ANVwQ&s")
                              ),
                              const SizedBox(width: 10,),
                                const Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Brain It"),
                                    Row(
                                      children: [
                                        Text("Board Game",style: TextStyle(fontSize: 10),),
                                        SizedBox(width:5),
                                        Text("Strategy ",style: TextStyle(fontSize: 10),),
                                        SizedBox(width:5),
                                        Text("Casual  ",style: TextStyle(fontSize: 10),)
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text("4.8",style: TextStyle(fontSize: 10),),
                                        Icon(Icons.star,size: 10,),
                                        SizedBox(width: 5,),
                                        Text("58 MB",style: TextStyle(fontSize: 10),),
                                      ],
                                    ),
                                  ],
                                )
                            ],
                          ),
                          const SizedBox(height: 20,),
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  height: 60,
                                  width: 60,
                                  color: Colors.black,
                                  child:Image.network("https://img.tapimg.net/market/lcs/a2c02a06df1657bb4d97ee132b50268d_360_v2.png?imageMogr2/thumbnail/1080x9999%3E/quality/80/format/jpg/interlace/1/ignore-error/1")
                                ),
                              ),
                              const SizedBox(width: 10,),
                                const Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Hitman Sniper"),
                                    Row(
                                      children: [
                                        Text("Action",style: TextStyle(fontSize: 10),),
                                        SizedBox(width:5),
                                        Text("Adventure",style: TextStyle(fontSize: 10),),
                                        SizedBox(width:5),
                                        Text("War Game",style: TextStyle(fontSize: 10),)
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text("4.0",style: TextStyle(fontSize: 10),),
                                        Icon(Icons.star,size: 10,),
                                        SizedBox(width: 5,),
                                        Text("204 MB",style: TextStyle(fontSize: 10),),
                                      ],
                                    ),
                                  ],
                                )
                            ],
                          ),
                          const SizedBox(height: 20,),
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: SizedBox(
                                  height: 60,
                                  width: 60,
                                  child:Image.network("https://img.tapimg.net/market/images/785e9291d95faf8fcf7a22dd17b3ae1a.png/appicon")
                                ),
                              ),
                              const SizedBox(width: 10,),
                                const Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Angry Birds"),
                                    Row(
                                      children: [
                                        Text("Board game",style: TextStyle(fontSize: 10),),
                                        SizedBox(width:5),
                                        Text("Strategy",style: TextStyle(fontSize: 10),),
                                        SizedBox(width:5),
                                        Text("Casual",style: TextStyle(fontSize: 10),)
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text("4.1",style: TextStyle(fontSize: 10),),
                                        Icon(Icons.star,size: 10,),
                                        SizedBox(width: 5,),
                                        Text("82 MB",style: TextStyle(fontSize: 10),),
                                      ],
                                    ),
                                  ],
                                )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),

      ),
    );
  }
}
