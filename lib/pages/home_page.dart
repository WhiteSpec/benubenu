import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Import the url_launcher package
import '../data.dart'; // Import the data file

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isNotificationVisible = true;
  TextEditingController _searchController = TextEditingController();
  List<LostItem> _filteredItems = lostItems; // Filtered list to display

  // Show full-screen dialog when a card is tapped
  void _showCardDetails(LostItem item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: EdgeInsets.all(10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(10.0), // Apply top corners radius
              bottom: Radius.circular(10.0), // Apply bottom corners radius
            ),
          ),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.67,
            child: Column(
              children: [
                // Image takes up 2/5 of the space, and fills the width
                Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    image: DecorationImage(
                      image: AssetImage('assets/barang_hilang.jpg'), // Your custom image
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Profile with username and claim button takes up 1/5
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: AssetImage('assets/pp_admin.jpg'), // Profile image
                            radius: 20,
                          ),
                          SizedBox(width: 10),
                          Text('Username', style: TextStyle(fontSize: 18)),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // WhatsApp URL scheme to send a message
                          String phoneNumber = "083836100924"; // Replace with the phone number you want to contact
                          String message = "Hello, I would like to claim the item: ${item.title}";
                          String url = "https://wa.me/$phoneNumber?text=$message";

                          _launchURL(url);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF006769), // Button color
                          foregroundColor: Colors.white, // Set text color to white
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text('Claim'),
                      ),
                    ],
                  ),
                ),
                // Description section takes up 2/5 of the space
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: SingleChildScrollView(
                      child: Align(
                        alignment: Alignment.topLeft,  // Align the text to the left
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0, right: 10.0),  // Add padding for better alignment
                          child: Text(
                            item.description, // Display item description
                            style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Function to launch URL (WhatsApp)
  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  // Function to filter the items based on the search query (only by title)
  void _filterItems() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      _filteredItems = lostItems.where((item) {
        return item.title.toLowerCase().contains(query); // Only filter by title
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFF006769),
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('assets/pp_admin.jpg'), // Replace with your image asset
              radius: 20,
            ),
            SizedBox(width: 10),
            Text(
              'Hi, User',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white, // Set text color to white
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            // Search bar section
            Container(
              margin: EdgeInsets.only(bottom: 10),
              padding: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        prefixIcon: Icon(Icons.search),
                        border: InputBorder.none,
                      ),
                      onChanged: (value) {
                        _filterItems(); // Filter items as the user types
                      },
                    ),
                  ),
                ],
              ),
            ),
            // Notification box section
            AnimatedOpacity(
              opacity: _isNotificationVisible ? 1.0 : 0.0,
              duration: Duration(milliseconds: 10000),
              onEnd: _isNotificationVisible
                  ? null
                  : () {
                setState(() {
                  _isNotificationVisible = false;
                });
              },
              child: _isNotificationVisible
                  ? Container(
                margin: EdgeInsets.only(bottom: 10),
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Color(0xFF006769),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.notifications, color: Colors.white),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'Belum Nemu adalah aplikasi pencarian barang hilang yang memudahkan Anda untuk menemukan benda berharga yang hilang.',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _isNotificationVisible = false;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'OK',
                          style: TextStyle(
                            color: Color(0xFF006769),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
                  : SizedBox.shrink(),
            ),
            // Custom Card section with 2 cards per row
            Expanded(
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: GridView.builder(
                  itemCount: _filteredItems.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // 2 cards per row
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 150 / 185, // Adjust as needed
                  ),
                  itemBuilder: (context, index) {
                    final item = _filteredItems[index];
                    return GestureDetector(
                      onTap: () {
                        _showCardDetails(item); // Pass the tapped item to the popup
                      },
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Container(
                          width: 150,
                          height: 185,
                          padding: EdgeInsets.all(5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 110,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage('assets/barang_hilang.jpg'), // Your custom image here
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 0.0),
                                child: Text(
                                  item.title,
                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.ellipsis, // Add ellipsis for overflow
                                  maxLines: 1, // Limit title to 1 line
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  item.description,
                                  style: TextStyle(fontSize: 10, color: Colors.grey),
                                  overflow: TextOverflow.ellipsis, // Add ellipsis for overflow
                                  maxLines: 1, // Limit description to 1 line
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CircleAvatar(
                                        backgroundImage: AssetImage('assets/pp_admin.jpg'),
                                        radius: 14,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.location_on,
                                        color: Color(0xFF006769),
                                        size: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        child: BottomAppBar(
          color: Color(0xFF006769),
          shape: CircularNotchedRectangle(),
          notchMargin: 6.0,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildBottomNavButton(Icons.arrow_back),
                _buildBottomNavButton(Icons.home),
                _buildBottomNavButton(Icons.settings),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavButton(IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7.0),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: IconButton(
          icon: Icon(icon, color: Color(0xFF006769)),
          onPressed: () {},
        ),
      ),
    );
  }
}
