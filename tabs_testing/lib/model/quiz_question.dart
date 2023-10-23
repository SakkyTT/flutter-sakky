class QuizQuestion {
  // Constructor, joka ottaa vastaan datan
  const QuizQuestion(this.text, this.answers);

  // kaksi luokkamuuttujaa, kysymys ja lista vastauksia
  final String text;
  final List<String> answers;

  // Muokkaa tähän getter syntaksi ja muokkaa muut koodit tarvittavalla tavalla

  List<String> get shuffledAnswer {
    final shuffledList = List.of(answers); // luodaan kopio
    shuffledList.shuffle(); // sekoitetaan kopio
    return shuffledList; // palautetaan kopio
  }
}
