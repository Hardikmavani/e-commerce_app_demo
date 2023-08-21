import 'package:flutter/material.dart';
import 'package:h_firebase_demo/provider/app_provider.dart';
import 'package:h_firebase_demo/screens/favourite_screen/widgets/single_favourite_item.dart';
import 'package:provider/provider.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Favourite Screen',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: appProvider.getFavouriteProductList.isEmpty
          ? const Center(child: Text('Empty'))
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: appProvider.getFavouriteProductList.length,
              itemBuilder: (context, index) {
                return SingleFavouriteItem(
                    singleProduct: appProvider.getFavouriteProductList[index]);
              },
            ),
    );
  }
}
