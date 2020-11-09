class DNA {

  char[] genes;
  float fitness;

  //Gerar DNA aleatório.
  DNA() {
    genes = new char[target.length()];
    for (int i = 0; i < genes.length; i++) {
      genes[i] = (char) random(32,128);
    }
  }

  //Calcular função de fitness.
  float fitness() {
     int score = 0;
     for (int i = 0; i < genes.length; i++) {
        if (genes[i] == target.charAt(i)) {
          score++;
        }
     }
     fitness = float(score)/target.length();
     return fitness;
  }

  //Crossover
  DNA crossover(DNA partner) {
    DNA child = new DNA();
    int midpoint = int(random(genes.length));
    for (int i = 0; i < genes.length; i++) {
      if (i < midpoint) child.genes[i] = genes[i];
      else              child.genes[i] = partner.genes[i];
    }
    return child;
  }

  //Mutation
  void mutate(float mutationRate) {
    for (int i = 0; i < genes.length; i++) {
      if (random(1) < mutationRate) {
        genes[i] = (char) random(32,128);
      }
    }
  }

  //Converte o array de caracteres para o fenótipo (frase)
  String getPhrase() {
    return new String(genes);
  }

}