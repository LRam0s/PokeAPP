public with sharing class getAllPokemon {
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
    
    @AuraEnabled(Cacheable=true scope='global')
    public static List <Pokemon__c> searchPokemon(String pokemonName){
        pokemonName = pokemonName.trim();
        if (pokemonName == '') { 
            return getAllPokemon();
        }
            pokemonName = '%' + pokemonName + '%';
            return [SELECT ExtId__c, Name, Types__c, Image__c, Generation__c FROM Pokemon__c WHERE Name LIKE :pokemonName ORDER BY ExtId__c ASC];
    }

    @AuraEnabled (Cacheable=true scope ='global')
    public static List <Pokemon__c> filterPicklist (Integer generation, String type, String type2){
        if (generation == 0 && type == '') { 
            return getAllPokemon();
        }else if (generation != 0 && type == '') {
            return [SELECT ExtId__c, Name, Types__c, Image__c, Generation__c FROM Pokemon__c WHERE Generation__c = :generation ORDER BY ExtId__c ASC];
        } else if (generation == 0 && type != '') {
            String searchType = getTypePokemon(type, type2);
            return [SELECT ExtId__c, Name, Types__c, Image__c, Generation__c FROM Pokemon__c WHERE Types__c =:searchType ORDER BY ExtId__c ASC];
        }
            String searchType = getTypePokemon(type, type2);
            return [SELECT ExtId__c, Name, Types__c, Image__c, Generation__c FROM Pokemon__c WHERE Generation__c = :generation AND Types__c =:searchType ORDER BY ExtId__c ASC];
    }
}