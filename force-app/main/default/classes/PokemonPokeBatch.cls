global class PokemonPokeBatch implements Database.Batchable<Integer>, Database.AllowsCallouts {
    global List <Integer> start(Database.BatchableContext bc) {

        List<Integer> indexList = new List<Integer>();
        for (Integer i = 1; i <= 1; i++) {
            indexList.add(i);
        }
        return indexList;
    }
    global void execute(Database.BatchableContext bc, List<Integer> indexList){

        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://pokeapi.co/api/v2/pokemon/' + indexList[0]);
        request.setMethod('GET');
        request.setHeader('Content-Type', 'application/json');
        HttpResponse response = http.send(request);

        if (response.getStatusCode() == 200) {
            Pokemon__c pokemon = new Pokemon__c();
            
            Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            pokemon.ExtId__c = (Integer)result.get('id');
            String UpperName = (String) result.get('name');
            pokemon.Name = UpperName.capitalize();
            pokemon.Heigth__c = (Integer)result.get('height');
            pokemon.Weigth__c = (Integer)result.get('weight');
            Map<String, Object> sprites = (Map<String, Object>)result.get('sprites');
            pokemon.Image__c = (String)sprites.get('front_default');
            
            List<Object> types = (List<Object>)result.get('types');
            System.debug(types.size());
            for (Integer i =0; i <= types.size() - 1; i++) {
                if (i == 0) {
                    Map<String, Object> typesPath = (Map<String, Object>)types[i];
                    Map<String, Object> type = (Map<String, Object>)typesPath.get('type');
                    pokemon.Types__c = (String)type.get('name') + ';';
                } else {
                    Map<String, Object> typesPath = (Map<String, Object>)types[i];
                    Map<String, Object> type = (Map<String, Object>)typesPath.get('type');
                    pokemon.Types__c = pokemon.Types__c + ';' + (String)type.get('name');
                }
                
            }

            List<Object> stats = (List<Object>)result.get('stats');
            for (Integer i =0; i <= stats.size() - 1; i++) {
                Map<String, Object> statsPath = (Map<String, Object>)stats[i];
                Map<String, Object> stat = (Map<String, Object>)statsPath.get('stat');
                String singleStat = (String)stat.get('name');
                if (singleStat == 'hp') {
                    pokemon.Hp__c = (Integer) statsPath.get('base_stat');
                } else if (singleStat == 'attack') {
                    pokemon.Attack__c = (Integer) statsPath.get('base_stat');
                }else if (singleStat == 'defense') {
                    pokemon.Defense__c = (Integer) statsPath.get('base_stat');
                }
                else if (singleStat == 'speed') {
                    pokemon.Speed__c = (Integer) statsPath.get('base_stat');
                }
                
            }

            List<Object> abilities = (List<Object>)result.get('abilities');
            if (abilities.size() == 1) {
                Map<String, Object> abilitiesPath = (Map<String, Object>)abilities[0];
                Map<String, Object> ability = (Map<String, Object>)abilitiesPath.get('ability');
                String UpperNameAbility = (String) ability.get('name');
                Abilities__c lookupAbility = [SELECT Id FROM Abilities__c WHERE Name = :UpperNameAbility];
                pokemon.Ability__c = lookupAbility.Id;
            } else {       
                Integer randomNum =(Math.random() > 0.5) ? 1 : 0;
                Map<String, Object> abilitiesPath = (Map<String, Object>)abilities[randomNum];                
                Map<String, Object> ability = (Map<String, Object>)abilitiesPath.get('ability');                
                String UpperNameAbility = (String) ability.get('name');
                Abilities__c lookupAbility = [SELECT Id FROM Abilities__c WHERE Name = 'shield-dust'];
                pokemon.Ability__c = lookupAbility.Id;
            }
            

            List<Object> moves = (List<Object>)result.get('moves');
            Integer movesIndex = moves.size() -1 <= 3 ? moves.size() : moves.size() -1 ;

            Integer roundCount = 0;
            if (movesIndex >= 4) {
                for (Integer n =0; n<= 3; n++) {
                    Integer randomMoveIndex = Math.round(Math.random() * movesIndex);
                    Map<String, Object> movesPath = (Map<String, Object>)moves[randomMoveIndex];
                    Map<String, Object> move = (Map<String, Object>)movesPath.get('move');
                    String UpperNameMoves = (String) move.get('name');
                    Moves__c lookupMove = [SELECT Id FROM Moves__c WHERE Name = :UpperNameMoves];

                    
                    if (roundCount == 0) {
                        pokemon.Slot1__c = lookupMove.Id;
                        roundCount++;
                    } else if (roundCount == 1) {
                        pokemon.Slot2__c = lookupMove.Id;
                        roundCount++;
                    } else if (roundCount == 2) {
                        pokemon.Slot3__c = lookupMove.Id;
                        roundCount++;
                    } else if (roundCount == 3) {
                        pokemon.Slot4__c = lookupMove.Id;
                        roundCount++;
                    }
                } 

            } else if (movesIndex == 3) {
                for (Integer n =0; n<= 2; n++) {
                    Integer randomMoveIndex = Math.round(Math.random() * movesIndex);
                    Map<String, Object> movesPath = (Map<String, Object>)moves[randomMoveIndex];
                    Map<String, Object> move = (Map<String, Object>)movesPath.get('move');
                    String UpperNameMoves = (String) move.get('name');
                    Moves__c lookupMove = [SELECT Id FROM Moves__c WHERE Name = :UpperNameMoves];

                    
                    if (roundCount == 0) {
                        pokemon.Slot1__c = lookupMove.Id;
                        roundCount++;
                    } else if (roundCount == 1) {
                        pokemon.Slot2__c = lookupMove.Id;
                        roundCount++;
                    } else if (roundCount == 2) {
                        pokemon.Slot3__c = lookupMove.Id;
                        roundCount++;
                    }
                } 
                
            }else if (movesIndex == 2) {
                for (Integer n =0; n<= 1; n++) {
                    Integer randomMoveIndex = Math.round(Math.random() * movesIndex);
                    Map<String, Object> movesPath = (Map<String, Object>)moves[randomMoveIndex];
                    Map<String, Object> move = (Map<String, Object>)movesPath.get('move');
                    String UpperNameMoves = (String) move.get('name');
                    Moves__c lookupMove = [SELECT Id FROM Moves__c WHERE Name = :UpperNameMoves];

                    
                    if (roundCount == 0) {
                        pokemon.Slot1__c = lookupMove.Id;
                        roundCount++;
                    } else if (roundCount == 1) {
                        pokemon.Slot2__c = lookupMove.Id;
                        roundCount++;
                    }
                } 
                
            }else if (movesIndex == 1) {
                for (Integer n =0; n<= 0; n++) {
                    Integer randomMoveIndex = Math.round(Math.random() * movesIndex);
                    Map<String, Object> movesPath = (Map<String, Object>)moves[randomMoveIndex];
                    Map<String, Object> move = (Map<String, Object>)movesPath.get('move');
                    String UpperNameMoves = (String) move.get('name');
                    Moves__c lookupMove = [SELECT Id FROM Moves__c WHERE Name = :UpperNameMoves];

                    
                    if (roundCount == 0) {
                        pokemon.Slot1__c = lookupMove.Id;
                        roundCount++;
                    }
                    }
                } 
                
                insert pokemon;         
            }

        else {
            System.debug(response.getStatusCode());

        }

    }
    global void finish(Database.BatchableContext bc){
        
    }
}