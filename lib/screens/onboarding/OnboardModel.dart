class OnboardModel {
  String? image, title, description;

  //constructor for variables
  OnboardModel({this.title, this.description, this.image});

  void setImage(String getImage) {
    image = getImage;
  }

  void setTitle(String getTitle) {
    title = getTitle;
  }

  void setDescription(String getDescription) {
    description = getDescription;
  }

  String getImage() {
    return image.toString();
  }

  String getTitle() {
    return title.toString();
  }

  String getDescription() {
    return description.toString();
  }
}

//List created
List<OnboardModel> getSlides() {
  List<OnboardModel> slides = [];
  OnboardModel sliderModel = OnboardModel();

  //item 1
  sliderModel.setImage("assets/images/drug.png");
  sliderModel.setTitle("Your Title");
  sliderModel.setDescription("Your description");
  slides.add(sliderModel);

  sliderModel = OnboardModel();
  //itme 2
  sliderModel.setImage("assets/images/pills.png");
  sliderModel.setTitle("Your Title");
  sliderModel.setDescription("Your description");
  slides.add(sliderModel);

  sliderModel = OnboardModel();
  return slides;
}
