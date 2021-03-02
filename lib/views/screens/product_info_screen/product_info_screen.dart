import 'package:flutter/material.dart';
import 'package:pgsk/core/entities/product.dart';
import 'package:pgsk/views/widgets/gradient_colored_long_action_button.dart';
import 'package:provider/provider.dart';

import '../../../controllers/providers/cart.dart';
import '../../../main.dart';
import '../../widgets/favorite_button.dart';
import '../home_screen/custom_app_bar.dart';
import '../home_screen/homepage.dart';

//ProductInfo is made a stateful widget so as to easily display the specification tab onPress of the More button
class ProductInfoPage extends StatefulWidget {
  final Product product;

  ProductInfoPage(this.product);

  @override
  _ProductInfoPageState createState() => _ProductInfoPageState();
}

class _ProductInfoPageState extends State<ProductInfoPage> {

  Widget _currentTab;

  ///_currentTabIndex indicates which info tab is on display, either the first or second.
  ///Value can either be 1 or 2
  int _currentTabIndex = 1; 

  Widget _buildActionButtons() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          _buildActionButton(
            gradientColored: false,
            onPressed: () => Provider.of<Cart>(context, listen: false).addProduct(widget.product),
            text: "Add to Cart"
          ),
          Expanded(child: SizedBox()),
          _buildActionButton(
            gradientColored: true,
            onPressed: () {},
            text: "Buy Now"
          )
        ],
      ),
    );
  }

  Widget _buildActionButton({
    @required String text, 
    @required Function onPressed, 
    @required bool gradientColored
    }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Text(text, textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyText1),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: gradientColored ? null : Colors.grey,
          gradient: gradientColored 
                      ? LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Theme.of(context).primaryColorLight,
                          Theme.of(context).primaryColor
                        ]
                      )
                      : null
        ),
      ),
    );
  }

  ///primaryInfo includes the name, category, price, and reviewRating
    Widget _buildPrimaryInfo() => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        RichText(
          text: TextSpan(
            text: widget.product.name + "\n", style: PGSK.homepageTexts.copyWith(fontSize: 16),
            children: [TextSpan(
              text: widget.product.categoryName, style: Theme.of(context).textTheme.subtitle2.copyWith(fontSize: 12)
            )]
            ),
         ),
        
        Row(
          children: [
            Text("\n${PGSK.currency}${widget.product.price.toStringAsFixed(0)}", style: PGSK.homepageTexts),
            Expanded(child: SizedBox()),
            _buildReviewRating()
          ],
        ),
      ],
    );

  Widget _buildFirstInfoTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
              _buildPrimaryInfo(),
              Divider(color: Colors.grey,),
              _buildActionButtons(),
              SizedBox(height: 25),
              Expanded(child: _buildDescriptionBox()),
              Divider(color: Colors.grey),
              Center(child: FlatButton(
                onPressed: () => setState(() {
                  _currentTab = _buildSecondInfoTab();
                  _currentTabIndex = 2;
                }),
                child: Text("More", style: Theme.of(context).textTheme.headline4.copyWith(fontSize:14))),),
      ],
    );
  }

  Widget _buildDescriptionBox() => Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Description", style: Theme.of(context).textTheme.headline4.copyWith(fontSize: 14)),
        Expanded(
          child: TextFormField(
            decoration: InputDecoration(border: InputBorder.none),
            maxLines: 7,
            readOnly: true,
            scrollPadding: EdgeInsets.all(5),
            initialValue: widget.product.description,
            style: Theme.of(context).textTheme.subtitle2.copyWith(fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );

  Widget _buildSecondInfoTab() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Specification", style: Theme.of(context).textTheme.headline4.copyWith(fontSize: 14)),
        Flexible(
          child: SizedBox(
            child: TextFormField(
              decoration: InputDecoration(border: InputBorder.none),
              maxLines: 7,
              readOnly: true,
              scrollPadding: EdgeInsets.all(5),
              initialValue: widget.product.specification,
              style: Theme.of(context).textTheme.subtitle2.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
        ),
        SizedBox(height: 12),
        Divider(color: Colors.grey),
        SizedBox(height: 12),
        Text("Reviews", style: Theme.of(context).textTheme.headline4.copyWith(fontSize: 14)),
        Text("Clementina Davids", style: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.black)),
        _buildReviewRating(),
        Text("Kaspersky Antivirus  is the awarded protection against viruses, spyware, and other malware"),
        SizedBox(height: 10),
        GradientColoredLongActionButton(
          onPressed: (){},
          text: "CONTINUE",
        )
      ],
    );
  }

  Widget _buildReviewRating () => Column(
      children: [
        ButtonBar(
          buttonPadding: EdgeInsets.zero,
          children: [
            Icon(Icons.star_rate, color: Colors.yellow, size: 15),
            Icon(Icons.star_rate, color: Colors.yellow, size: 15),
            Icon(Icons.star_rate, color: Colors.yellow, size: 15),
            Icon(Icons.star_rate, color: Colors.yellow, size: 15),
            Icon(Icons.star_border_rounded, color: Colors.grey, size: 15),
          ],
        ),
        Text("345 Review", style: Theme.of(context).textTheme.subtitle2)
      ],
    );

  Widget _buildCustomAppBar(BoxConstraints constraint) {
    return CustomAppBar(
                  size: constraint,
                  title: "",
                  leading: GestureDetector(
                    onTap: () =>
                      _currentTabIndex == 2 
                        ? setState(() {
                          _currentTabIndex = 1;
                          _currentTab = _buildFirstInfoTab();
                        }) 
                        : Navigator.of(context).pop() 
                    ,
                    child: Icon(Icons.arrow_back_ios, color: Colors.black, size: 30)),
                  trailing: Align(
                    alignment: Alignment.bottomRight,
                    child: FavoriteButton(widget.product))
                );
  }

  @override
  Widget build(BuildContext context) {
    if (_currentTab == null) _currentTab = _buildFirstInfoTab();
    return Scaffold(
      body: LayoutBuilder(
        builder: (_, constraint) => Center(
          child: SizedBox(
            width: constraint.maxWidth * HomePage.screenWidthMultiplier,
            child: Column(
              children: [
                _buildCustomAppBar(constraint),
                Container(
                  padding: EdgeInsets.all(10),
                  height: constraint.maxHeight * 0.3,
                  child: Image.asset(widget.product.imageUrl, 
                    height: constraint.maxHeight * 025,
                    width: constraint.maxWidth * 0.5,
                    fit: BoxFit.cover),
                ),
                Expanded(child: _currentTab)
              ],
            ),
          ),
        ),
      )
    );
  }
}