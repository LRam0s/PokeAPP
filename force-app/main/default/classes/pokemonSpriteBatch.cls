global class pokemonSpriteBatch implements Database.Batchable<Integer>, Database.AllowsCallouts {
    global List <Integer> start(Database.BatchableContext bc) {

        List<Integer> indexList = new List<Integer>();
        for (Integer i = 1; i <= 898; i++) {
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

            Pokemon__c pokemon = [SELECT Name, ExtId__c, Sprite__c  FROM Pokemon__c WHERE ExtId__c = :indexList[0]];
            Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            Map<String, Object> spritesDetail = (Map<String, Object>)result.get('sprites');
            Map<String, Object> spritesOther = (Map<String, Object>)spritesDetail.get('other');
            Map<String, Object> spritesHome = (Map<String, Object>)spritesOther.get('home');
            String sprite = (String)spritesHome.get('front_default');
            System.debug(sprite);

            if (sprite == 'null') {
                String replaceSprite = (String)spritesDetail.get('front_default');
                pokemon.Sprite__c = replaceSprite;
            } else {
                pokemon.Sprite__c = sprite;
                
            }
            upsert pokemon;

            }

        else {
            System.debug(response.getStatusCode());

        }

    }
    global void finish(Database.BatchableContext bc){
        
    }
}