import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_state_managements/feature/travel/cubit/travel_cubit.dart';
import 'package:flutter_state_managements/feature/travel/model/travel_model.dart';
import 'package:flutter_state_managements/product/padding/page_padding.dart';
import 'package:kartal/kartal.dart';

class TravelView extends StatefulWidget {
  TravelView({Key? key}) : super(key: key);

  @override
  State<TravelView> createState() => _TravelViewState();
}

class _TravelViewState extends State<TravelView> {
  final title = 'Hey John! \nWhere do you want to go today?';
  final popularDest = 'Popular destinations near you';
  final seeAll = 'See all';
  @override
  Widget build(BuildContext context) {
    return BlocProvider<TravelCubit>(
      create: (context) => TravelCubit()..fetchItems(),
      child: BlocConsumer<TravelCubit, TravelStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const PagePadding.all(),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(title, style: context.textTheme.subtitle1?.copyWith(fontWeight: FontWeight.bold)),
                context.emptySizedHeightBoxLow,
                TextField(
                  onChanged: (value) {
                    context.read<TravelCubit>().searchByItems(value);
                  },
                  decoration: const InputDecoration(border: OutlineInputBorder(), prefixIcon: Icon(Icons.search)),
                ),
                context.emptySizedHeightBoxLow,
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Text(popularDest, style: context.textTheme.subtitle1?.copyWith(fontWeight: FontWeight.bold)),
                  InkWell(
                      onTap: () {
                        context.read<TravelCubit>().seeAllItems();
                      },
                      child:
                          Text(seeAll, style: context.textTheme.subtitle1?.copyWith(color: context.colorScheme.error)))
                ]),
                SizedBox(
                  height: context.dynamicHeight(0.26),
                  child: _listItems(context),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: state is TravelItemsSeeAll ? state.images.length : 0,
                    itemBuilder: (BuildContext context, int index) {
                      final image = (state as TravelItemsSeeAll).images[index];
                      return Image.asset(image);
                    },
                  ),
                )
              ]),
            ),
          );
        },
      ),
    );
  }

  Widget _listItems(BuildContext context) {
    return BlocSelector<TravelCubit, TravelStates, List<TravelModel>>(selector: (state) {
      return state is TravelItemsLoaded ? state.items : context.read<TravelCubit>().allItems;
    }, builder: ((context, state) {
      return ListView.builder(
          itemCount: state.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: ((context, index) {
            return Card(
                child: SizedBox(
                    width: context.dynamicWidth(0.38), child: Image.asset(TravelModel.mockItems[index].imagePath)));
          }));
    }));
  }
}
