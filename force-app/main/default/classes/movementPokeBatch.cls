global class movementPokeBatch implements Database.Batchable<Integer> {
    global List <Integer> start(Database.BatchableContext bc) {
        // collect the batches of records or objects to be passed to execute
        /* El numero de movimientos que hay que poner es de 826, dejo 10 para que cuando lo pruebe no explote la org */
        List<Integer> index = new List<Integer>();
        for (Integer i = 1; i <= 10; i++) {
            index.add(i);
        }
        system.debug(index.size());
        return index;
    }
    global void execute(Database.BatchableContext bc, List<Integer> indexList){
        system.debug(indexList[0]);
/* En esta parte deberia estar la llamada a la api, agregar una variable que convierta el integer en string y agregarlo al endpoint al final, mapear el resultado, crear la cuenta, y agregarla. Ver si tengo que agregar un if 
else para ver si trae resultado, si trae resultado cargarlo y sino cargar un string vacio */
        // process each batch of records
    }
    global void finish(Database.BatchableContext bc){
        // execute any post-processing operations
    }
}