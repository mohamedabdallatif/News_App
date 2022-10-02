import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/cubit.dart';
import 'package:news_app/layout/states.dart';

Widget buildArticleItem(item,context){
 return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
               image:  DecorationImage(
                image: NetworkImage('${item['urlToImage']}'),
                onError: (exception, stackTrace) {
                  print('err');
                },
                fit: BoxFit.cover,
              ) 
            ),
          ),
          const SizedBox(width: 10,),
          Expanded(
            child: SizedBox(
              height: 120,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children:  [
                  Expanded(
                    child: Text('${item['title']}',style: Theme.of(context).textTheme.bodyText1,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,),
                  ),
                   Text('${item['publishedAt']}',style: const TextStyle(
                    color: Colors.grey
                  ))
                ],
              ),
            ),
          )
        ],
      ),
    );
}
Widget divider(){
  return Container(
            width: double.infinity,
            height: 1.0,
            color: Colors.grey[300],
           );
}
Widget buildArticle(list,context){
  return BlocConsumer<NewsCubit,NewsStates>(
      listener: (BuildContext context, state) {  },
      builder: (BuildContext context, Object? state) {
        return ConditionalBuilder(
        condition: list.length>0,
        builder: (BuildContext context) { 
         return ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemBuilder: ((context, index) {
          return  buildArticleItem(list[index],context);
          }),
          separatorBuilder: ((context, index) {
          return  divider();
          }),
          itemCount: list.length);
         },
        fallback: (BuildContext context) { return  const Center(child: CircularProgressIndicator()); },
    
      );
       },
      
    );
}

void navigateTo(context,widget){
   Navigator.push(context, MaterialPageRoute(builder:(context)=> widget));
}

