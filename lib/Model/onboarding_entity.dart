
class OnBoardingEntity{
  final String image;
  final String heading;
  final String description;

  OnBoardingEntity({required this.image, required this.heading, required this.description});

  static List<OnBoardingEntity> onBoardingData=[
    OnBoardingEntity(
        image: 'images/devices.png',
        description: "Stream on your phone tablet, laptop,and TV without paying more.",
        heading: "Watch Everywhere"
    ),
    OnBoardingEntity(
        image: 'images/download.png',
        description: "Always have something to watch.",
        heading: "Download and\n Watch offline"
    ),
    OnBoardingEntity(
        image: 'images/contract.png',
        description: "Join today, no reason to wait",
        heading: "Cancel online at\n any time"
    ),
    OnBoardingEntity(
        image: 'images/background.png',
        description: "All of Netflix, starting at just 199.",
        heading: "Unlimited\n entertainment,\n one low price"
    ),
  ];
}