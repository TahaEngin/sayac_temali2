import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io';

import 'package:provider/provider.dart';

void main() => runApp(ChangeNotifierProvider(child: MyApp(),create: (BuildContext context)=>Themechanger(false),));

class MyApp extends StatelessWidget {
   @override
  Widget build(BuildContext context) {
    return Consumer<Themechanger>(
      builder: (context ,themechanger ,child){
       return BlocProvider(
        create: (context)=> CounterCubit(),
         child: MaterialApp(
          theme: themechanger.getTheme,
          home: MyHomePage(),
             ),
       );
      },
    );
  }
}
class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(onPressed: (() {
        Themechanger themechanger = Provider.of<Themechanger>(context,listen: false);
        themechanger.swap();
        }),icon: Icon(Icons.brightness_6)),
      ],),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Sayaça şu kadar basıldı:"),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: BlocBuilder<CounterCubit,Counter>(
                builder: ((context, state) {
                  return Text(state.number.toString());
                }))),
            ElevatedButton(
                    child: Text("Sayacı arttır."),
                    onPressed: (){
                      BlocProvider.of<CounterCubit>(context).arttir();
                    },
                  ),
            ],
        ),
      ),
    );
  }
}

class Themechanger extends ChangeNotifier{
  ThemeData _selected = ThemeData.light();
  Themechanger(bool isDark){
    _selected = isDark ? ThemeData.dark() : ThemeData.light();
  }
  ThemeData get getTheme => _selected;
  void swap() {
    _selected = _selected == ThemeData.dark() ? ThemeData.light() : ThemeData.dark();
    notifyListeners();
  }
}
class Counter{
final int number;
Counter(this.number);
}
class CounterCubit extends Cubit<Counter>{
  CounterCubit(): super(Counter(0));
  void arttir() => emit(Counter(state.number+1));
  
}