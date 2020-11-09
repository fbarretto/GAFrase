float mutationRate = 0.01;
int totalPopulation = 150;
DNA[] population;
ArrayList<DNA> matingPool;
String target;
int numGenerations = 0;
float bestFitness;
int bestPhrase;

void setup() {
  size(640, 360);

  //inicializa a frase objetivo
  target = "to be or not to be";

  //Passo 1: inicializa a população
  population = new DNA[totalPopulation];
  for (int i = 0; i < population.length; i++) {
    population[i] = new DNA();
  }
}

void draw() {


  bestFitness = population[0].fitness();
  bestPhrase = 0;

  // Passo 2: Calcular a função de Fitness
  for (int i = 0; i < population.length; i++) {
    if (population[i].fitness()>bestFitness) {
      bestFitness=population[i].fitness;
      bestPhrase = i;
      if (bestFitness==1) {
        exit();
      }
    }
  }

  print(numGenerations + " - " + bestFitness + " ");
  println(population[bestPhrase].getPhrase());
  numGenerations++;

  // Passo 2a: Listar os pais candidatos
  ArrayList<DNA> matingPool = new ArrayList<DNA>();

  for (int i = 0; i < population.length; i++) {
    //Adicionar cada membro "n" vezes de acordo com a sua função de fitness
    int n = int(population[i].fitness * 100);
    for (int j = 0; j < n; j++) {
      matingPool.add(population[i]);
    }
  }

  // Passo 3: Reprodução
  for (int i = 0; i < population.length; i++) {
    int a = int(random(matingPool.size()));
    int b = int(random(matingPool.size()));
    DNA partnerA = matingPool.get(a);
    DNA partnerB = matingPool.get(b);
    // Passo 3a: Crossover
    DNA child = partnerA.crossover(partnerB);
    // Passo 3b: Mutation
    child.mutate(mutationRate);

    //Sobrescreve a população antiga
    population[i] = child;
  }
}
