class QuizQuestion {
  // Constructor, joka ottaa vastaan datan
  const QuizQuestion(this.text, this.answers);

  // kaksi luokkamuuttujaa, kysymys ja lista vastauksia
  final String text;
  final List<String> answers;

  List<String> getShuffledAnswer() {
    final shuffledList = List.of(answers); // luodaan kopio
    shuffledList.shuffle(); // sekoitetaan kopio
    return shuffledList; // palautetaan kopio
  }
}
