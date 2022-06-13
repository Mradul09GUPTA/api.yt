import 'package:api/models/post.dart';
import 'package:api/services/remote_services.dart';
import 'package:flutter/material.dart';


class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<Post>? posts;
  var isLoaded = false;
  @override
  void initState(){
    super.initState();
    getData();
  }
  getData()async{
posts=await RemoteServies().getPosts();
if(posts!=null){
  setState((){
    isLoaded=true;
  });
}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Posts') ,
      ),
          body:Visibility(
          visible: isLoaded,
          child :ListView.builder(
            itemCount: posts?.length,
            itemBuilder: (context,index){
          return Container(
            padding: const EdgeInsets.all(16),
            child :Row(
            children: [
            Container(
              height:50,
              width: 50,
            decoration: BoxDecoration(
             borderRadius: BorderRadius.circular(12),
              color: Colors.red[300],
            ),
          ),
             SizedBox(width: 16),
             Expanded(
             child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
            children:[
              Text(
              posts![index].title,
              maxLines: 2,
                overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize:24, fontWeight:FontWeight.bold
              ),
              ),
              Text(
                posts![index].body??'',
                maxLines: 3,
                overflow: TextOverflow.ellipsis,

              ),
              ],
            )
             ),
          ]
            ),
              );
      },
    ),
            replacement: const Center(
              child:CircularProgressIndicator() ,),
    ),
    );
  }
}
