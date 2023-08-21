import 'package:flutter/material.dart';
import 'package:h_firebase_demo/constants/routes.dart';
import 'package:h_firebase_demo/firebase_helper/firebase_firestore/firebase_firestore.dart';
import 'package:h_firebase_demo/models/category_model/category_model.dart';
import 'package:h_firebase_demo/models/products_model/products_model.dart';
import 'package:h_firebase_demo/screens/products_detail/product_details.dart';

class CategoryView extends StatefulWidget {
  final CategoryModel categoryModel;
  const CategoryView({super.key, required this.categoryModel});

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  List<ProductModel> productModelList = [];

  bool isLoading = false;
  void getCategoryList() async {
    setState(() {
      isLoading = true;
    });
    productModelList = await FirebaseFirestoreHelper.instance
        .getCategoryViewProduct(widget.categoryModel.id);
    productModelList.shuffle();

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getCategoryList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: isLoading
            ? Center(
                child: Container(
                  height: 100,
                  width: 100,
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator(),
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: kToolbarHeight * 1),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const BackButton(),
                          Text(widget.categoryModel.name,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    productModelList.isEmpty
                        ? const Center(child: Text('Top selling is empty'))
                        : Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: GridView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              primary: false,
                              itemCount: productModelList.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      childAspectRatio: 0.7,
                                      mainAxisSpacing: 20,
                                      crossAxisSpacing: 20,
                                      crossAxisCount: 2),
                              itemBuilder: (context, index) {
                                ProductModel singleProduct =
                                    productModelList[index];
                                return Container(
                                  decoration: BoxDecoration(
                                      color: Colors.red.withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(8)),
                                  child: SingleChildScrollView(
                                    physics: const BouncingScrollPhysics(),
                                    child: Column(
                                      children: [
                                        const SizedBox(height: 12),
                                        Image.network(singleProduct.image,
                                            height: 100, width: 100),
                                        const SizedBox(height: 12),
                                        Text(
                                          singleProduct.name.toString(),
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text('Price \$${singleProduct.price}'),
                                        const SizedBox(height: 25),
                                        SizedBox(
                                          height: 45,
                                          width: 140,
                                          child: OutlinedButton(
                                              onPressed: () {
                                                Routes.instance.push(
                                                    widget: ProductDetails(
                                                        singleProduct:
                                                            singleProduct),
                                                    context: context);
                                              },
                                              child: const Text(
                                                'Buy',
                                              )),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                    const SizedBox(height: 12)
                  ],
                ),
              ));
  }
}
