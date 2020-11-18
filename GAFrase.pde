//ALTERE OS PARÂMETROS AQUI:
//Taxa de Mutação:
float mutationRate = 0.00;

//Tamanho da população:
int totalPopulation = 20;

//Tipo de crossover
//1 = aleatório | 2 = 50/50
int tipoCrossover = 2;

//Tipo de calculo de fitness
//1 = fitness normalizado | 2 = fitness normalizado ao quadrado
int tipoFitness = 1;

DNA[] population;
ArrayList<DNA> matingPool;
String target;
int numGenerations = 0;
float bestFitness;
int bestPhrase;
float totalFitness = 0;

void setup() {
  frameRate(2000);
  size(400, 200);

  //inicializa a frase objetivo
  target = "to be or not to be";

  //Passo 1: inicializa a população
  population = new DNA[totalPopulation];
  for (int i = 0; i < population.length; i++) {
    population[i] = new DNA();
  }
}

void draw() {
  background(0);

  bestFitness = population[0].fitness();
  bestPhrase = 0;
  totalFitness = 0;
  
  // Passo 2: Calcular a função de Fitness
  for (int i = 0; i < population.length; i++) {
    float pFitness = population[i].fitness();
    totalFitness += pFitness;
    if (pFitness>bestFitness) {
      bestFitness=pFitness;
      bestPhrase = i;
      if (bestFitness==1) {
        noLoop();
      }
    }
  }

  textSize(14); 
  text("Geração: " + numGenerations, 20, 20);
  text("Melhor Fitness: " + bestFitness, 20, 40);
  text("Média Fitness: " + totalFitness/population.length, 20, 60);
  text("População: " + totalPopulation, 20, 80);
  text("Mutação: " + mutationRate*100 + "%", 20, 100);
  textSize(20); 
  text("Melhor: \n" + population[bestPhrase].getPhrase(), 20, 140);

  numGenerations++;

  // Passo 2a: Listar os pais candidatos
  ArrayList<DNA> matingPool = new ArrayList<DNA>();

  for (int i = 0; i < population.length; i++) {
    //Adicionar cada membro "n" vezes de acordo com a sua função de fitness
    int n = int(population[i].fitness/bestFitness * 100.0);
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
