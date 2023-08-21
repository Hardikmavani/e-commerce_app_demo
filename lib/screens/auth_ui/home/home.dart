import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:h_firebase_demo/constants/routes.dart';
import 'package:h_firebase_demo/firebase_helper/firebase_firestore/firebase_firestore.dart';
import 'package:h_firebase_demo/models/category_model/category_model.dart';
import 'package:h_firebase_demo/models/products_model/products_model.dart';
import 'package:h_firebase_demo/provider/app_provider.dart';
import 'package:h_firebase_demo/screens/category_view/category_view.dart';
import 'package:h_firebase_demo/screens/products_detail/product_details.dart';
import 'package:h_firebase_demo/widgets/top_title/top_title.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> catagoriesList = [];
  List<ProductModel> productModelList = [];

  bool isLoading = false;
  @override
  void initState() {
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
    appProvider.getUserInfoFirebase();

    getCategoryList();
    super.initState();
  }

  void getCategoryList() async {
    setState(() {
      isLoading = true;
    });

    FirebaseFirestoreHelper.instance.updateTokenFromFirebase();
    catagoriesList = await FirebaseFirestoreHelper.instance.getCategories();
    productModelList = await FirebaseFirestoreHelper.instance.getProducts();

    productModelList.shuffle();
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  TextEditingController searchController = TextEditingController();
  List<ProductModel> searchList = [];
  void searchProducts(String value) {
    searchList = productModelList
        .where((element) =>
            element.name.toLowerCase().contains(value.toLowerCase()))
        .toList();
    setState(() {});
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
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const TopTitle(title: 'E commerce', subTitle: ''),
                        TextFormField(
                          controller: searchController,
                          onChanged: (String value) {
                            searchProducts(value);
                          },
                          decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.search),
                              hintText: 'Serach'),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text(
                      'Catagories',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  catagoriesList.isEmpty
                      ? const Center(child: Text('Categories is empty'))
                      : SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                              children: catagoriesList
                                  .map((element) => Padding(
                                        padding: const EdgeInsets.only(left: 8),
                                        child: CupertinoButton(
                                          padding: EdgeInsets.zero,
                                          onPressed: () {
                                            Routes.instance.push(
                                                widget: CategoryView(
                                                    categoryModel: element),
                                                context: context);
                                          },
                                          child: Card(
                                            elevation: 3,
                                            color: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: SizedBox(
                                              height: 100,
                                              width: 100,
                                              child: Image.network(
                                                element.image,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ))
                                  .toList()),
                        ),
                  const SizedBox(height: 12),
                  !isSearched()
                      ? const Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text(
                            'Top Selling',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        )
                      : SizedBox.fromSize(),
                  const SizedBox(height: 12),
                  searchController.text.isNotEmpty && searchList.isEmpty
                      ? const Center(
                          child: Text('No Product Found'),
                        )
                      : searchList.isNotEmpty
                          ? Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: GridView.builder(
                                padding: const EdgeInsets.only(bottom: 50),
                                shrinkWrap: true,
                                primary: false,
                                itemCount: searchList.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        childAspectRatio: 0.7,
                                        mainAxisSpacing: 20,
                                        crossAxisSpacing: 20,
                                        crossAxisCount: 2),
                                itemBuilder: (context, index) {
                                  ProductModel singleProduct =
                                      searchList[index];
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
                                          Text(
                                              'Price \$${singleProduct.price}'),
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
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
                          : productModelList.isEmpty
                              ? const Center(
                                  child: Text('Top Selling is empty'),
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: GridView.builder(
                                    padding: const EdgeInsets.only(bottom: 50),
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
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: SingleChildScrollView(
                                          physics:
                                              const BouncingScrollPhysics(),
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
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                  'Price \$${singleProduct.price}'),
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
            ),
    );
  }

  bool isSearched() {
    if (searchController.text.isNotEmpty && searchList.isEmpty) {
      return true;
    } else if (searchController.text.isEmpty && searchList.isNotEmpty) {
      return false;
    } else if (searchList.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }
}
