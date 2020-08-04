/*
 * -------购物车首页-------
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../views/cart_item_widget.dart';
import '../views/cart_bottom_widget.dart';

class CartPage extends StatefulWidget {
  CartPage({Key key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _getCartInfo(context),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Consumer<CartProvider>(
              builder: (BuildContext context, child, value) {
                return Stack(
                  children: <Widget>[
                    ListView.builder(
                      itemCount: child.infoList.length,
                      itemBuilder: (context, index) {
                        return CartItem(child.infoList[index]);
                      },
                    ),
                    Positioned(bottom: 0, left: 0, child: CartBottom())
                  ],
                );
              },
            );
          } else {
            return Text('暂无数据');
          }
        });
  }

  Future<String> _getCartInfo(BuildContext context) async {
    await Provider.of<CartProvider>(context, listen: false).getCartInfo();
    return '加载完成';
  }
}
