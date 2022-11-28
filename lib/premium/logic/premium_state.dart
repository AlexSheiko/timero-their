part of 'premium_cubit.dart';

abstract class PremiumState extends Equatable {
  const PremiumState();

  @override
  List<Object?> get props => [];
}

class PremiumStateInitial extends PremiumState {
  const PremiumStateInitial();
}

class PremiumLoadInProgress extends PremiumState {
  const PremiumLoadInProgress();
}

class PremiumLoadSuccess extends PremiumState {
  const PremiumLoadSuccess(this.hasPremium);

  final bool hasPremium;

  @override
  List<Object?> get props => [hasPremium];
}

class PremiumLoadFailure extends PremiumState {
  const PremiumLoadFailure(this.errorMessage);

  final String errorMessage;

  @override
  List<Object?> get props => [errorMessage];
}
