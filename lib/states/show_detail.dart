import 'package:evefireextin/models/extinguisher_model.dart';
import 'package:evefireextin/utility/my_constant.dart';
import 'package:evefireextin/widgets/show_network_image.dart';
import 'package:evefireextin/widgets/show_title.dart';
import 'package:flutter/material.dart';

class ShowDetail extends StatefulWidget {
  final ExtinguisherModel extinguisherModel;

  const ShowDetail({Key? key, required this.extinguisherModel})
      : super(key: key);

  @override
  _ShowDetailState createState() => _ShowDetailState();
}

class _ShowDetailState extends State<ShowDetail> {
  ExtinguisherModel? extinguisherModel;

  @override
  void initState() {
    super.initState();
    extinguisherModel = widget.extinguisherModel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Show Detail'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) => Center(
          child: Column(
            children: [
              ShowTitle(
                title: extinguisherModel!.name,
                textStyle: MyConstant().h1Style(),
              ),
              Container(width: constraints.maxWidth*0.6,
                child: ShowNetworkImage(urlImage: extinguisherModel!.image),
              )
            ],
          ),
        ),
      ),
    );
  }
}
