import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:h_firebase_demo/constants/contants.dart';
import 'package:h_firebase_demo/models/products_model/products_model.dart';
import 'package:h_firebase_demo/provider/app_provider.dart';
import 'package:provider/provider.dart';

class SingleCartIem extends StatefulWidget {
  final ProductModel singleProduct;
  const SingleCartIem({super.key, required this.singleProduct});

  @override
  State<SingleCartIem> createState() => _SingleCartIemState();
}

class _SingleCartIemState extends State<SingleCartIem> {
  int qty = 1;
  @override
  void initState() {
    qty = widget.singleProduct.qty ?? 0;
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.red, width: 3)),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 140,
              color: Colors.red.withOpacity(0.5),
              child: Image.network(widget.singleProduct.image),
            ),
          ),
          Expanded(
            flex: 2,
            child: SizedBox(
              height: 140,
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FittedBox(
                                child: Text(
                                  widget.singleProduct.name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Row(
                                children: [
                                  CupertinoButton(
                                    onPressed: () {
                                      if (qty > 1) {
                                        setState(() {
                                          qty--;
                                        });
                                        appProvider.updateQty(
                                            widget.singleProduct, qty);
                                      }
                                    },
                                    padding: EdgeInsets.zero,
                                    child: const CircleAvatar(
                                      maxRadius: 13,
                                      child: Icon(Icons.remove),
                                    ),
                                  ),
                                  Text(
                                    qty.toString(),
                                    style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  CupertinoButton(
                                    onPressed: () {
                                      setState(() {
                                        qty++;
                                      });
                                      appProvider.updateQty(
                                          widget.singleProduct, qty);
                                    },
                                    child: const CircleAvatar(
                                      maxRadius: 13,
                                      child: Icon(Icons.add),
                                    ),
                                  ),
                                ],
                              ),
                              CupertinoButton(
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  if (!appProvider.getFavouriteProductList
                                      .contains(widget.singleProduct)) {
                                    appProvider.addFavouriteProduct(
                                        widget.singleProduct);
                                    showMessage('Added to wishlist');
                                  } else {
                                    appProvider.removeFavouriteProduct(
                                        widget.singleProduct);
                                    showMessage('Removed to wishlist');
                                  }
                                },
                                child: Text(
                                    appProvider.getFavouriteProductList
                                            .contains(widget.singleProduct)
                                        ? 'Remove to wishlist'
                                        : 'Add to wishlist',
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ],
                          ),
                          Text('\$${widget.singleProduct.price.toString()}',
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      CupertinoButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            appProvider.removeCartProduct(widget.singleProduct);
                            showMessage('Removed from Cart');
                          },
                          child: const CircleAvatar(
                            maxRadius: 13,
                            child: Icon(
                              Icons.delete,
                              size: 18,
                            ),
                          )),
                    ],
                  )),
            ),
          )
        ],
      ),
    );
  }
}
