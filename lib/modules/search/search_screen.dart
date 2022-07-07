
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ymcs/modules/webViwe/view.dart';
import 'package:ymcs/shared/cubit/cubit.dart';
import 'package:ymcs/shared/cubit/states.dart';
import 'package:ymcs/shared/network/linked.dart';

class Search extends StatelessWidget {

var controller= TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context,state){},
      builder: (context,state){
        var list=NewsCubit.get(context).Search;
        return  Scaffold(
          appBar: AppBar(),
          body:SingleChildScrollView(
            child: Column(
              children:
              [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: TextFormField(
                    onEditingComplete: ()
                    {
                      NewsCubit.get(context).getSearch(controller.text);
                    },
                    controller:controller,
                    decoration:InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        prefixIcon: Icon(
                          Icons.search,
                        ),
                        labelText: 'Search'
                    ),
                    keyboardType:TextInputType.text,
                    validator:(String value){
                      if(value.isEmpty){
                        return 'Search must not be empty ';
                      }
                      return null;
                    } ,

                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(top: 10.0),
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: list.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 20.0),
                    child: InkWell(
                      onTap: (){
                        navigateTo(context,View(list[index]['url']),);
                      },
                      child: Container(
                        width: double.infinity,
                        height: 105,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: Theme.of(context).backgroundColor,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                width: double.infinity,
                                height: double.infinity,
                                child: CachedNetworkImage(
                                  imageUrl: list[index]['urlToImage'],
                                  fit: BoxFit.cover,
                                  progressIndicatorBuilder:
                                      (context, url, downloadProgress) => Center(
                                    child: CircularProgressIndicator(
                                      value: downloadProgress.progress,
                                      strokeWidth: 3,
                                    ),
                                  ),
                                  errorWidget: (context, url, error) => Icon(Icons.error,color: Colors.deepOrange,),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      list[index]['title'],
                                      style: Theme.of(context).textTheme.bodyText1,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                    Row(
                                      //textBaseline: TextBaseline.ideographic,
                                      //crossAxisAlignment: CrossAxisAlignment.baseline,
                                      children: [
                                        Icon(
                                          Icons.watch_later_outlined,
                                          size: 16,
                                          color: Colors.deepOrange,
                                        ),
                                        SizedBox(
                                          width: 4,
                                        ),
                                        Text(
                                          list[index]['publishedAt'],
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
