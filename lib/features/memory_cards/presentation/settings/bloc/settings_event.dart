part of 'settings_bloc.dart';

class ShuffleCardsChangesSettingsEvent extends ModelHandlerEvent {
  const ShuffleCardsChangesSettingsEvent(this.value);

  final bool value;
}

class RepeatWrongChangesSettingsEvent extends ModelHandlerEvent {
  const RepeatWrongChangesSettingsEvent(this.value);

  final bool value;
}

class AskLanguageChangesSettingsEvent extends ModelHandlerEvent {
  const AskLanguageChangesSettingsEvent(this.value);

  final Languages value;
}

// class ApplySettingsEvent extends ModelHandlerEvent {
//   const ApplySettingsEvent();
// }

class CancelSettingsEvent extends ModelHandlerEvent {
  const CancelSettingsEvent();
}
