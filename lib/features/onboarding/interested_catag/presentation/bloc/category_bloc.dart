import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sureline/core/constants/sureline_categories.dart';
import 'package:sureline/features/onboarding/interested_catag/domain/entity/category_entity.dart';
import 'package:sureline/features/onboarding/interested_catag/presentation/bloc/category_event.dart';
import 'package:sureline/features/onboarding/interested_catag/presentation/bloc/category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(Initial()) {
    on<GetCategories>((event, emit) {
      emit(GettingCategories());
      emit(
        GotCategories(
          SurelineCategories.values
              .map((model) => CategoryEntity.fromModel(model))
              .toList(),
        ),
      );
    });
  }
}
