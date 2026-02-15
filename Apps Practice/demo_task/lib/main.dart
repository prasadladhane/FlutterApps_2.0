import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dashboard UI',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Color(0xFFF6F8FB),
      ),
      home: DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  final List<CardModel> cards = [
    CardModel(
      bgColor: Color(0xFF2CA6BB),
      buttonColor: Color(0xFFE56C3C),
      title: 'Orders',
      badgeTitle: 'You have 3 active\norders from',
      smallBadgeTitle: '02\nPending\nOrders from',
    ),
    CardModel(
      bgColor: Color(0xFFE0B21E),
      buttonColor: Color(0xFF2648F5),
      title: 'Subscriptions',
      badgeTitle: '03 deliveries',
      smallBadgeTitle: '10\nActive\nSubscriptions',
    ),
    CardModel(
      bgColor: Color(0xFF24C48B),
      buttonColor: Color(0xFFE44C7A),
      title: 'View Customers',
      badgeTitle: '15 New customers',
      smallBadgeTitle: '10\nActive\nCustomers',
    ),
  ];

   DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTopRow(),
                  SizedBox(height: 14),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Welcome, Mypcot !!\n',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF2B3B5A)),
                        ),
                        TextSpan(
                          text: 'here is your dashboard....',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey[500]),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 18),

                  // horizontal scroll cards
                  SizedBox(
                    height: 210,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: cards.length,
                      separatorBuilder: (_, __) => SizedBox(width: 14),
                      itemBuilder: (context, index) {
                        final card = cards[index];
                        return DashboardCard(model: card);
                      },
                    ),
                  ),

                  SizedBox(height: 22),

                  // Date row
                  Text(
                    'January, 23 2021',
                    style: TextStyle(color: Colors.grey[500], fontSize: 12),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Today',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF2B3B5A)),
                  ),
                  SizedBox(height: 10),

                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 2))],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text('TIMELINE', style: TextStyle(fontWeight: FontWeight.w600)),
                                  SizedBox(width: 8),
                                  Icon(Icons.keyboard_arrow_down, size: 20),
                                ],
                              ),
                              Row(children: [
                                Icon(Icons.calendar_today, size: 18, color: Colors.grey[600]),
                                SizedBox(width: 6),
                                Text('JAN, 2021', style: TextStyle(fontWeight: FontWeight.w600)),
                              ])
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 12),

                  // days list
                  SizedBox(
                    height: 62,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: List.generate(7, (i) {
                        final days = ['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN'];
                        final dates = ['20', '21', '22', '23', '24', '25', '26'];
                        final isSelected = (i == 3); // THU selected
                        return Container(
                          width: 56,
                          margin: EdgeInsets.only(right: 8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(days[i], style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.w600)),
                              SizedBox(height: 6),
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                                decoration: BoxDecoration(
                                  color: isSelected ? Color(0xFF0EBC8B) : Colors.transparent,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(dates[i], style: TextStyle(color: isSelected ? Colors.white : Colors.black87, fontWeight: FontWeight.bold)),
                              )
                            ],
                          ),
                        );
                      }),
                    ),
                  ),

                  SizedBox(height: 18),

                  // Event card
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 12, offset: Offset(0, 6))],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('New order created', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                              SizedBox(height: 6),
                              Text('New Order created with Order', style: TextStyle(color: Colors.grey[600])),
                              SizedBox(height: 12),
                              Row(
                                children: [
                                  Text('09:00 AM', style: TextStyle(color: Color(0xFFE56C3C), fontWeight: FontWeight.bold)),
                                  SizedBox(width: 10),
                                  Icon(Icons.arrow_forward, size: 18, color: Colors.orangeAccent),
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(width: 12),
                        Container(
                          height: 56,
                          width: 56,
                          decoration: BoxDecoration(
                            color: Color(0xFFFFECE0),
                            shape: BoxShape.circle,
                          ),
                          child: Center(child: Icon(Icons.assignment, color: Color(0xFFE56C3C))),
                        )
                      ],
                    ),
                  ),

                  SizedBox(height: 80),
                ],
              ),
            ),

            // Search big floating circle on right top
            Positioned(
              right: 22,
              top: 110,
              child: Material(
                elevation: 8,
                shape: CircleBorder(),
                child: Container(
                  height: 62,
                  width: 62,
                  decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                  child: Icon(Icons.search, size: 30, color: Color(0xFF3B4A67)),
                ),
              ),
            ),
          ],
        ),
      ),

      // bottom navigation with centered FAB
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF243554),
        child: Icon(Icons.add, size: 30),
        onPressed: () {},
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 8,
        elevation: 12,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  _buildNavItem(icon: Icons.home_filled, label: 'Home'),
                  SizedBox(width: 18),
                  _buildNavItem(icon: Icons.people_alt, label: 'Customers'),
                ],
              ),
              Row(
                children: [
                  _buildNavItem(icon: Icons.menu_book, label: 'Khata'),
                  SizedBox(width: 18),
                  _buildNavItem(icon: Icons.list_alt, label: 'Orders'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(children: [
          _circleIcon(Icon(Icons.menu, color: Color(0xFF243554))),
          SizedBox(width: 8),
        ]),
        Row(children: [
          _circleIcon(Icon(Icons.location_on_outlined, color: Color(0xFF243554))),
          SizedBox(width: 8),
          Stack(
            children: [
              _circleIcon(Icon(Icons.notifications_none, color: Color(0xFF243554))),
              Positioned(
                right: 4,
                top: 4,
                child: Container(
                  height: 18,
                  width: 18,
                  decoration: BoxDecoration(color: Color(0xFFE56C3C), shape: BoxShape.circle),
                  child: Center(child: Text('2', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold))),
                ),
              )
            ],
          ),
          SizedBox(width: 8),
          CircleAvatar(radius: 18, backgroundColor: Colors.grey[300], child: Icon(Icons.person)),
        ])
      ],
    );
  }

  Widget _circleIcon(Widget child) {
    return Material(
      elevation: 4,
      shape: CircleBorder(),
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
        child: Center(child: child),
      ),
    );
  }

  Widget _buildNavItem({required IconData icon, required String label}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Color(0xFF2B3B5A)),
        SizedBox(height: 4),
        Text(label, style: TextStyle(fontSize: 11, color: Color(0xFF2B3B5A))),
      ],
    );
  }
}

