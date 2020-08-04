/*
 * -------购物车页面-------
 * 底部widget
 */

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import '../../../config/color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../../../config/routers/router_application.dart';

class CartBottom extends StatelessWidget {
  const CartBottom({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(5.0),
        color: Colors.white,
        child: Consumer<CartProvider>(
            builder: (BuildContext context, child, value) {
          return Row(
            children: <Widget>[
              _selectAllBtn(context),
              _allPriceArea(context, child.allPrice),
              _buyBtn(context, child.allGoodsCount),
            ],
          );
        }));
  }

  Widget _selectAllBtn(context) {
    bool isAllCheck =
        Provider.of<CartProvider>(context, listen: false).isAllCheck;
    return Container(
      child: Row(
        children: <Widget>[
          Checkbox(
              value: isAllCheck,
              activeColor: KColor.themeColor,
              onChanged: (bool isSelect) {
                Provider.of<CartProvider>(context, listen: false)
                    .changeAllCheckState(isSelect);
              }),
          Text('全选')
        ],
      ),
    );
  }

  // 合计所在区域
  Widget _allPriceArea(context, allPrice) {
    return Container(
      width: ScreenUtil().setWidth(430),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              // 合计
              Container(
                alignment: Alignment.centerRight,
                width: ScreenUtil().setWidth(280),
                child: Text(
                  '合计：',
                  style: TextStyle(fontSize: ScreenUtil().setSp(34)),
                ),
              ),

              // 价格
              Container(
                alignment: Alignment.centerLeft,
                width: ScreenUtil().setWidth(150),
                child: Text(
                  '￥${allPrice}',
                  style: TextStyle(
                      color: Colors.red, fontSize: ScreenUtil().setSp(34)),
                ),
              ),
            ],
          ),

          //底部提示文字
          Container(
            width: ScreenUtil().setWidth(430),
            alignment: Alignment.centerRight,
            child: Text(
              '满10元免配送费，预约免费配送',
              style: TextStyle(
                  color: Colors.black38, fontSize: ScreenUtil().setSp(22)),
            ),
          ),
        ],
      ),
    );
  }

  // 结算按钮
  Widget _buyBtn(context, allGoodsCount) {
    return Container(
      width: ScreenUtil().setWidth(160),
      padding: EdgeInsets.only(left: 10),
      child: InkWell(
        onTap: () {
          if (allGoodsCount > 0) {
            ApplicationRouter.router.navigateTo(context, 'order/pay',
                transition: TransitionType.native);
          }
        },
        child: Container(
          padding: EdgeInsets.all(10.0),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: KColor.themeColor,
            borderRadius: BorderRadius.circular(3.0),
          ),
          child: Text(
            '结算(${allGoodsCount})',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
