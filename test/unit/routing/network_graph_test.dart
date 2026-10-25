import 'package:flutter_test/flutter_test.dart';
import 'package:local_link/features/routing/domain/entities/network_graph.dart';
import 'package:local_link/features/timetable/domain/entities/station.dart';

void main() {
  group('RailwayNetworkGraph Topological Route Finding', () {
    late Station churchgate;
    late Station dadar;
    late Station borivali;
    late Station csmt;
    late Station thane;
    late Station kurla;
    late Station panvel;
    late RailwayNetworkGraph graph;

    setUp(() {
      churchgate = const Station(
        id: 'ST_CCG',
        code: 'CCG',
        nameEn: 'Churchgate',
        nameHi: 'चर्चगेट',
        nameMr: 'चर्चगेट',
        latitude: 18.9355,
        longitude: 72.8277,
        lines: [RailwayLineId.western],
      );

      dadar = const Station(
        id: 'ST_DDR',
        code: 'DDR',
        nameEn: 'Dadar',
        nameHi: 'दादर',
        nameMr: 'दादर',
        latitude: 19.0178,
        longitude: 72.8431,
        lines: [RailwayLineId.western, RailwayLineId.centralMain],
        isInterchange: true,
      );

      borivali = const Station(
        id: 'ST_BVI',
        code: 'BVI',
        nameEn: 'Borivali',
        nameHi: 'बोरीवली',
        nameMr: 'बोरिवली',
        latitude: 19.2290,
        longitude: 72.8574,
        lines: [RailwayLineId.western],
      );

      csmt = const Station(
        id: 'ST_CSMT',
        code: 'CSMT',
        nameEn: 'CSMT',
        nameHi: 'सीएसएमटी',
        nameMr: 'सीएसएमटी',
        latitude: 18.9400,
        longitude: 72.8354,
        lines: [RailwayLineId.centralMain, RailwayLineId.harbour],
        isInterchange: true,
      );

      kurla = const Station(
        id: 'ST_CLA',
        code: 'CLA',
        nameEn: 'Kurla',
        nameHi: 'कुर्ला',
        nameMr: 'कुर्ला',
        latitude: 19.0657,
        longitude: 72.8793,
        lines: [RailwayLineId.centralMain, RailwayLineId.harbour],
        isInterchange: true,
      );

      thane = const Station(
        id: 'ST_TNA',
        code: 'TNA',
        nameEn: 'Thane',
        nameHi: 'ठाणे',
        nameMr: 'ठाणे',
        latitude: 19.1860,
        longitude: 72.9757,
        lines: [RailwayLineId.centralMain],
      );

      panvel = const Station(
        id: 'ST_PNVL',
        code: 'PNVL',
        nameEn: 'Panvel',
        nameHi: 'पनवेल',
        nameMr: 'पनवेल',
        latitude: 18.9894,
        longitude: 73.1218,
        lines: [RailwayLineId.harbour],
      );

      graph = RailwayNetworkGraph([
        churchgate,
        dadar,
        borivali,
        csmt,
        kurla,
        thane,
        panvel,
      ]);
    });

    test('Finds direct topological route on Western Line', () {
      final routes = graph.findTopologicalRoutes(
        origin: churchgate,
        destination: borivali,
      );

      expect(routes.any((r) => r.isDirect), isTrue);
      final direct = routes.firstWhere((r) => r.isDirect);
      expect(direct.segments.first.line, RailwayLineId.western);
    });

    test(
      'Finds transfer route between Western and Central lines via Dadar',
      () {
        final routes = graph.findTopologicalRoutes(
          origin: borivali,
          destination: thane,
        );

        // Borivali (WR) to Thane (CR) must find transfer via Dadar
        final transferViaDadar = routes.where(
          (r) => !r.isDirect && r.transferStation?.code == 'DDR',
        );
        expect(transferViaDadar, isNotEmpty);

        final route = transferViaDadar.first;
        expect(route.segments.length, 2);
        expect(route.segments[0].line, RailwayLineId.western);
        expect(route.segments[1].line, RailwayLineId.centralMain);
      },
    );

    test(
      'Finds transfer route between Central and Harbour lines via Kurla',
      () {
        final routes = graph.findTopologicalRoutes(
          origin: thane,
          destination: panvel,
        );

        final transferViaKurla = routes.where(
          (r) => !r.isDirect && r.transferStation?.code == 'CLA',
        );
        expect(transferViaKurla, isNotEmpty);

        final route = transferViaKurla.first;
        expect(route.segments.length, 2);
        expect(route.segments[0].line, RailwayLineId.centralMain);
        expect(route.segments[1].line, RailwayLineId.harbour);
      },
    );

    test('Returns empty list when origin equals destination', () {
      final routes = graph.findTopologicalRoutes(
        origin: dadar,
        destination: dadar,
      );
      expect(routes, isEmpty);
    });
  });
}
