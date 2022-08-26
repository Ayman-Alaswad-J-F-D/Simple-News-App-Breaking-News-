// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../shared/components/components.dart';
import '../shared/cubit/cubit.dart';
import '../shared/cubit/states.dart';

class TechnologyScreen extends StatelessWidget {
  TechnologyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewAppCubit, NewAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var list = NewAppCubit.get(context).technologyList;
        return ScreenTypeLayout(
          mobile: Builder(
            builder: (BuildContext context) {
              NewAppCubit.get(context).setDesktop(false);
              return articlesBuilder(list, context);
            },
          ),
          desktop: Builder(
            builder: (BuildContext context) {
              NewAppCubit.get(context).setDesktop(true);

              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: articlesBuilder(list, context),
                  ),
                  if (list.length > 0)
                    Expanded(
                      child: Container(
                        color: Theme.of(context).cardColor,
                        height: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(25.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 300,
                                width: double.infinity,
                                // color: Colors.'grey',
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15.0),
                                  // ignore: unnecessary_null_comparison
                                  child: list[NewAppCubit.get(context)
                                              .selectedItem]['urlToImage'] ==
                                          null
                                      ? Icon(Icons.image_not_supported_rounded,
                                          size: 80)
                                      : Image.network(
                                          list[NewAppCubit.get(context)
                                              .selectedItem]['urlToImage'],
                                          errorBuilder: (BuildContext context,
                                              Object exception,
                                              StackTrace? stackTrace) {
                                            return const Icon(
                                              Icons.image_not_supported_rounded,
                                              size: 100,
                                              color: Colors.grey,
                                            );
                                          },
                                          fit: BoxFit.cover,
                                        ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              Text(
                                '${list[NewAppCubit.get(context).selectedItem]['title']}',
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 24, color: Colors.black),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                '${list[NewAppCubit.get(context).selectedItem]['description']}',
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 17, color: Colors.grey.shade600),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                '${list[NewAppCubit.get(context).selectedItem]['publishedAt']}',
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
          breakpoints: ScreenBreakpoints(desktop: 700, tablet: 600, watch: 100),
        );
      },
    );
  }
}
