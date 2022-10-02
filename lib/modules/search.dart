import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/componants/componants.dart';
import 'package:news_app/layout/cubit.dart';
import 'package:news_app/layout/states.dart';

class SearchScreen extends StatelessWidget {
  var searchController=TextEditingController();
   SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (BuildContext context, state) {  },
      builder: (BuildContext context, Object? state) { 
        var list=NewsCubit.get(context).search;
        return Scaffold(
        appBar: AppBar(title: const Text('Search')),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              TextFormField(
                controller:searchController ,
                keyboardType:TextInputType.text ,
                validator:(String? value){
                  if(value!.isEmpty){
                    return 'Search can\'t be empty';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  label: Text('Search'),
                  prefixIcon: Icon(Icons.search)
                ),
                onChanged: (value) {
                  NewsCubit.get(context).getSearch(value);
                },
              ),
              
              Expanded(child: buildArticle(list, context))
            ],
          ),
        ),
      );
       },
      
    );
  }
}