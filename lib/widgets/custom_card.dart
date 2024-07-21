import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pawsome_stays/services/navigation_service.dart';

class CustomCard extends StatefulWidget {
  final Icon icon;
  final String title, subtitle, path;


  const CustomCard({super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.path,
  });

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  final GetIt _getIt= GetIt.instance;

  late NavigationService _navigationService;

  @override
  void initState() {
    super.initState();
    _navigationService = _getIt.get<NavigationService>();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shadowColor: Colors.blue,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: widget.icon,
            title: Text(widget.title,
              style:TextStyle(
                color: Colors.blue,
              )
            ),
            subtitle: Text(widget.subtitle),
            onTap: (){
              _navigationService.pushNamed(widget.path);
            },
          ),
        ],
      ),
    );
  }
}
