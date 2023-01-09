@isTest

public with sharing class TestPokemonPokeBatch {

    public static testmethod void shouldNotReturnAApiResponse() {
        String responseExpected = '{"abilities": [{"ability": {"name": "shield-dust","url": "https://pokeapi.co/api/v2/ability/19/"},"is_hidden": false,"slot": 1},{"ability": {"name": "run-away","url": "https://pokeapi.co/api/v2/ability/50/"},"is_hidden": true,"slot": 3}],"height": 3,"id": 999,"moves": [{"move": {"name": "tackle","url": "https://pokeapi.co/api/v2/move/33/"}},{"move": {"name": "string-shot","url": "https://pokeapi.co/api/v2/move/81/"}},{"move": {"name": "snore","url": "https://pokeapi.co/api/v2/move/173/"}},{"move": {"name": "bug-bite","url": "https://pokeapi.co/api/v2/move/450/"}},{"move": {"name": "electroweb","url": "https://pokeapi.co/api/v2/move/527/"}}],"name": "test-pokemon","sprites": {"back_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/10.png","back_female": null,"back_shiny": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/10.png","back_shiny_female": null,"front_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/10.png","front_female": null,"front_shiny": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/10.png","front_shiny_female": null},"stats": [{"base_stat": 45,"effort": 1,"stat": {"name": "hp","url": "https://pokeapi.co/api/v2/stat/1/"}},{"base_stat": 30,"effort": 0,"stat": {"name": "attack","url": "https://pokeapi.co/api/v2/stat/2/"}},{"base_stat": 35,"effort": 0,"stat": {"name": "defense","url": "https://pokeapi.co/api/v2/stat/3/"}},{"base_stat": 45,"effort": 0,"stat": {"name": "speed","url": "https://pokeapi.co/api/v2/stat/6/"}}],"types": [{"slot": 1,"type": {"name": "bug","url": "https://pokeapi.co/api/v2/type/7/"}}],"weight": 29}';
        String verification;
        SingleRequestMock fakeResponse = new SingleRequestMock(400,
                                                 'Error',
                                                 responseExpected,
                                                 null);

		Test.setMock(HttpCalloutMock.class, fakeResponse);
        Test.startTest();
            Database.executeBatch(new PokemonPokeBatch(), 1);
        Test.stopTest();

        
        
        try {
            Pokemon__c verifyPokemon = [SELECT ExtId__c, Name, Generation__c, Ability__c, Heigth__c, Weigth__c, Image__c, Types__c, Hp__c, Speed__c, Defense__c, Attack__c, Slot1__c, Slot2__c, Slot3__c, Slot4__c FROM Pokemon__c  WHERE ExtId__c =  999];
            verification = 'La cuenta se encuentra disponible';             
        } catch (Exception e) {
            verification = e.getMessage();
        }
        
        System.assertNotEquals('La cuenta se encuentra disponible', verification, 'Las respuestas coinciden, la respuesta es: ' + verification);
        
    }

    public static testmethod void shouldInsertPokemonSuccesfullyWhitFullFields() {
        String responseExpected = '{"abilities": [{"ability": {"name": "shield-dust","url": "https://pokeapi.co/api/v2/ability/19/"}},{"ability": {"name": "run-away","url": "https://pokeapi.co/api/v2/ability/50/"}}],"height": 3,"id": 999,"moves": [{"move": {"name": "tackle","url": "https://pokeapi.co/api/v2/move/33/"}},{"move": {"name": "string-shot","url": "https://pokeapi.co/api/v2/move/81/"}},{"move": {"name": "snore","url": "https://pokeapi.co/api/v2/move/173/"}},{"move": {"name": "bug-bite","url": "https://pokeapi.co/api/v2/move/450/"}},{"move": {"name": "electroweb","url": "https://pokeapi.co/api/v2/move/527/"}}],"name": "test-pokemon","sprites": {"back_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/10.png","back_female": null,"back_shiny": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/10.png","back_shiny_female": null,"front_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/10.png","front_female": null,"front_shiny": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/10.png","front_shiny_female": null},"stats": [{"base_stat": 45,"effort": 1,"stat": {"name": "hp","url": "https://pokeapi.co/api/v2/stat/1/"}},{"base_stat": 30,"effort": 0,"stat": {"name": "attack","url": "https://pokeapi.co/api/v2/stat/2/"}},{"base_stat": 35,"effort": 0,"stat": {"name": "defense","url": "https://pokeapi.co/api/v2/stat/3/"}},{"base_stat": 45,"effort": 0,"stat": {"name": "speed","url": "https://pokeapi.co/api/v2/stat/6/"}}],"types":[{"slot":1,"type":{"name":"grass","url":"https://pokeapi.co/api/v2/type/12/"}},{"slot":2,"type":{"name":"poison","url":"https://pokeapi.co/api/v2/type/4/"}}],"weight": 29}';

        Abilities__c abilityTest = new Abilities__c(Name = 'Shield-dust');
        Moves__c moveTest1 = new Moves__c(Name = 'Tackle');
        Moves__c moveTest2 = new Moves__c(Name = 'String-shot');
        Moves__c moveTest3 = new Moves__c(Name = 'Snore');
        Moves__c moveTest4 = new Moves__c(Name = 'Bug-bite');

        
        SingleRequestMock fakeResponse = new SingleRequestMock(200,
        'Ok',
        responseExpected,
        null);
        
		Test.setMock(HttpCalloutMock.class, fakeResponse);
        Test.startTest();
            insert abilityTest;
            insert moveTest1;
            insert moveTest2;
            insert moveTest3;
            insert moveTest4;

            
            Database.executeBatch(new PokemonPokeBatch(), 1);
        Test.stopTest();
        Abilities__c lookupAbility = [SELECT Id FROM Abilities__c WHERE Name = 'Shield-dust'];
        Moves__c lookupMove1 = [SELECT Id FROM Moves__c WHERE Name = 'Tackle'];
        Moves__c lookupMove2 = [SELECT Id FROM Moves__c WHERE Name = 'String-shot'];
        Moves__c lookupMove3 = [SELECT Id FROM Moves__c WHERE Name = 'Snore'];
        Moves__c lookupMove4 = [SELECT Id FROM Moves__c WHERE Name = 'Bug-bite'];

        Pokemon__c verification = new Pokemon__c(ExtId__c = 999, Name = 'Test-pokemon', Ability__c = lookupAbility.Id, Heigth__c = 3, Weigth__c = 29, Image__c = 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/10.png', Types__c = 'Poison;Grass', Hp__c = 45,Speed__c = 45,Defense__c = 35, Attack__c =30, Slot1__c= lookupMove1.Id, Slot2__c = lookupMove2.Id, Slot3__c = lookupMove3.Id, Slot4__c = lookupMove4.Id,  Id = null);

        Pokemon__c verifyPokemon = [SELECT ExtId__c, Name, Generation__c, Ability__c, Heigth__c, Weigth__c, Image__c, Types__c, Hp__c, Speed__c, Defense__c, Attack__c, Slot1__c, Slot2__c, Slot3__c, Slot4__c FROM Pokemon__c  WHERE ExtId__c =  999];
        verifyPokemon.Id = null;
        
        System.assertEquals(verification, verifyPokemon, 'Las respuestas no coinciden, la respuesta es: ' + verification);
        
    }
    
public static testmethod void shouldInsertPokemonSuccesfullyWhitOneType() {
    String responseExpected = '{"abilities": [{"ability": {"name": "shield-dust","url": "https://pokeapi.co/api/v2/ability/19/"}},{"ability": {"name": "run-away","url": "https://pokeapi.co/api/v2/ability/50/"}}],"height": 3,"id": 999,"moves": [{"move": {"name": "tackle","url": "https://pokeapi.co/api/v2/move/33/"}},{"move": {"name": "string-shot","url": "https://pokeapi.co/api/v2/move/81/"}},{"move": {"name": "snore","url": "https://pokeapi.co/api/v2/move/173/"}},{"move": {"name": "bug-bite","url": "https://pokeapi.co/api/v2/move/450/"}},{"move": {"name": "electroweb","url": "https://pokeapi.co/api/v2/move/527/"}}],"name": "test-pokemon","sprites": {"back_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/10.png","back_female": null,"back_shiny": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/10.png","back_shiny_female": null,"front_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/10.png","front_female": null,"front_shiny": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/10.png","front_shiny_female": null},"stats": [{"base_stat": 45,"effort": 1,"stat": {"name": "hp","url": "https://pokeapi.co/api/v2/stat/1/"}},{"base_stat": 30,"effort": 0,"stat": {"name": "attack","url": "https://pokeapi.co/api/v2/stat/2/"}},{"base_stat": 35,"effort": 0,"stat": {"name": "defense","url": "https://pokeapi.co/api/v2/stat/3/"}},{"base_stat": 45,"effort": 0,"stat": {"name": "speed","url": "https://pokeapi.co/api/v2/stat/6/"}}],"types": [{"slot": 1,"type": {"name": "bug","url": "https://pokeapi.co/api/v2/type/7/"}}],"weight": 29}';

    Abilities__c abilityTest = new Abilities__c(Name = 'Shield-dust');
    Moves__c moveTest1 = new Moves__c(Name = 'Tackle');
    Moves__c moveTest2 = new Moves__c(Name = 'String-shot');
    Moves__c moveTest3 = new Moves__c(Name = 'Snore');
    Moves__c moveTest4 = new Moves__c(Name = 'Bug-bite');

    
    SingleRequestMock fakeResponse = new SingleRequestMock(200,
    'Ok',
    responseExpected,
    null);
    
    Test.setMock(HttpCalloutMock.class, fakeResponse);
    Test.startTest();
        insert abilityTest;
        insert moveTest1;
        insert moveTest2;
        insert moveTest3;
        insert moveTest4;

        
        Database.executeBatch(new PokemonPokeBatch(), 1);
    Test.stopTest();
    Abilities__c lookupAbility = [SELECT Id FROM Abilities__c WHERE Name = 'Shield-dust'];
    Moves__c lookupMove1 = [SELECT Id FROM Moves__c WHERE Name = 'Tackle'];
    Moves__c lookupMove2 = [SELECT Id FROM Moves__c WHERE Name = 'String-shot'];
    Moves__c lookupMove3 = [SELECT Id FROM Moves__c WHERE Name = 'Snore'];
    Moves__c lookupMove4 = [SELECT Id FROM Moves__c WHERE Name = 'Bug-bite'];

    Pokemon__c verification = new Pokemon__c(ExtId__c = 999, Name = 'Test-pokemon', Ability__c = lookupAbility.Id, Heigth__c = 3, Weigth__c = 29, Image__c = 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/10.png', Types__c = 'Bug', Hp__c = 45,Speed__c = 45,Defense__c = 35, Attack__c =30, Slot1__c= lookupMove1.Id, Slot2__c = lookupMove2.Id, Slot3__c = lookupMove3.Id, Slot4__c = lookupMove4.Id,  Id = null);

    Pokemon__c verifyPokemon = [SELECT ExtId__c, Name, Generation__c, Ability__c, Heigth__c, Weigth__c, Image__c, Types__c, Hp__c, Speed__c, Defense__c, Attack__c, Slot1__c, Slot2__c, Slot3__c, Slot4__c FROM Pokemon__c  WHERE ExtId__c =  999];
    verifyPokemon.Id = null;
    
    System.assertEquals(verification, verifyPokemon, 'Las respuestas no coinciden, la respuesta es: ' + verification);
    
}

public static testmethod void shouldInsertPokemonSuccesfullyWhitThreeMoves() {
    String responseExpected = '{"abilities": [{"ability": {"name": "shield-dust","url": "https://pokeapi.co/api/v2/ability/19/"}},{"ability": {"name": "run-away","url": "https://pokeapi.co/api/v2/ability/50/"}}],"height": 3,"id": 999,"moves": [{"move": {"name": "tackle","url": "https://pokeapi.co/api/v2/move/33/"}},{"move": {"name": "string-shot","url": "https://pokeapi.co/api/v2/move/81/"}},{"move": {"name": "snore","url": "https://pokeapi.co/api/v2/move/173/"}}],"name": "test-pokemon","sprites": {"back_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/10.png","back_female": null,"back_shiny": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/10.png","back_shiny_female": null,"front_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/10.png","front_female": null,"front_shiny": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/10.png","front_shiny_female": null},"stats": [{"base_stat": 45,"effort": 1,"stat": {"name": "hp","url": "https://pokeapi.co/api/v2/stat/1/"}},{"base_stat": 30,"effort": 0,"stat": {"name": "attack","url": "https://pokeapi.co/api/v2/stat/2/"}},{"base_stat": 35,"effort": 0,"stat": {"name": "defense","url": "https://pokeapi.co/api/v2/stat/3/"}},{"base_stat": 45,"effort": 0,"stat": {"name": "speed","url": "https://pokeapi.co/api/v2/stat/6/"}}],"types":[{"slot":1,"type":{"name":"grass","url":"https://pokeapi.co/api/v2/type/12/"}},{"slot":2,"type":{"name":"poison","url":"https://pokeapi.co/api/v2/type/4/"}}],"weight": 29}';

    Abilities__c abilityTest = new Abilities__c(Name = 'Shield-dust');
    Moves__c moveTest1 = new Moves__c(Name = 'Tackle');
    Moves__c moveTest2 = new Moves__c(Name = 'String-shot');
    Moves__c moveTest3 = new Moves__c(Name = 'Snore');

    
    SingleRequestMock fakeResponse = new SingleRequestMock(200,
    'Ok',
    responseExpected,
    null);
    
    Test.setMock(HttpCalloutMock.class, fakeResponse);
    Test.startTest();
        insert abilityTest;
        insert moveTest1;
        insert moveTest2;
        insert moveTest3;

        
        Database.executeBatch(new PokemonPokeBatch(), 1);
    Test.stopTest();
    Abilities__c lookupAbility = [SELECT Id FROM Abilities__c WHERE Name = 'Shield-dust'];
    Moves__c lookupMove1 = [SELECT Id FROM Moves__c WHERE Name = 'Tackle'];
    Moves__c lookupMove2 = [SELECT Id FROM Moves__c WHERE Name = 'String-shot'];
    Moves__c lookupMove3 = [SELECT Id FROM Moves__c WHERE Name = 'Snore'];

    Pokemon__c verification = new Pokemon__c(ExtId__c = 999, Name = 'Test-pokemon', Ability__c = lookupAbility.Id, Heigth__c = 3, Weigth__c = 29, Image__c = 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/10.png', Types__c = 'Poison;Grass', Hp__c = 45,Speed__c = 45,Defense__c = 35, Attack__c =30, Slot1__c= lookupMove1.Id, Slot2__c = lookupMove2.Id, Slot3__c = lookupMove3.Id,  Id = null);

    Pokemon__c verifyPokemon = [SELECT ExtId__c, Name, Generation__c, Ability__c, Heigth__c, Weigth__c, Image__c, Types__c, Hp__c, Speed__c, Defense__c, Attack__c, Slot1__c, Slot2__c, Slot3__c FROM Pokemon__c  WHERE ExtId__c =  999];
    verifyPokemon.Id = null;
    
    System.assertEquals(verification, verifyPokemon, 'Las respuestas no coinciden, la respuesta es: ' + verification);
    
}

public static testmethod void shouldInsertPokemonSuccesfullyWhitTwoMoves() {
    String responseExpected = '{"abilities": [{"ability": {"name": "shield-dust","url": "https://pokeapi.co/api/v2/ability/19/"}},{"ability": {"name": "run-away","url": "https://pokeapi.co/api/v2/ability/50/"}}],"height": 3,"id": 999,"moves": [{"move": {"name": "tackle","url": "https://pokeapi.co/api/v2/move/33/"}},{"move": {"name": "string-shot","url": "https://pokeapi.co/api/v2/move/81/"}}],"name": "test-pokemon","sprites": {"back_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/10.png","back_female": null,"back_shiny": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/10.png","back_shiny_female": null,"front_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/10.png","front_female": null,"front_shiny": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/10.png","front_shiny_female": null},"stats": [{"base_stat": 45,"effort": 1,"stat": {"name": "hp","url": "https://pokeapi.co/api/v2/stat/1/"}},{"base_stat": 30,"effort": 0,"stat": {"name": "attack","url": "https://pokeapi.co/api/v2/stat/2/"}},{"base_stat": 35,"effort": 0,"stat": {"name": "defense","url": "https://pokeapi.co/api/v2/stat/3/"}},{"base_stat": 45,"effort": 0,"stat": {"name": "speed","url": "https://pokeapi.co/api/v2/stat/6/"}}],"types":[{"slot":1,"type":{"name":"grass","url":"https://pokeapi.co/api/v2/type/12/"}},{"slot":2,"type":{"name":"poison","url":"https://pokeapi.co/api/v2/type/4/"}}],"weight": 29}';

    Abilities__c abilityTest = new Abilities__c(Name = 'Shield-dust');
    Moves__c moveTest1 = new Moves__c(Name = 'Tackle');
    Moves__c moveTest2 = new Moves__c(Name = 'String-shot');

    
    SingleRequestMock fakeResponse = new SingleRequestMock(200,
    'Ok',
    responseExpected,
    null);
    
    Test.setMock(HttpCalloutMock.class, fakeResponse);
    Test.startTest();
        insert abilityTest;
        insert moveTest1;
        insert moveTest2;

        
        Database.executeBatch(new PokemonPokeBatch(), 1);
    Test.stopTest();
    Abilities__c lookupAbility = [SELECT Id FROM Abilities__c WHERE Name = 'Shield-dust'];
    Moves__c lookupMove1 = [SELECT Id FROM Moves__c WHERE Name = 'Tackle'];
    Moves__c lookupMove2 = [SELECT Id FROM Moves__c WHERE Name = 'String-shot'];

    Pokemon__c verification = new Pokemon__c(ExtId__c = 999, Name = 'Test-pokemon', Ability__c = lookupAbility.Id, Heigth__c = 3, Weigth__c = 29, Image__c = 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/10.png', Types__c = 'Poison;Grass', Hp__c = 45,Speed__c = 45,Defense__c = 35, Attack__c =30, Slot1__c= lookupMove1.Id, Slot2__c = lookupMove2.Id, Id = null);

    Pokemon__c verifyPokemon = [SELECT ExtId__c, Name, Generation__c, Ability__c, Heigth__c, Weigth__c, Image__c, Types__c, Hp__c, Speed__c, Defense__c, Attack__c, Slot1__c, Slot2__c FROM Pokemon__c  WHERE ExtId__c =  999];
    verifyPokemon.Id = null;
    
    System.assertEquals(verification, verifyPokemon, 'Las respuestas no coinciden, la respuesta es: ' + verification);
    
}

public static testmethod void shouldInsertPokemonSuccesfullyWhitOneMove() {
    String responseExpected = '{"abilities": [{"ability": {"name": "shield-dust","url": "https://pokeapi.co/api/v2/ability/19/"}},{"ability": {"name": "run-away","url": "https://pokeapi.co/api/v2/ability/50/"}}],"height": 3,"id": 999,"moves": [{"move": {"name": "tackle","url": "https://pokeapi.co/api/v2/move/33/"}}],"name": "test-pokemon","sprites": {"back_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/10.png","back_female": null,"back_shiny": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/10.png","back_shiny_female": null,"front_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/10.png","front_female": null,"front_shiny": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/10.png","front_shiny_female": null},"stats": [{"base_stat": 45,"effort": 1,"stat": {"name": "hp","url": "https://pokeapi.co/api/v2/stat/1/"}},{"base_stat": 30,"effort": 0,"stat": {"name": "attack","url": "https://pokeapi.co/api/v2/stat/2/"}},{"base_stat": 35,"effort": 0,"stat": {"name": "defense","url": "https://pokeapi.co/api/v2/stat/3/"}},{"base_stat": 45,"effort": 0,"stat": {"name": "speed","url": "https://pokeapi.co/api/v2/stat/6/"}}],"types":[{"slot":1,"type":{"name":"grass","url":"https://pokeapi.co/api/v2/type/12/"}},{"slot":2,"type":{"name":"poison","url":"https://pokeapi.co/api/v2/type/4/"}}],"weight": 29}';

    Abilities__c abilityTest = new Abilities__c(Name = 'Shield-dust');
    Moves__c moveTest1 = new Moves__c(Name = 'Tackle');

    
    SingleRequestMock fakeResponse = new SingleRequestMock(200,
    'Ok',
    responseExpected,
    null);
    
    Test.setMock(HttpCalloutMock.class, fakeResponse);
    Test.startTest();
        insert abilityTest;
        insert moveTest1;


        
        Database.executeBatch(new PokemonPokeBatch(), 1);
    Test.stopTest();
    Abilities__c lookupAbility = [SELECT Id FROM Abilities__c WHERE Name = 'Shield-dust'];
    Moves__c lookupMove1 = [SELECT Id FROM Moves__c WHERE Name = 'Tackle'];


    Pokemon__c verification = new Pokemon__c(ExtId__c = 999, Name = 'Test-pokemon', Ability__c = lookupAbility.Id, Heigth__c = 3, Weigth__c = 29, Image__c = 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/10.png', Types__c = 'Poison;Grass', Hp__c = 45,Speed__c = 45,Defense__c = 35, Attack__c =30, Slot1__c= lookupMove1.Id,  Id = null);

    Pokemon__c verifyPokemon = [SELECT ExtId__c, Name, Generation__c, Ability__c, Heigth__c, Weigth__c, Image__c, Types__c, Hp__c, Speed__c, Defense__c, Attack__c, Slot1__c FROM Pokemon__c  WHERE ExtId__c =  999];
    verifyPokemon.Id = null;
    
    System.assertEquals(verification, verifyPokemon, 'Las respuestas no coinciden, la respuesta es: ' + verification);
    
}

public static testmethod void shouldInsertPokemonSuccesfullyWhitOneAbility() {
    String responseExpected = '{"abilities": [{"ability": {"name": "shield-dust","url": "https://pokeapi.co/api/v2/ability/19/"}}],"height": 3,"id": 999,"moves": [{"move": {"name": "tackle","url": "https://pokeapi.co/api/v2/move/33/"}},{"move": {"name": "string-shot","url": "https://pokeapi.co/api/v2/move/81/"}},{"move": {"name": "snore","url": "https://pokeapi.co/api/v2/move/173/"}},{"move": {"name": "bug-bite","url": "https://pokeapi.co/api/v2/move/450/"}},{"move": {"name": "electroweb","url": "https://pokeapi.co/api/v2/move/527/"}}],"name": "test-pokemon","sprites": {"back_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/10.png","back_female": null,"back_shiny": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/10.png","back_shiny_female": null,"front_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/10.png","front_female": null,"front_shiny": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/10.png","front_shiny_female": null},"stats": [{"base_stat": 45,"effort": 1,"stat": {"name": "hp","url": "https://pokeapi.co/api/v2/stat/1/"}},{"base_stat": 30,"effort": 0,"stat": {"name": "attack","url": "https://pokeapi.co/api/v2/stat/2/"}},{"base_stat": 35,"effort": 0,"stat": {"name": "defense","url": "https://pokeapi.co/api/v2/stat/3/"}},{"base_stat": 45,"effort": 0,"stat": {"name": "speed","url": "https://pokeapi.co/api/v2/stat/6/"}}],"types":[{"slot":1,"type":{"name":"grass","url":"https://pokeapi.co/api/v2/type/12/"}},{"slot":2,"type":{"name":"poison","url":"https://pokeapi.co/api/v2/type/4/"}}],"weight": 29}';

    Abilities__c abilityTest = new Abilities__c(Name = 'Shield-dust');
    Moves__c moveTest1 = new Moves__c(Name = 'Tackle');
    Moves__c moveTest2 = new Moves__c(Name = 'String-shot');
    Moves__c moveTest3 = new Moves__c(Name = 'Snore');
    Moves__c moveTest4 = new Moves__c(Name = 'Bug-bite');

    
    SingleRequestMock fakeResponse = new SingleRequestMock(200,
    'Ok',
    responseExpected,
    null);
    
    Test.setMock(HttpCalloutMock.class, fakeResponse);
    Test.startTest();
        insert abilityTest;
        insert moveTest1;
        insert moveTest2;
        insert moveTest3;
        insert moveTest4;

        
        Database.executeBatch(new PokemonPokeBatch(), 1);
    Test.stopTest();
    Abilities__c lookupAbility = [SELECT Id FROM Abilities__c WHERE Name = 'Shield-dust'];
    Moves__c lookupMove1 = [SELECT Id FROM Moves__c WHERE Name = 'Tackle'];
    Moves__c lookupMove2 = [SELECT Id FROM Moves__c WHERE Name = 'String-shot'];
    Moves__c lookupMove3 = [SELECT Id FROM Moves__c WHERE Name = 'Snore'];
    Moves__c lookupMove4 = [SELECT Id FROM Moves__c WHERE Name = 'Bug-bite'];

    Pokemon__c verification = new Pokemon__c(ExtId__c = 999, Name = 'Test-pokemon', Ability__c = lookupAbility.Id, Heigth__c = 3, Weigth__c = 29, Image__c = 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/10.png', Types__c = 'Poison;Grass', Hp__c = 45,Speed__c = 45,Defense__c = 35, Attack__c =30, Slot1__c= lookupMove1.Id, Slot2__c = lookupMove2.Id, Slot3__c = lookupMove3.Id, Slot4__c = lookupMove4.Id,  Id = null);

    Pokemon__c verifyPokemon = [SELECT ExtId__c, Name, Generation__c, Ability__c, Heigth__c, Weigth__c, Image__c, Types__c, Hp__c, Speed__c, Defense__c, Attack__c, Slot1__c, Slot2__c, Slot3__c, Slot4__c FROM Pokemon__c  WHERE ExtId__c =  999];
    verifyPokemon.Id = null;
    
    System.assertEquals(verification, verifyPokemon, 'Las respuestas no coinciden, la respuesta es: ' + verification);
    
}
}