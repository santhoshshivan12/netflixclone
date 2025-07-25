
class OnBoardingEntity {
  final String image;
  final String title;
  final String description;

  OnBoardingEntity({
    required this.image,
    required this.title,
    required this.description,
  });

  static List<OnBoardingEntity> onBoardingData = [
    OnBoardingEntity(
      image: 'images/background.png',
      title: 'Enjoy on your TV',
      description: 'Watch on Smart TVs, PlayStation, Xbox, Chromecast, Apple TV, Blu-ray players, and more.',
    ),
    OnBoardingEntity(
      image: 'images/devices.png',
      title: 'Download your shows to watch offline',
      description: 'Save your favorites easily and always have something to watch.',
    ),
    OnBoardingEntity(
      image: 'images/download.png',
      title: 'Watch everywhere',
      description: 'Stream unlimited movies and TV shows on your phone, tablet, laptop, and TV.',
    ),
    OnBoardingEntity(
      image: 'images/contract.png',
      title: 'Create profiles for kids',
      description: 'Send kids on adventures with their favorite characters in a space made just for them—free with your membership.',
    ),
  ];
}