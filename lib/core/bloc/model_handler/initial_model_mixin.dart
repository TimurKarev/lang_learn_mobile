import 'package:lang_learn_mobile/core/bloc/model_handler/model_handler_bloc.dart';

mixin SettingsChangeTracker<M extends Object, P extends Object>
    on ModelHandlerBloc<M, P> {
  M? _initialModel;

  void setInitialModel(M model) {
    _initialModel = model;
  }

  M? getInitialModel() {
    return _initialModel;
  }

  bool get hasChanges {
    if (state case final ModelHandlerLoaded<M> loadedState
        when _initialModel != null) {
      return loadedState.model != _initialModel;
    }
    return false;
  }
}
