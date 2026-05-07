import 'package:flutter/material.dart';
import 'package:food_scan/config/constants/colors.dart';

enum NutriScore {
  a('A', Color(AppColors.nutriScoreA)),
  b('B', Color(AppColors.nutriScoreB)),
  c('C', Color(AppColors.nutriScoreC)),
  d('D', Color(AppColors.nutriScoreD)),
  e('E', Color(AppColors.nutriScoreE));

  final String letter;
  final Color color;

  const NutriScore(this.letter, this.color);
}
