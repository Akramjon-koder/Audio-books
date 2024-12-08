import 'package:audiobook/src/extensions/size_extensions.dart';
import 'package:audiobook/src/helpers/nav_helper.dart';
import 'package:audiobook/src/theme/apptheme.dart';
import 'package:audiobook/src/ui/home/home.dart';
import 'package:audiobook/src/ui/widgets/screen_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../audio_play/presentation/play_audio.dart';
import '../../widgets/enums.dart';
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
        child: state.status == ScreenStatus.loading ? CupertinoActivityIndicator(
          color: theme.grey,
        ) : Text(
          "Kitoblar mavjud emas.",
          style: theme.textStyle.copyWith(
            color: theme.grey,
          ),
        ),
      ): Column(
        children: [
          if(state.lastPlayedIndex != null)
            Padding(
              padding: 15.a.all,
              child: InkWell(
                onTap: () => push(context, AudioPage(
                  data: state.books,
                  index: state.lastPlayedIndex!,
                  position: state.lastPlayedDuration,
                )),
                child: ColoredBox(
                  color: theme.mainBlue,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.a,
                      vertical: 6.a,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Ohirgi eshitayotgan kitobni o\'qish',
                          style: theme.textStyle.copyWith(
                            color: Colors.white,
                          ),
                        ),
                        20.a.width,
                        FaIcon(
                          FontAwesomeIcons.arrowRight,
                          size: 16.a,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          Expanded(
            child: GridView.builder(
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
                tapCallBack: () => push(context, AudioPage(
                  data: state.books,
                  index: index,
                )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
