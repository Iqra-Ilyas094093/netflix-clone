import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ComingSoonMovieWidget extends StatefulWidget {
  final String imageUrl;
  final String logoUrl;
  final String overview;
  final String month;
  final String day;

  const ComingSoonMovieWidget({
    super.key,
    required this.imageUrl,
    required this.logoUrl,
    required this.overview,
    required this.month,
    required this.day,
  });

  @override
  State<ComingSoonMovieWidget> createState() => _ComingSoonMovieWidgetState();
}

class _ComingSoonMovieWidgetState extends State<ComingSoonMovieWidget> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0,vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.month,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.day,
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 4
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: size.height * 0.5,
                          width: size.width * 0.6,
                          child: CachedNetworkImage(
                            imageUrl: widget.imageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        SizedBox(
                            height: 100,
                            width: 160,
                            child: CachedNetworkImage(imageUrl: widget.logoUrl,alignment: Alignment.centerLeft,fit: BoxFit.cover,)),
                        Spacer(),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.info_outline,color: Colors.grey,),
                            Text('info',style: TextStyle(color: Colors.grey,fontSize: 12),)
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.notification_add_outlined,color: Colors.grey,),
                              Text('Remind Me',style: TextStyle(color: Colors.grey,fontSize: 12),)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Text('Coming on ${widget.month} ${widget.day}'),
                    ],
                  ),
                  SizedBox(
                    child: Text(widget.overview,style: TextStyle(color: Colors.grey,fontSize: 15),),
                  )

                ],
              ),
            )

          ],
        ),

      ],
    );
  }
}
