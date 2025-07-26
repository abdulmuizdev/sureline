import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sureline/core/constants/sureline_categories.dart';
import 'package:sureline/features/onboarding/interested_catag/domain/entity/category_entity.dart';
import 'package:sureline/features/onboarding/interested_catag/presentation/bloc/category_event.dart';
import 'package:sureline/features/onboarding/interested_catag/presentation/bloc/category_state.dart';

/// Bloc for managing category state during the onboarding process.
/// This bloc handles the retrieval and management of quote categories
/// that users can select to personalize their quote experience.
///
/// The bloc coordinates between the UI and predefined category data,
/// providing proper state management for category selection and display.
class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(Initial()) {
    on<GetCategories>((event, emit) {
      emit(GettingCategories());
      emit(
        GotCategories(
          SurelineCategories.values.map((model) => CategoryEntity.fromModel(model)).toList(),
        ),
      );
    });
  }
}
