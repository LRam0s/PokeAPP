global class AbilityPokeBatch implements Database.Batchable<Integer>, Database.AllowsCallouts {
    global List <Integer> start(Database.BatchableContext bc) {

        List<Integer> indexList = new List<Integer>();
        for (Integer i = 1; i <= 267; i++) {
            indexList.add(i);
        }
        return indexList;
    }
    global void execute(Database.BatchableContext bc, List<Integer> indexList){

        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://pokeapi.co/api/v2/ability/' + indexList[0]);
        request.setMethod('GET');
        request.setHeader('Content-Type', 'application/json');
        HttpResponse response = http.send(request);


        if (response.getStatusCode() == 200) {
            Abilities__c ability = new Abilities__c();
            Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());

            ability.ExtId__c = (Integer)result.get('id');
            String UpperName = (String) result.get('name');
            ability.Name = UpperName.toUppercase().substring(0,1) + UpperName.substring(1);

            List<Object> effect = (List<Object>)result.get('effect_entries');
            if (effect.isEmpty()) {
                ability.Effect__c = 'The effect is not specified';
            } else {

                for (Integer i =0; i <= effect.size() - 1; i++) {
                    Map<String, Object> effectPath = (Map<String, Object>)effect[i];
                    Map<String, Object> language = (Map<String, Object>)effectPath.get('language');
                    if (language.get('name') == 'en') {
                        ability.Effect__c = (String) effectPath.get('short_effect');
                        break;
                    } else {
                        ability.Effect__c = null;
                    }
                    
                }
                


            }
            insert ability;         
        }else {
            System.debug(response.getStatusCode());

        }

    }
    global void finish(Database.BatchableContext bc){
        
    }
}