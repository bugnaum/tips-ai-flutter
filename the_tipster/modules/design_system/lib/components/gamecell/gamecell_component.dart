import 'package:cached_network_image/cached_network_image.dart';
import 'package:design_system/theme/the_tipster_theme.dart';
import 'package:flutter/material.dart';

class GameCellComponentDTO {
  final String? round;
  final String? date;
  final String? home;
  final String? homeId;
  final String? away;
  final String? awayId;
  final String? homeImageUrl;
  final String? awayImageUrl;
  final String? localName;
  final String? fixtureId;
  final bool? tipsAvailable;
  final bool? canListenTip;

  GameCellComponentDTO({
    required this.round,
    required this.date,
    required this.home,
    required this.homeId,
    required this.away,
    required this.awayId,
    required this.homeImageUrl,
    required this.awayImageUrl,
    required this.localName,
    required this.fixtureId,
    required this.tipsAvailable,
    required this.canListenTip,
  });

  factory GameCellComponentDTO.fromJson(Map<String, dynamic> json) {
    return GameCellComponentDTO(
      round: json['round'],
      date: json['date'],
      home: json['home'],
      homeId: json['homeId'],
      away: json['away'],
      awayId: json['awayId'],
      homeImageUrl: json['homeImageUrl'],
      awayImageUrl: json['awayImageUrl'],
      localName: json['localName'],
      fixtureId: json['fixtureId'],
      tipsAvailable: json['tipsAvailable'],
      canListenTip: json['canListenTip'],
    );
  }
}

class GameCellComponent extends StatelessWidget {
  final GameCellComponentDTO dtoElement;

  const GameCellComponent({
    super.key,
    required this.dtoElement,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
              child: Container(
                width: 371,
                height: 98,
                decoration: BoxDecoration(
                  color: AppTheme.of().secondaryBackground,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: AppTheme.of().primary,
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Container(
                            width: 100,
                            height: 34,
                            decoration: BoxDecoration(
                              color: AppTheme.of().secondaryBackground,
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(0),
                                bottomRight: Radius.circular(0),
                                topLeft: Radius.circular(8),
                                topRight: Radius.circular(8),
                              ),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 16, 0, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(16, 0, 4, 1),
                                        child: Text(
                                          dtoElement.date ?? '',
                                          style: AppTheme.of()
                                              .titleSmall
                                              .override(
                                                fontFamily: 'Montserrat',
                                                color:
                                                    AppTheme.of().secondaryText,
                                                fontSize: 12,
                                                letterSpacing: 0,
                                                fontWeight: FontWeight.normal,
                                              ),
                                        ),
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(0, 0, 0, 1),
                                            child: Text(
                                              'Tipster.AI',
                                              style: AppTheme.of()
                                                  .titleSmall
                                                  .override(
                                                    fontFamily: 'Montserrat',
                                                    color:
                                                        AppTheme.of().primary,
                                                    fontSize: 12,
                                                    letterSpacing: 0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(4, 0, 12, 0),
                                            child: Icon(
                                              Icons.auto_awesome_outlined,
                                              color: AppTheme.of().primary,
                                              size: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 34,
                              height: 34,
                              clipBehavior: Clip.antiAlias,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: CachedNetworkImage(
                                imageUrl: dtoElement.homeImageUrl ?? '',
                                fit: BoxFit.cover,
                                maxHeightDiskCache: 500,
                                maxWidthDiskCache: 500,
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    12, 0, 0, 0),
                                child: Text(
                                  dtoElement.home ?? '',
                                  style: AppTheme.of().bodyLarge.override(
                                        fontFamily: 'Montserrat',
                                        fontSize: 14,
                                        letterSpacing: 0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                'vs',
                                textAlign: TextAlign.center,
                                style: AppTheme.of().bodyLarge.override(
                                      fontFamily: 'Montserrat',
                                      color: AppTheme.of().secondaryText,
                                      fontSize: 12,
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.normal,
                                    ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
                                child: Text(
                                  dtoElement.away ?? '',
                                  textAlign: TextAlign.end,
                                  style: AppTheme.of().bodyLarge.override(
                                        fontFamily: 'Montserrat',
                                        fontSize: 14,
                                        letterSpacing: 0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                              ),
                            ),
                            Container(
                              width: 34,
                              height: 34,
                              clipBehavior: Clip.antiAlias,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: CachedNetworkImage(
                                imageUrl: dtoElement.awayImageUrl ?? '',
                                fit: BoxFit.cover,
                                maxHeightDiskCache: 500,
                                maxWidthDiskCache: 500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
