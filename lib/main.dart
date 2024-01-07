import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/home/data/data_source/remote_data_source.dart';
import 'features/home/data/repository/product.dart';
import 'features/home/domain/usecase/get_products.dart';
import 'features/home/presentation/bloc/product_bloc.dart';
import 'features/home/presentation/home_page.dart';

void main() {
  runApp(const FakesStoreApp());
}

class FakesStoreApp extends StatelessWidget {
  const FakesStoreApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (context) => ProductBloc(GetProductsUseCase(ProductRepositoryImpl(HomeRemoteDataSource(Dio())))),
        child: App(),
      ),
    );
  }
}
