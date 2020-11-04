import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_ddd_course/application/notes/note_form/note_form_bloc.dart';
import 'package:notes_ddd_course/domain/notes/value_objects.dart';

class ColorField extends StatelessWidget {
  const ColorField({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteFormBloc, NoteFormState>(
      buildWhen: (p, c) => p.note.color != c.note.color,
      builder: (context, state) {
        return SizedBox(
          height: 80.0,
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            scrollDirection: Axis.horizontal,
            itemCount: NoteColor.predefinedColors.length,
            itemBuilder: (context, index) {
              final itemColor = NoteColor.predefinedColors[index];
              return GestureDetector(
                onTap: () {
                  context
                      .bloc<NoteFormBloc>()
                      .add(NoteFormEvent.colorChanged(itemColor));
                },
                child: Material(
                  shape: CircleBorder(
                    side: state.note.color.value.fold(
                      (_) => BorderSide.none,
                      (color) => color == itemColor
                          ? const BorderSide(width: 1.5)
                          : BorderSide.none,
                    ),
                  ),
                  elevation: 4.0,
                  color: itemColor,
                  child: const SizedBox(
                    width: 50.0,
                    height: 50.0,
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(width: 12.0),
          ),
        );
      },
    );
  }
}
