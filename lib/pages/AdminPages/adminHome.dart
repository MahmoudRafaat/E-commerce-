import 'package:flutter/material.dart';
import 'package:untitled3/project2/pages/AdminPages/addProduct.dart';
import 'package:untitled3/project2/pages/AdminPages/delete_all_users_page.dart';
import 'package:untitled3/project2/pages/AdminPages/deleted_product.dart';
import 'package:untitled3/project2/pages/AdminPages/showOrders.dart';
import 'package:untitled3/project2/pages/AdminPages/showProducts.dart';
import 'package:untitled3/project2/pages/AdminPages/showUsers.dart';
import 'package:untitled3/project2/pages/AdminPages/updateProduct.dart';

class Adminhome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        foregroundColor: Colors.white,
        title: Text(
          "Admin Home",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(255, 247, 112, 71),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          children: [
            _buildGridButton(context, Icons.people, "Show Users", Showusers()),
            _buildGridButton(context, Icons.shopping_bag, "Show Products", Showproducts()),
            _buildGridButton(context, Icons.card_giftcard_rounded, "Show All Orders", Showorders()),

            _buildGridButton(context, Icons.add_box, "Add Product", Addproduct()),
            _buildGridButton(context, Icons.update, "Update Product", Updateproduct()),
            _buildGridButton(context, Icons.delete_forever, "Delete All Products", DeleteAllProducts()),
            _buildGridButton(context, Icons.delete_sweep, "Delete All Users", DeleteAllUsersPage()),
          ],
        ),
      ),
    );
  }

  Widget _buildGridButton(BuildContext context, IconData icon, String label, Widget page) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => page));
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50, color: Color.fromARGB(255, 247, 112, 71),
),
            SizedBox(height: 10),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
