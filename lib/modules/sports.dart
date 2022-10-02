import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/componants/componants.dart';
import 'package:news_app/layout/cubit.dart';
import 'package:news_app/layout/states.dart';

class SportsScreen extends StatelessWidget {
  const SportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (BuildContext context, state) {  },
      builder: (BuildContext context, Object? state) {
        var list=NewsCubit.get(context).sports;
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
}