import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../screens/medical_policy_details_screen.dart';
import '../screens/policies_screen.dart';


enum CardDemoType {
  standard,
  tappable,
  selectable,
}
const String _kGalleryAssetsPackage = 'images';
class TravelDestination {
  const TravelDestination({
    @required this.assetName,
    @required this.assetPackage,
    @required this.title,
    @required this.description,
    @required this.city,
    @required this.location,
    this.type = CardDemoType.standard,
  })  : assert(assetName != null),
        assert(assetPackage != null),
        assert(title != null),
        assert(description != null),
        assert(city != null),
        assert(location != null);

  final String assetName;
  final String assetPackage;
  final String title;
  final String description;
  final String city;
  final String location;
  final CardDemoType type;
}

class TravelDestinationContent extends StatelessWidget {
  const TravelDestinationContent({Key key, @required this.destination})
      : assert(destination != null),
        super(key: key);

  final TravelDestination destination;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final titleStyle = theme.textTheme.headline5.copyWith(color: Colors.white);
    final descriptionStyle = theme.textTheme.subtitle1;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 184,
          child: Stack(
            children: [
              Positioned.fill(
                // In order to have the ink splash appear above the image, you
                // must use Ink.image. This allows the image to be painted as
                // part of the Material and display ink effects above it. Using
                // a standard Image will obscure the ink splash.
                child: Ink.image(
                  image: AssetImage(
                    destination.assetName,

                  ),
                  fit: BoxFit.cover,
                  child: Container(),
                ),
              ),
              Positioned(
                bottom: 16,
                left: 16,
                right: 16,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    destination.title,
                    style: titleStyle,
                  ),
                ),
              ),
            ],
          ),
        ),
        // Description and share/explore buttons.
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: DefaultTextStyle(
            softWrap: false,
            overflow: TextOverflow.ellipsis,
            style: descriptionStyle,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // This array contains the three line description on each card
                // demo.
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    destination.description,
                    style: descriptionStyle.copyWith(color: Colors.black54),
                  ),
                ),
                Text(destination.city),
                Text(destination.location),
              ],
            ),
          ),
        ),
        if (destination.type == CardDemoType.standard)
        // share, explore buttons
          ButtonBar(
            alignment: MainAxisAlignment.start,
            children: [
              FlatButton(
                child: Text('Share',
                    semanticsLabel: 'destination.title'),
                textColor: Colors.amber.shade500,
                onPressed: () {
                  print('pressed');
                },
              ),
              FlatButton(
                child: Text('Explore', semanticsLabel: 'destination.title'),
                textColor: Colors.amber.shade500,
                onPressed: () {
                  print('pressed');
                },
              ),
            ],
          ),
      ],
    );
  }
}


List<TravelDestination> destinations(BuildContext context) => [
  TravelDestination(
    assetName: 'images/places/india_thanjavur_market.png',
    assetPackage: _kGalleryAssetsPackage,
    title:        'cardsDemoTravelDestinationTitle1',
    description:   'cardsDemoTravelDestinationDescription1',
    city:         'cardsDemoTravelDestinationCity1',
    location:     'cardsDemoTravelDestinationLocation1',
  ),
  TravelDestination(
    assetName: 'images/places/india_chettinad_silk_maker.png',
    assetPackage: _kGalleryAssetsPackage,
    title:
    'cardsDemoTravelDestinationTitle2',
    description: 'cardsDemoTravelDestinationDescription2',
    city:   'cardsDemoTravelDestinationCity2',
    location: 'cardsDemoTravelDestinationLocation2',
    type: CardDemoType.tappable,
  ),
  TravelDestination(
    assetName: 'images/places/india_tanjore_thanjavur_temple.png',
    assetPackage: _kGalleryAssetsPackage,
    title:
    'cardsDemoTravelDestinationTitle3',
    description: 'cardsDemoTravelDestinationDescription3',
    city: 'cardsDemoTravelDestinationCity1',
    location: 'cardsDemoTravelDestinationLocation1',
    type: CardDemoType.selectable,
  ),
];


class TappableTravelDestinationItem extends StatelessWidget {
  const TappableTravelDestinationItem(
      {Key key, @required this.destination, this.shape})
      : assert(destination != null),
        super(key: key);

  // This height will allow for all the Card's content to fit comfortably within the card.
  static const height = 298.0;
  final TravelDestination destination;
  final ShapeBorder shape;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            SectionTitle(
                title:   destination.title),
            SizedBox(
              height: height,
              child: Card(
                // This ensures that the Card's children (including the ink splash) are clipped correctly.
                clipBehavior: Clip.antiAlias,
                shape: shape,
                child: InkWell(
                  onTap: () {


                    if(destination.location.contains('MD')) {
                      print('MD Card was tapped'+destination.city);
                      Navigator.of(context).pushNamed(
                        MedicalPolicyDetailsScreen.routeName,
                        arguments: destination.city,
                      );
                    }else{
                      print('Not MD Card was tapped'+destination.location);
                    }
                  },
                  // Generally, material cards use onSurface with 12% opacity for the pressed state.
                  splashColor:
                  Theme.of(context).colorScheme.onSurface.withOpacity(0.12),
                  // Generally, material cards do not have a highlight overlay.
                  highlightColor: Colors.transparent,
                  child: TravelDestinationContent(destination: destination),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    Key key,
    this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 4, 4, 12),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(title, style: Theme.of(context).textTheme.subtitle1),
      ),
    );
  }
}
