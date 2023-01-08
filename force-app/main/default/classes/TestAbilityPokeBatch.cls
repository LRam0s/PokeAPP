@IsTest

public with sharing class TestAbilityPokeBatch {
    public static testmethod void shouldNotReturnAApiResponse() {
        String responseExpected = '{"effect_entries": [{"effect": "Das weather ändert sich zu rain wenn ein Pokémon mit dieser Fähigkeit den Kampf betritt. Dieser Effekt ist dauerhaft bis das weather geändert wird.\n\nWenn mehrere Pokémon mit dieser Fähigkeit, drought, sand stream oder snow warning zur selben Zeit den Kampf betreten, werden die Fähigkeiten nach Reihenfolge der speed der Pokémon ausgelöst, unter Berücksichtigung von trick room.","language": {"name": "de","url": "https://pokeapi.co/api/v2/language/6/"},"short_effect": "Ändert beim Betreten des Kampfes das weather in rain."},{"effect": "The weather changes to rain when this Pokémon enters battle and does not end unless replaced by another weather condition.\n\nIf multiple Pokémon with this ability, drought, sand stream, or snow warning are sent out at the same time, the abilities will activate in order of Speed, respecting trick room.  Each ability weather will cancel the previous weather, and only the weather summoned by the slowest of the Pokémon will stay.","language": {"name": "en","url": "https://pokeapi.co/api/v2/language/9/"},"short_effect": "Summons rain that lasts indefinitely upon entering battle."}],"id": 999,"name": "drizzle"}';
        String verification;
        SingleRequestMock fakeResponse = new SingleRequestMock(400,
                                                 'Error',
                                                 responseExpected,
                                                 null);

		Test.setMock(HttpCalloutMock.class, fakeResponse);
        Test.startTest();
            Database.executeBatch(new AbilityPokeBatch(), 1);
        Test.stopTest();

        
        
        try {
            Abilities__c verifyMove = [SELECT Name, Effect__c, ExtId__c FROM Abilities__c WHERE ExtId__c =  999];
            verification = 'La cuenta se encuentra disponible';             
        } catch (Exception e) {
            verification = e.getMessage();
        }
        
        System.assertNotEquals('La cuenta se encuentra disponible', verification, 'Las respuestas coinciden, la respuesta es: ' + verification);

    }
    //Que inserte la habilidad effect incluido
    public static testmethod void shouldInsertMovesSuccesfullyWhitFullFields() {
        String responseExpected = '{"effect_entries": [{"effect": "Das weather ändert sich zu rain wenn ein Pokémon mit dieser Fähigkeit den Kampf betritt. Dieser Effekt ist dauerhaft bis das weather geändert wird.Wenn mehrere Pokémon mit dieser Fähigkeit, drought, sand stream oder snow warning zur selben Zeit den Kampf betreten, werden die Fähigkeiten nach Reihenfolge der speed der Pokémon ausgelöst, unter Berücksichtigung von trick room.","language": {"name": "de","url": "https://pokeapi.co/api/v2/language/6/"},"short_effect": "Ändert beim Betreten des Kampfes das weather in rain."},{"effect": "The weather changes to rain when this Pokémon enters battle and does not end unless replaced by another weather condition.If multiple Pokémon with this ability, drought, sand stream, or snow warning are sent out at the same time, the abilities will activate in order of Speed, respecting trick room.  Each ability weather will cancel the previous weather, and only the weather summoned by the slowest of the Pokémon will stay.","language": {"name": "en","url": "https://pokeapi.co/api/v2/language/9/"},"short_effect": "Summons rain that lasts indefinitely upon entering battle."}],"id": 999,"name": "test-ability"}';
        
        Abilities__c verification = new Abilities__c(ExtId__c = 999, Name = 'Test-ability',Effect__c = 'Summons rain that lasts indefinitely upon entering battle.', Id = null);
        SingleRequestMock fakeResponse = new SingleRequestMock(200,
                                                 'Ok',
                                                 responseExpected,
                                                 null);

		Test.setMock(HttpCalloutMock.class, fakeResponse);
        Test.startTest();
            Database.executeBatch(new AbilityPokeBatch(), 1);
        Test.stopTest();

        Abilities__c verifyAbility = [SELECT ExtId__c, Name, Effect__c FROM Abilities__c WHERE ExtId__c =  999];
        verifyAbility.Id = null;
        
        System.assertEquals(verification, verifyAbility, 'Las respuestas no coinciden, la respuesta es: ' + verifyAbility);
        
    }

    //Que inserte la habilidad con efecto no especificado
    public static testmethod void shouldInsertMovesSuccesfullyWhitEffectFieldNotSpecified() {
        String responseExpected = '{"effect_entries": [],"id": 999,"name": "test-ability"}';
        
        Abilities__c verification = new Abilities__c(ExtId__c = 999, Name = 'Test-ability',Effect__c = 'The effect is not specified', Id = null);
        SingleRequestMock fakeResponse = new SingleRequestMock(200,
                                                 'Ok',
                                                 responseExpected,
                                                 null);

		Test.setMock(HttpCalloutMock.class, fakeResponse);
        Test.startTest();
            Database.executeBatch(new AbilityPokeBatch(), 1);
        Test.stopTest();

        Abilities__c verifyAbility = [SELECT ExtId__c, Name, Effect__c FROM Abilities__c WHERE ExtId__c =  999];
        verifyAbility.Id = null;
        
        System.assertEquals(verification, verifyAbility, 'Las respuestas no coinciden, la respuesta es: ' + verifyAbility);
        
    }

    //Que inserte la habilidad con efecto nulo
    public static testmethod void shouldInsertMovesSuccesfullyWhitEffectFieldIsNull() {
        String responseExpected = '{"effect_entries": [{"effect": "Das weather ändert sich zu rain wenn ein Pokémon mit dieser Fähigkeit den Kampf betritt. Dieser Effekt ist dauerhaft bis das weather geändert wird.Wenn mehrere Pokémon mit dieser Fähigkeit, drought, sand stream oder snow warning zur selben Zeit den Kampf betreten, werden die Fähigkeiten nach Reihenfolge der speed der Pokémon ausgelöst, unter Berücksichtigung von trick room.","language": {"name": "de","url": "https://pokeapi.co/api/v2/language/6/"},"short_effect": "Ändert beim Betreten des Kampfes das weather in rain."},{"effect": "The weather changes to rain when this Pokémon enters battle and does not end unless replaced by another weather condition.If multiple Pokémon with this ability, drought, sand stream, or snow warning are sent out at the same time, the abilities will activate in order of Speed, respecting trick room.  Each ability weather will cancel the previous weather, and only the weather summoned by the slowest of the Pokémon will stay.","language": {"name": "es","url": "https://pokeapi.co/api/v2/language/9/"},"short_effect": "Summons rain that lasts indefinitely upon entering battle."}],"id": 999,"name": "test-ability"}';
        
        Abilities__c verification = new Abilities__c(ExtId__c = 999, Name = 'Test-ability', Id = null);
        SingleRequestMock fakeResponse = new SingleRequestMock(200,
                                                 'Ok',
                                                 responseExpected,
                                                 null);

		Test.setMock(HttpCalloutMock.class, fakeResponse);
        Test.startTest();
            Database.executeBatch(new AbilityPokeBatch(), 1);
        Test.stopTest();

        Abilities__c verifyAbility = [SELECT ExtId__c, Name, Effect__c FROM Abilities__c WHERE ExtId__c =  999];
        verifyAbility.Id = null;
        
        System.assertEquals(verification, verifyAbility, 'Las respuestas no coinciden, la respuesta es: ' + verifyAbility);
        
    }
}
