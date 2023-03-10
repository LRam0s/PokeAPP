public with sharing class getAllPokemon {
    @AuraEnabled(Cacheable=true scope='global')
    public static Pokemon__c getPokemonDetail(String pokemonId) {
        return [SELECT ExtId__c, Name, Types__c, Image__c,Sprite__c, Generation__c, Hp__c, Attack__c, Defense__c, Speed__c, Heigth__c, Weigth__c, Slot1__c, Slot2__c, Slot3__c, Slot4__c, Ability__c FROM Pokemon__c WHERE Id = :pokemonId ];

    }
    @AuraEnabled(Cacheable=true scope='global')
    public static Abilities__c getAbility(String abilityId) {
        return [SELECT Name, Effect__c, ExtId__c FROM Abilities__c WHERE Id = :abilityId ];

    }
    @AuraEnabled(Cacheable=true scope='global')
    public static Moves__c getSlot(String moveId) {
        return [SELECT Name, Accuracy__c, Effect__c, Effect_chance__c, ExtId__c, Power__c, Pp__c, Priority__c, Target__c, Type__c FROM Moves__c WHERE Id = :moveId ];

    }

    @AuraEnabled(Cacheable=true scope='global')
    public static List <Pokemon__c> getAllPokemon() {
        return [SELECT ExtId__c, Name, Types__c, Image__c, Generation__c FROM Pokemon__c ORDER BY ExtId__c ASC];
    }
    @AuraEnabled(Cacheable=true scope='global')
    public static String getTypePokemon(String type, String type2) {
        String searchType;
        String myType = type;
        String myType2 = type2;

        if (myType != '') {
            if (myType != '' && myType2 != '') {
                searchType = myType + ';' + myType2;
            return searchType;
            }
            searchType = myType;
            return searchType;
        }
        return searchType;
    }
    
    @AuraEnabled (Cacheable=true scope ='global')
    public static List <Pokemon__c> filterComplete (String pokemonName, Integer generation, String type, String type2){
        if (pokemonName == '' && generation == 0 && type == '') { 
            return getAllPokemon();
        }else if (pokemonName == '' && generation != 0 && type == '') {
            return [SELECT ExtId__c, Name, Types__c, Image__c, Generation__c FROM Pokemon__c WHERE Generation__c = :generation ORDER BY ExtId__c ASC];
        } else if (pokemonName == '' && generation == 0 && type != '') {
            String searchType = getTypePokemon(type, type2);
            return [SELECT ExtId__c, Name, Types__c, Image__c, Generation__c FROM Pokemon__c WHERE Types__c INCLUDES (:searchType) ORDER BY ExtId__c ASC];
        } else if (pokemonName != '' && generation == 0 && type == '') {
            pokemonName = '%' + pokemonName + '%';
            return [SELECT ExtId__c, Name, Types__c, Image__c, Generation__c FROM Pokemon__c WHERE Name LIKE :pokemonName ORDER BY ExtId__c ASC];
        } else if (pokemonName != '' && generation != 0 && type == '') {
            pokemonName = '%' + pokemonName + '%';
            return [SELECT ExtId__c, Name, Types__c, Image__c, Generation__c FROM Pokemon__c WHERE Name LIKE :pokemonName AND Generation__c =:generation ORDER BY ExtId__c ASC];
        } else if (pokemonName != '' && generation == 0 && type != '') {
            pokemonName = '%' + pokemonName + '%';
            String searchType = getTypePokemon(type, type2);
            return [SELECT ExtId__c, Name, Types__c, Image__c, Generation__c FROM Pokemon__c WHERE Name LIKE :pokemonName AND Types__c INCLUDES (:searchType) ORDER BY ExtId__c ASC];
        } 



        pokemonName = '%' + pokemonName + '%';
            String searchType = getTypePokemon(type, type2);
            return [SELECT ExtId__c, Name, Types__c, Image__c, Generation__c FROM Pokemon__c WHERE Name LIKE :pokemonName AND Generation__c = :generation AND Types__c INCLUDES (:searchType) ORDER BY ExtId__c ASC];
    }



}