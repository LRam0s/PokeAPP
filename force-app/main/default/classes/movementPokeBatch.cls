global class movementPokeBatch implements Database.Batchable<Integer>, Database.AllowsCallouts {
    global List <Integer> start(Database.BatchableContext bc) {

        List<Integer> indexList = new List<Integer>();
        for (Integer i = 1; i <= 826; i++) {
            indexList.add(i);
        }
        return indexList;
    }
    global void execute(Database.BatchableContext bc, List<Integer> indexList){

        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://pokeapi.co/api/v2/move/' + indexList[0]);
        request.setMethod('GET');
        request.setHeader('Content-Type', 'application/json');
        HttpResponse response = http.send(request);

        if (response.getStatusCode() == 200) {
            Moves__c movement = new Moves__c();

            Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            movement.ExtId__c = (Integer)result.get('id');
            movement.Accuracy__c = (Integer)result.get('accuracy');
            movement.Priority__c = (Integer)result.get('priority');
            Map<String, Object> target = (Map<String, Object>)result.get('target');
            movement.Target__c = (String)target.get('name');
            movement.Power__c = (Integer)result.get('power');
            movement.Pp__c = (Integer)result.get('pp');
            Map<String, Object> type = (Map<String, Object>)result.get('type');
            movement.Type__c = (String)type.get('name');
            String UpperName = (String) result.get('name');
            movement.Name = UpperName.toUppercase().substring(0,1) + UpperName.substring(1);
            if (result.get('effect_chance') == null) {
                movement.Effect_chance__c = 'The move doesnt have an associated side effect.';
            } else {
                Integer effectNumber = (Integer)result.get('effect_chance');
                String effectStr = String.valueOf(effectNumber);
                movement.Effect_chance__c = effectStr;
            }

            List<Object> effect = (List<Object>)result.get('effect_entries');
            if (effect.isEmpty()) {
                movement.Effect__c = 'The effect is not specified';
            } else {
                Map<String, Object> effectPath = (Map<String, Object>)effect[0];
                Map<String, Object> language = (Map<String, Object>)effectPath.get('language');

                if (language.get('name') == 'en') {
                    movement.Effect__c = (String) effectPath.get('short_effect');
                } else {
                    movement.Effect__c = null;
                }
            }
            
            insert movement;         
        }else {
            System.debug(response.getStatusCode());

        }

    }
    global void finish(Database.BatchableContext bc){
        
    }
}