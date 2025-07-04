import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sureline/common/presentation/widgets/sureline_button.dart';
import 'package:sureline/common/presentation/widgets/sureline_text_field.dart';
import 'package:sureline/core/theme/app_colors.dart';
import 'package:sureline/core/utils/utils.dart';
import 'package:sureline/features/preferenecs/collections/domain/entity/collection_entity.dart';
import 'package:sureline/features/preferenecs/collections/presentation/bloc/collections_bloc.dart';
import 'package:sureline/features/preferenecs/collections/presentation/bloc/collections_event.dart';
import 'package:sureline/features/preferenecs/collections/presentation/bloc/collections_state.dart';

class CreateCollectionPage extends StatefulWidget {
  const CreateCollectionPage({super.key});

  @override
  State<CreateCollectionPage> createState() => _CreateCollectionPageState();
}

class _CreateCollectionPageState extends State<CreateCollectionPage> {
  final _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<CollectionsBloc, CollectionsState>(
      listener: (context, state) {
        if (state is SavedCollection) {
          print(
            'CreateCollectionPage: Received SavedCollection, navigating back',
          );
          // Navigate back to collections list
          context.pop();
        }
      },
      child: BlocBuilder<CollectionsBloc, CollectionsState>(
        builder: (context, state) {
          return Container(
            padding: const EdgeInsets.only(left: 18, right: 18),
            decoration: Utils.bottomSheetDecoration(ignoreCorners: true),
            child: Column(
              // mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'New collection',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryColor,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Enter a name for your new collection. You can rename it later.',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                    color: AppColors.primaryColor,
                  ),
                ),
                SizedBox(height: 20),
                SurelineTextField(
                  controller: _nameController,
                  showCharLimit: false,
                  hint: 'My new collection',
                  disableCenterAlignment: true,
                  isNameInput: false,
                ),
                Spacer(),
                SurelineButton(
                  text: 'Save',
                  onPressed: () {
                    context.read<CollectionsBloc>().add(
                      SaveCollection(
                        CollectionEntity(
                          id: 0,
                          name: _nameController.text,
                          favouriteQuotes: [],
                          ownQuotes: [],
                          historyQuotes: [],
                          searchQuotes: [],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
