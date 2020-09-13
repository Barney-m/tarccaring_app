import 'package:tarccaring_app/router/constant_route.dart';

class FeedbackTypes {
  final int id;
  final String type, description;
  String image;
  String path;

  FeedbackTypes({this.id, this.type, this.description, this.image, this.path});
  FeedbackTypes.withoutImage({this.id, this.type, this.description});
  FeedbackTypes.withoutPath({this.id, this.type, this.description, this.image});
}

List<FeedbackTypes> type = [
  FeedbackTypes(
    id: 1,
    type: 'Campus Facility Feedback',
    description: 'Feedback for Campus Facilities',
    image: 'assets/images/svg/campus facilities.svg',
    path: CampusFacilitiesRoute,
  ),
  FeedbackTypes(
    id: 2,
    type: 'Canteen Food Feedback',
    description: 'Feedback for Canteen Food',
    image: '',
    path: CanteenFoodRoute,
  ),
  FeedbackTypes(
    id: 3,
    type: 'Education Quality Feedback',
    description: 'Feedback for Education Quality',
    image: '',
    path: EducationQualityRoute,
  ),
  FeedbackTypes(
    id: 4,
    type: 'Service Attitude Feedback',
    description: 'Feedback for Service Attitude',
    image: '',
    path: ServiceAttitudeRoute,
  ),
];
