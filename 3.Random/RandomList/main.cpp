#include <iostream>
#include <random>
#include <fstream>
#define length(x) (sizeof(x)/sizeof(x[0]))
using namespace std;

int main(){

    std::random_device generator;
    std::uniform_int_distribution <int> dist(-2147483648, 2147483647);          //Rango 32b
    int filelines = 100000;
    int list[filelines];
    int candidato;
    bool found = false;

    for(int i = 0;i < filelines;i++){                                          //llenado array
      candidato = dist(generator);
      found = false;

      for(int e = 0;!found && e < filelines;e++){
        if(list[e] == candidato) found = true;                          //comprobacion repeticion
      }
      if(!found) list[i] = candidato;                                   //si no lo ha encontrado lo mete en el array
      else i--;                                                         //si lo encontró vuelve a llenar la misma posición
    }

    ofstream file;                                                      //salida a archivo de texto
    file.open("./RandomList.txt");
        for(int i = 0;i<filelines;i++){
        file << list[i] << "\n";
    }

    return 0;
}

/*
    El generador de números no genera una lista aleatoria.
    En cada ejecución repite el mismo set aunque supuestamente esta es la mejor forma de generar números aleatorios.
*/
