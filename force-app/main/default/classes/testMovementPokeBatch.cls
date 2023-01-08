@isTest

public with sharing class testMovementPokeBatch {

    public static testmethod void shouldNotReturnAApiResponse() {
        String responseExpected = '{"accuracy": 100, "effect_chance": 100, "effect_entries": [], "id": 999, "name": "test-move","power": 110,"pp": 10,"priority": 0, "target": {"name": "selected-pokemon", "url": "https://pokeapi.co/api/v2/move-target/10/"},"type": {"name": "electric","url": "https://pokeapi.co/api/v2/type/13/"}}';
        String verification;
        SingleRequestMock fakeResponse = new SingleRequestMock(400,
                                                 'Error',
                                                 responseExpected,
                                                 null);

		Test.setMock(HttpCalloutMock.class, fakeResponse);
        Test.startTest();
            Database.executeBatch(new movementPokeBatch(), 1);
        Test.stopTest();

        
        
        try {
            Moves__c verifyMove = [SELECT Id, Name, Type__c, Priority__c, Accuracy__c, Power__c, Target__c, Effect_chance__c, Effect__c, Pp__c, ExtId__c FROM Moves__c WHERE ExtId__c =  999];
            verification = 'La cuenta se encuentra disponible';             
        } catch (Exception e) {
            verification = e.getMessage();
        }
        
        System.assertNotEquals('La cuenta se encuentra disponible', verification, 'Las respuestas coinciden, la respuesta es: ' + verification);
        
    }


//- Que inserte el movimiento ok, con effect chance completo y short effect con contenido

    public static testmethod void shouldInsertMovesSuccesfullyWhitFullFields() {
        String responseExpected = '{"accuracy": 100,"effect_chance": 30,"effect_entries": [{"effect": "Inflicts regular damage.  User critical hit rate is one level higher when using this move.","language": {"name": "en","url": "https://pokeapi.co/api/v2/language/9/"},"short_effect": "Has an increased chance for a critical hit."}],"id": 999,"name": "test-move","power": 50,"pp": 25,"priority": 0,"target": {"name": "selected-pokemon","url": "https://pokeapi.co/api/v2/move-target/10/"},"type": {"name": "fighting","url": "https://pokeapi.co/api/v2/type/2/"}}';
        
        Moves__c verification = new Moves__c(ExtId__c = 999, Accuracy__c = 100, Priority__c = 0, Target__c = 'selected-pokemon', Power__c = 50, Pp__c = 25, Type__c = 'Fighting', Name = 'Test-move', Effect_chance__c = '30',Effect__c = 'Has an increased chance for a critical hit.', Id = null);
        SingleRequestMock fakeResponse = new SingleRequestMock(200,
                                                 'Ok',
                                                 responseExpected,
                                                 null);

		Test.setMock(HttpCalloutMock.class, fakeResponse);
        Test.startTest();
            Database.executeBatch(new movementPokeBatch(), 1);
        Test.stopTest();

        Moves__c verifyMove = [SELECT ExtId__c, Accuracy__c, Priority__c, Target__c, Power__c, Pp__c, Type__c, Name, Effect_chance__c, Effect__c FROM Moves__c WHERE ExtId__c =  999];
        verifyMove.Id = null;
        
        System.assertEquals(verification, verifyMove, 'Las respuestas no coinciden, la respuesta es: ' + verification);
        
    }

//- Que inserte el movimiento ok, con effect chance completo y short effect con no especificado
    
public static testmethod void shouldInsertMovesSuccesfullyWhitShortEffectFieldsIsNotSpecified() {
    String responseExpected = '{"accuracy": 100,"effect_chance": 30,"effect_entries": [] ,"id": 999,"name": "test-move","power": 50,"pp": 25,"priority": 0,"target": {"name": "selected-pokemon","url": "https://pokeapi.co/api/v2/move-target/10/"},"type": {"name": "fighting","url": "https://pokeapi.co/api/v2/type/2/"}}';
    
    Moves__c verification = new Moves__c(ExtId__c = 999, Accuracy__c = 100, Priority__c = 0, Target__c = 'selected-pokemon', Power__c = 50, Pp__c = 25, Type__c = 'Fighting', Name = 'Test-move', Effect_chance__c = '30',Effect__c = 'The effect is not specified', Id = null);
    SingleRequestMock fakeResponse = new SingleRequestMock(200,
                                             'Ok',
                                             responseExpected,
                                             null);

    Test.setMock(HttpCalloutMock.class, fakeResponse);
    Test.startTest();
        Database.executeBatch(new movementPokeBatch(), 1);
    Test.stopTest();

    Moves__c verifyMove = [SELECT ExtId__c, Accuracy__c, Priority__c, Target__c, Power__c, Pp__c, Type__c, Name, Effect_chance__c, Effect__c FROM Moves__c WHERE ExtId__c =  999];
    verifyMove.Id = null;
    
    System.assertEquals(verification, verifyMove, 'Las respuestas no coinciden, la respuesta es: ' + verification);
    
}

//- Que inserte el movimiento ok, con effect chance completo y short effect con null

public static testmethod void shouldInsertMovesSuccesfullyWhitShortEffectFieldsIsNull() {
    String responseExpected = '{"accuracy": 100,"effect_chance": 30,"effect_entries": [{"effect": "Inflicts regular damage.  User critical hit rate is one level higher when using this move.","language": {"name": "es","url": "https://pokeapi.co/api/v2/language/9/"},"short_effect": "Has an increased chance for a critical hit."}] ,"id": 999,"name": "test-move","power": 50,"pp": 25,"priority": 0,"target": {"name": "selected-pokemon","url": "https://pokeapi.co/api/v2/move-target/10/"},"type": {"name": "fighting","url": "https://pokeapi.co/api/v2/type/2/"}}';
    
    Moves__c verification = new Moves__c(ExtId__c = 999, Accuracy__c = 100, Priority__c = 0, Target__c = 'selected-pokemon', Power__c = 50, Pp__c = 25, Type__c = 'Fighting', Name = 'Test-move', Effect_chance__c = '30', Id = null);
    SingleRequestMock fakeResponse = new SingleRequestMock(200,
                                             'Ok',
                                             responseExpected,
                                             null);

    Test.setMock(HttpCalloutMock.class, fakeResponse);
    Test.startTest();
        Database.executeBatch(new movementPokeBatch(), 1);
    Test.stopTest();

    Moves__c verifyMove = [SELECT ExtId__c, Accuracy__c, Priority__c, Target__c, Power__c, Pp__c, Type__c, Name, Effect_chance__c, Effect__c FROM Moves__c WHERE ExtId__c =  999];
    verifyMove.Id = null;
    
    System.assertEquals(verification, verifyMove, 'Las respuestas no coinciden, la respuesta es: ' + verification);
    
}

//- Que inserte el movimiento ok, con effect chance sin efecto asociado y short effect con contenido

public static testmethod void shouldInsertMovesSuccesfullyWhitEffectChanceFieldIsNull() {
    String responseExpected = '{"accuracy": 100,"effect_chance": null,"effect_entries": [{"effect": "Inflicts regular damage.  User critical hit rate is one level higher when using this move.","language": {"name": "en","url": "https://pokeapi.co/api/v2/language/9/"},"short_effect": "Has an increased chance for a critical hit."}],"id": 999,"name": "test-move","power": 50,"pp": 25,"priority": 0,"target": {"name": "selected-pokemon","url": "https://pokeapi.co/api/v2/move-target/10/"},"type": {"name": "fighting","url": "https://pokeapi.co/api/v2/type/2/"}}';
    
    Moves__c verification = new Moves__c(ExtId__c = 999, Accuracy__c = 100, Priority__c = 0, Target__c = 'selected-pokemon', Power__c = 50, Pp__c = 25, Type__c = 'Fighting', Name = 'Test-move', Effect_chance__c = 'The move doesnt have an associated side effect.',Effect__c = 'Has an increased chance for a critical hit.', Id = null);
    SingleRequestMock fakeResponse = new SingleRequestMock(200,
                                             'Ok',
                                             responseExpected,
                                             null);

    Test.setMock(HttpCalloutMock.class, fakeResponse);
    Test.startTest();
        Database.executeBatch(new movementPokeBatch(), 1);
    Test.stopTest();

    Moves__c verifyMove = [SELECT ExtId__c, Accuracy__c, Priority__c, Target__c, Power__c, Pp__c, Type__c, Name, Effect_chance__c, Effect__c FROM Moves__c WHERE ExtId__c =  999];
    verifyMove.Id = null;
    
    System.assertEquals(verification, verifyMove, 'Las respuestas no coinciden, la respuesta es: ' + verification);
    
}

//- Que inserte el movimiento ok, con effect chance sin efecto asociado y short effect no especificado

public static testmethod void shouldInsertMovesSuccesfullyWhitShortEffectFieldsIsNotSpecifiedAndEffectChanceFieldIsNull() {
    String responseExpected = '{"accuracy": 100,"effect_chance": null,"effect_entries": [] ,"id": 999,"name": "test-move","power": 50,"pp": 25,"priority": 0,"target": {"name": "selected-pokemon","url": "https://pokeapi.co/api/v2/move-target/10/"},"type": {"name": "fighting","url": "https://pokeapi.co/api/v2/type/2/"}}';
    
    Moves__c verification = new Moves__c(ExtId__c = 999, Accuracy__c = 100, Priority__c = 0, Target__c = 'selected-pokemon', Power__c = 50, Pp__c = 25, Type__c = 'Fighting', Name = 'Test-move', Effect_chance__c = 'The move doesnt have an associated side effect.',Effect__c = 'The effect is not specified', Id = null);
    SingleRequestMock fakeResponse = new SingleRequestMock(200,
                                             'Ok',
                                             responseExpected,
                                             null);

    Test.setMock(HttpCalloutMock.class, fakeResponse);
    Test.startTest();
        Database.executeBatch(new movementPokeBatch(), 1);
    Test.stopTest();

    Moves__c verifyMove = [SELECT ExtId__c, Accuracy__c, Priority__c, Target__c, Power__c, Pp__c, Type__c, Name, Effect_chance__c, Effect__c FROM Moves__c WHERE ExtId__c =  999];
    verifyMove.Id = null;
    
    System.assertEquals(verification, verifyMove, 'Las respuestas no coinciden, la respuesta es: ' + verification);
    
}

//- Que inserte el movimiento ok, con effect chance sin efecto asociado y short effect null

public static testmethod void shouldInsertMovesSuccesfullyWhitShortEffectFieldsNullAndEffectChanceFieldIsNull() {
    String responseExpected = '{"accuracy": 100,"effect_chance": null,"effect_entries": [{"effect": "Inflicts regular damage.  User critical hit rate is one level higher when using this move.","language": {"name": "es","url": "https://pokeapi.co/api/v2/language/9/"},"short_effect": "Has an increased chance for a critical hit."}] ,"id": 999,"name": "test-move","power": 50,"pp": 25,"priority": 0,"target": {"name": "selected-pokemon","url": "https://pokeapi.co/api/v2/move-target/10/"},"type": {"name": "fighting","url": "https://pokeapi.co/api/v2/type/2/"}}';
    
    Moves__c verification = new Moves__c(ExtId__c = 999, Accuracy__c = 100, Priority__c = 0, Target__c = 'selected-pokemon', Power__c = 50, Pp__c = 25, Type__c = 'Fighting', Name = 'Test-move', Effect_chance__c = 'The move doesnt have an associated side effect.', Id = null);
    SingleRequestMock fakeResponse = new SingleRequestMock(200,
                                             'Ok',
                                             responseExpected,
                                             null);

    Test.setMock(HttpCalloutMock.class, fakeResponse);
    Test.startTest();
        Database.executeBatch(new movementPokeBatch(), 1);
    Test.stopTest();

    Moves__c verifyMove = [SELECT ExtId__c, Accuracy__c, Priority__c, Target__c, Power__c, Pp__c, Type__c, Name, Effect_chance__c, Effect__c FROM Moves__c WHERE ExtId__c =  999];
    verifyMove.Id = null;
    
    System.assertEquals(verification, verifyMove, 'Las respuestas no coinciden, la respuesta es: ' + verification);
    
}
}
