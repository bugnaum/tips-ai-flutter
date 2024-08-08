import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:design_system/theme/the_tipster_theme.dart';
import 'package:flutter/material.dart';

class CardPageControlComponentDTO {
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

  CardPageControlComponentDTO({
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

  factory CardPageControlComponentDTO.fromJson(Map<String, dynamic> json) {
    return CardPageControlComponentDTO(
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

class CardPageControlComponent extends StatelessWidget {
  final List<CardPageControlComponentDTO> dtoList;

  const CardPageControlComponent({
    super.key,
    required this.dtoList,
  });

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: [
        ...dtoList.map((element) {
          return InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.only(left: 6, right: 6),
              child: _buildCard(element),
            ),
          );
        })
      ],
      options: CarouselOptions(
        height: 220,
        autoPlay: true,
        enlargeCenterPage: true,
        enlargeFactor: 0.2,
        viewportFraction: 0.9,
      ),
    );
  }

  Widget _buildCard(CardPageControlComponentDTO elementDTO) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 8,
        bottom: 8,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.of().secondaryBackground,
          image: const DecorationImage(
            fit: BoxFit.cover,
            image: CachedNetworkImageProvider(
              'https://img.freepik.com/fotos-gratis/estadio-de-futebol-cheio-de-gente_23-2151548595.jpg?t=st=1722564181~exp=1722567781~hmac=9f56594f6ad816c2401699445bb119eac310587961cf53b17c8fa9d57c13535b&w=1800',
            ),
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              blurRadius: 4,
              color: AppTheme.of().primary,
              offset: const Offset(
                0,
                0,
              ),
              spreadRadius: 2,
            )
          ],
        ),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0x00004BD8),
                    AppTheme.of().primaryBackground
                  ],
                  stops: const [0, 1],
                  begin: const AlignmentDirectional(0, -1),
                  end: const AlignmentDirectional(0, 1),
                ),
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            Row(
              children: [
                _buildTeamColumn(
                  elementDTO.home ?? '',
                  elementDTO.homeImageUrl,
                ),
                Text(
                  "vs",
                  style: AppTheme.of().titleMedium,
                ),
                _buildTeamColumn(
                  elementDTO.away ?? '',
                  elementDTO.awayImageUrl,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 6,
              ),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 24,
                  color: Colors.transparent,
                  child: Center(
                    child: Text(
                      elementDTO.date ?? '',
                      textAlign: TextAlign.center,
                      style: AppTheme.of().titleSmall,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTeamColumn(String team, String? imageUrl) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 64,
            width: 64,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(50),
              image: imageUrl != null && imageUrl.isNotEmpty
                  ? DecorationImage(
                      fit: BoxFit.cover,
                      image: CachedNetworkImageProvider(
                        imageUrl,
                      ),
                    )
                  : null,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 12,
            ),
            child: Text(
              team,
              textAlign: TextAlign.center,
              style: AppTheme.of().titleMedium,
            ),
          ),
        ],
      ),
    );
  }
}
