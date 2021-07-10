import 'dart:ui';

import 'package:drawerbehavior/drawerbehavior.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'constants.dart';
import '../../drawers_constants/user_drawer.dart';
import '../../models/User.dart';
import '../../widgets/constants.dart';

// ignore: must_be_immutable
class SuccessStories extends StatefulWidget {
  @override
  _SuccessStoriesState createState() => _SuccessStoriesState();
}

class _SuccessStoriesState extends State<SuccessStories> {
  final DrawerScaffoldController controller = DrawerScaffoldController();
  late int selectedMenuItemId;
  var userInfo;

  @override
  void initState() {
    selectedMenuItemId = menuWithIcon.items[3].id;
    userInfo = Provider.of<UserData>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    print("item: $selectedMenuItemId");
    return DrawerScaffold(
      // appBar: AppBar(), // green app bar
      drawers: [
        SideDrawer(
          percentage: 0.75, // main screen height proportion
          headerView: header(context, userInfo),
          footerView: footer(context, controller),
          color: successStoriesCardBgColor,
          selectorColor: Colors.red, menu: menuWithIcon,
          animation: true,
          selectedItemId: selectedMenuItemId,
          onMenuItemSelected: (itemId) {
            setState(() {
              selectedMenuItemId = itemId;
              selectedItem(context, itemId);
            });
          },
        )
      ],
      controller: controller,
      builder: (context, id) => SafeArea(
        child: Center(
          child: Column(
            children: <Widget>[
              Stack(
                // circle design
                children: <Widget>[
                  Positioned(
                    child: Image.asset("assets/images/circle-design.png"),
                  ),
                  Positioned(
                    child: AppBar(
                      centerTitle: true,
                      title: Text(
                        "YWCA Of Bombay",
                        style: TextStyle(
                          fontFamily: 'LobsterTwo',
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          color: Colors.black87,
                        ),
                      ),
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      leading: IconButton(
                        icon: Icon(
                          Icons.menu,
                          color: Colors.black,
                          size: 30,
                        ),
                        onPressed: () => {
                          // widget.onMenuPressed,
                          controller.toggle(Direction.left),
                          // OR
                          // controller.open()
                        },
                      ),
                    ),
                  ),
                  //Title start
                  Padding(
                    padding: EdgeInsets.only(top: _height * 0.12),
                    child: Container(
                      width: double.infinity,
                      child: Center(
                        child: Text(
                          'Success Stories',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            color: Color(0xff333647),
                            fontWeight: FontWeight.bold,
                            fontSize: 26,
                          ),
                        ),
                      ),
                    ),
                  ),
                  //Title end
                ],
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: _height * 0.7,
                      child: DotPaginationSwiper.builder(
                        itemCount: titles.length,
                        itemBuilder: (context, i) => Center(
                          child: cardWid(
                            images[i],
                            titles[i],
                            detailText[i],
                            _height,
                            _width,
                          ),
                        ),
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
  }

  Container cardWid(
    String image,
    String title,
    String detailText,
    double _height,
    double _width,
  ) {
    print(_height);
    print(_width);
    //  card start
    return Container(
      margin: EdgeInsets.symmetric(horizontal: _width * 0.07),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFFCDF1EF)),
        color: successStoriesCardBgColor,
        borderRadius: BorderRadius.all(Radius.circular(40)),
      ),
      height: 540,
      width: 360,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          //    image
          Container(
            margin: EdgeInsets.all(_height * 0.025),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(120.0),
              child: Image(
                image: AssetImage(image),
                fit: BoxFit.contain,
                height: 200,
                width: 200,
              ),
            ),
          ),
          //  image end
          //  card Title
          Text(
            title,
            // 'A Slice Of Support',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: "Montserrat",
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          //  card Title
          //card info
          Padding(
            padding: EdgeInsets.only(
              left: _width * 0.05,
              right: _width * 0.05,
              top: _height * 0.01,
              // bottom: 5,
            ),
            child: Text(
              detailText,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: "Montserrat",
                height: 1.3,
                fontSize: 15,
              ),
            ),
          ),
          //  end card info
        ],
      ),
    );
  }
}

@immutable
class ColorDot extends StatelessWidget {
  const ColorDot({
    Key? key,
    this.color,
    this.borderColor,
    this.radius,
  }) : super(key: key);

  final Color? color;
  final Color? borderColor;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    Color? color = this.color;
    Color? borderColor = this.borderColor;
    double? radius = this.radius;

    return Padding(
      padding: const EdgeInsets.all(1),
      child: Container(
        height: radius,
        width: radius,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
          border: Border.all(
            width: 0.8,
            color: borderColor!,
          ),
        ),
      ),
    );
  }
}

@immutable
class DotPagination extends StatelessWidget {
  const DotPagination(
      {Key? key, required this.itemCount, required this.activeIndex})
      : assert(activeIndex >= 0),
        assert(activeIndex < itemCount),
        super(key: key);

  final int itemCount;
  final int activeIndex;

  @override
  Widget build(BuildContext context) {
    final inactiveDot = ColorDot();
    final activeDot = ColorDot(
      color: Theme.of(context).primaryColor,
    );

    final list = List<ColorDot>.generate(
      itemCount,
      (index) => (index == activeIndex) ? activeDot : inactiveDot,
    );

    return Padding(
      padding: const EdgeInsets.all(8),
      // TODO: Renderflex error
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: list,
      ),
    );
  }
}

@immutable
class DotPaginationSwiper extends StatefulWidget {
  DotPaginationSwiper({
    Key? key,
    required this.onPageChanged,
    List<Widget> children = const <Widget>[],
  })  : childrenDelegate = SliverChildListDelegate(children),
        itemCount = children.length,
        super(key: key);

  DotPaginationSwiper.builder({
    Key? key,
    this.onPageChanged,
    IndexedWidgetBuilder? itemBuilder,
    int? itemCount,
  })  : childrenDelegate =
            SliverChildBuilderDelegate(itemBuilder!, childCount: itemCount),
        itemCount = itemCount!,
        super(key: key);

  final SliverChildDelegate childrenDelegate;
  final int itemCount;
  final ValueChanged<int>? onPageChanged;

  @override
  _DotPaginationSwiperState createState() => _DotPaginationSwiperState();
}

class _DotPaginationSwiperState extends State<DotPaginationSwiper> {
  int _index = 0;

  @override
  void initState() {
    _index = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        PageView.custom(
            childrenDelegate: widget.childrenDelegate,
            onPageChanged: (i) {
              setState(() {
                _index = i;
                widget.onPageChanged!.call(i);
              });
            }),
        Align(
          child: DotPagination(
            itemCount: widget.itemCount,
            activeIndex: _index,
          ),
          alignment: Alignment.bottomCenter,
        ),
      ],
    );
  }
}
