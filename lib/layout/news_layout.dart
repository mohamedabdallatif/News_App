import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/componants/componants.dart';
import 'package:news_app/layout/appcubit.dart';
import 'package:news_app/layout/cubit.dart';
import 'package:news_app/layout/states.dart';
import 'package:news_app/modules/search.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (BuildContext context, state) {  },
      builder: (BuildContext context, Object? state) { 
        NewsCubit cubit = NewsCubit.get(context);
        return Scaffold(
        appBar: AppBar(
          title: const Text('News App'),
          actions: [
            IconButton(onPressed: (){
              navigateTo(context, SearchScreen());
            },
             icon: const Icon(Icons.search)),
             IconButton(onPressed: (){
              AppCubit.get(context).changeMode();
             },
             icon: const Icon(Icons.brightness_4_outlined))
          ],
        ),
        body: cubit.screens[cubit.currentIndex],
     
        bottomNavigationBar:BottomNavigationBar(
          currentIndex:cubit.currentIndex,
          onTap: (value) {
            cubit.newsChangeNavBar(value);
          },
          items: 
          cubit.bottomItems
        ) ,
      );
       },
    );
  }
}