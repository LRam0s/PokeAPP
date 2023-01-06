@isTest

public with sharing class testMovementPokeBatch {

    public static testmethod void shouldNotReturnAApiResponse() {
        String responseExpected = '{"accuracy": 100, "effect_chance": 100, "effect_entries": [], "id": 999, "name": "test-move","power": 110,"pp": 10,"priority": 0, "target": {"name": "selected-pokemon", "url": "https://pokeapi.co/api/v2/move-target/10/"},"type": {"name": "electric","url": "https://pokeapi.co/api/v2/type/13/"}}';
        SingleRequestMock fakeResponse = new SingleRequestMock(400,
                                                 'Error',
                                                 responseExpected,
                                                 null);

		Test.setMock(HttpCalloutMock.class, fakeResponse);
        Test.startTest();
            Database.executeBatch(new movementPokeBatch(), 1);
        Test.stopTest();


        /* Ver como igualarlo cuando no lo inserta, ya que al no entrar a la api no existe y por ende no me trae resultados, capaz con un .length pero no se. 
        Al no encontrarlo da una excepcion y no llega al assert
        Si lo cambio al modo positivo funciona ok, por ende vamos por buen camino */
        Moves__c verifyMove = [SELECT Id, Name, Type__c, Priority__c, Accuracy__c, Power__c, Target__c, Effect_chance__c, Effect__c, Pp__c, ExtId__c FROM Moves__c WHERE ExtId__c =  999];
        
        System.assertNotEquals(999, verifyMove.ExtId__c, 'Las respuestas coinciden, la respuesta es: ' + verifyMove);
        
    }
}
