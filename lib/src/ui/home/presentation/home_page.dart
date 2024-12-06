import 'package:audiobook/src/extensions/size_extensions.dart';
import 'package:audiobook/src/theme/apptheme.dart';
import 'package:audiobook/src/ui/home/home.dart';
import 'package:audiobook/src/ui/widgets/screen_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'book_item.dart';

class BooksScreen extends StatelessWidget {
  const BooksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.select((BooksBloc bloc) => bloc.state);
    return Screen(
      backWidget: SizedBox(),
      title: 'Audio kitoblar',
      child: state.books.isEmpty ? Center(
        child: state.status == BooksScreenStatus.loading ? CupertinoActivityIndicator(
          color: theme.grey,
        ) : Text(
          "Kitoblar mavjud emas.",
          style: theme.textStyle.copyWith(
            color: theme.grey,
          ),
        ),
      ): GridView.builder(
        padding: 15.a.horizontal,
        itemCount: state.books.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.6,
          mainAxisSpacing: 10.a,
          crossAxisSpacing: 10.a,
        ),
        itemBuilder: (context, index) => BookItem(
          data: state.books[index],
          loadController: state.loadingAudios[state.books[index].id],
        ),
      ),
    );
  }
}
