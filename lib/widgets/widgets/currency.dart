import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/app_cubit.dart';
import '../../helpers/currency.helper.dart';

class CurrencyText extends StatelessWidget {
  final double? amount;
  final TextStyle? style;
  final TextOverflow? overflow;
  final CurrencyService currencyService = CurrencyService();

  CurrencyText(this.amount, {Key? key, this.style, this.overflow})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        String currencyCode = state.currency ??
            'USD'; // Provide a default value if state.currency is null
        Currency? currency = currencyService.findByCode(currencyCode);
        return Text(
          amount == null
              ? "${currency?.symbol ?? ''} "
              : CurrencyHelper.format(
                  amount!,
                  name: currency?.code,
                  symbol: currency?.symbol,
                ),
          style: style,
          overflow: overflow,
        );
      },
    );
  }
}
