import 'package:equatable/equatable.dart';
import 'package:error_handling/error_handling.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/premium_repository.dart';

part 'premium_state.dart';

class PremiumCubit extends Cubit<PremiumState> {
  PremiumCubit(this._premiumRepository) : super(const PremiumStateInitial());

  final PremiumRepository _premiumRepository;

  Future<void> onPageOpened() async {
    await _showPremium();
  }

  Future<void> onBackPressed() async {
    emit(const PremiumStateInitial());
  }

  Future<void> purchase() async {
    emit(const PremiumLoadInProgress());
    try {
      await _premiumRepository.purchase();
      await _showPremium();
    } on UserCanceledException catch (_) {
      emit(const PremiumStateInitial());
    } catch (e) {
      emit(PremiumLoadFailure(parseErrorMessageFrom(e)));
    }
  }

  Future<void> _showPremium() async {
    emit(const PremiumLoadInProgress());
    try {
      final hasPremium = await _premiumRepository.hasPremium();
      emit(PremiumLoadSuccess(hasPremium));
    } on UserCanceledException catch (_) {
      emit(const PremiumStateInitial());
    } catch (e) {
      emit(PremiumLoadFailure(parseErrorMessageFrom(e)));
    }
  }
}