class DashboardCard extends StatelessWidget {
  final CardModel model;

  const DashboardCard({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 56,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: model.bgColor,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              children: [
                // big circle illustration
                Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(color: Colors.white.withOpacity(0.12), shape: BoxShape.circle),
                  child: Center(child: Icon(Icons.insert_drive_file, size: 56, color: Colors.white70)),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 18),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: model.buttonColor,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10),
                          child: Text(model.title, style: TextStyle(color: Colors.white)),
                        ),
                      ),
                      SizedBox(height: 12),
                      // small white boxes
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _whiteSmallBox(model.smallBadgeTitle),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),

          // top-right rounded badge
          Positioned(
            right: -6,
            top: -18,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
              child: Column(
                children: [
                  Text(model.badgeTitle, style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),

          // avatars near badge (simulating overlapping)
          Positioned(
            right: 28,
            top: 2,
            child: Row(
              children: [
                _avatarMini(),
                SizedBox(width: 6),
                _avatarMini(),
                SizedBox(width: 6),
                _avatarMini(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _avatarMini() => CircleAvatar(radius: 14, backgroundColor: Colors.white, child: Icon(Icons.person, size: 14, color: Colors.grey));

  Widget _whiteSmallBox(String text) {
    return Container(
      margin: EdgeInsets.only(top: 6),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Text(text, style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w700)),
    );
  }
}

class CardModel {
  final Color bgColor;
  final Color buttonColor;
  final String title;
  final String badgeTitle;
  final String smallBadgeTitle;

  CardModel({required this.bgColor, required this.buttonColor, required this.title, required this.badgeTitle, required this.smallBadgeTitle});
}
