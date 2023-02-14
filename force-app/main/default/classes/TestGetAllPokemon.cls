@isTest
public with sharing class TestGetAllPokemon {
    @TestSetup
    static void makeData(){
        List <Pokemon__c> pokemonList = new List <Pokemon__c>();
        Pokemon__c pokemon1 = new Pokemon__c (
        ExtId__c = 1,
        Name = 'Bulbasaur',
        Types__c = 'Grass;Poison'
        );
        pokemonList.add(pokemon1);
        Pokemon__c pokemon2 = new Pokemon__c (
            ExtId__c = 2,
            Name = 'Ivysaur',
            Types__c = 'Grass'
            );
        pokemonList.add(pokemon2);


            Pokemon__c pokemon3 = new Pokemon__c (
                ExtId__c = 503,
                Name = 'Charizard',
                Types__c = 'Fire;Normal'
                );
        pokemonList.add(pokemon3);


                Pokemon__c pokemon4 = new Pokemon__c (
        ExtId__c = 501,
        Name = 'Tyranitar',
        Types__c = 'Rock'
        );
        pokemonList.add(pokemon4);


        Pokemon__c pokemon5 = new Pokemon__c (
            ExtId__c = 500,
            Name = 'Pikachu',
            Types__c = 'Steel;Electric',
            Image__c = 'url/img/pikachu',
            Hp__c = 10,
            Attack__c = 6,
            Defense__c = 3,
            Speed__c = 8,
            Heigth__c = 13,
            Weigth__c = 3
            );   
        pokemonList.add(pokemon5);
        insert pokemonList;

        Moves__c move1 = new Moves__c(
            Name = 'Rayo solar'

        );
        insert move1;

        Abilities__c ability = new Abilities__c (
            Name = 'Multitype',
            Effect__c = 'Tiene todos los tipos del mundo'
        );
        insert ability;

    }

    public static testmethod void shouldGetAllPokemon() {

        Integer numberExpected = 5;
        Test.startTest();
        List <Pokemon__c> allPokemon = getAllPokemon.getAllPokemon();
        Integer numberActual = allPokemon.size();        
        Test.stopTest();

        System.assertEquals(numberExpected, numberActual, 'No es el mismo numero');

    }
    //Un solo tipo
    public static testmethod void shouldVerifyOneTypeOfPokemon() {

        String testType1 = 'Fire';
        String testType2 = '';

        Test.startTest();
        String searchTypes = getAllPokemon.getTypePokemon(testType1,testType2 );        
        Test.stopTest();

        System.assertEquals(testType1, searchTypes, 'No coinciden las palabras');

    }
    //Dos tipos
    public static testmethod void shouldVerifyTwoTypeOfPokemon() {

        String testType1 = 'Fire';
        String testType2 = 'Rock';
        String testTypes = testType1 + ';' + testType2;

        Test.startTest();
        String searchTypes = getAllPokemon.getTypePokemon(testType1, testType2);        
        Test.stopTest();

        System.assertEquals(testTypes, searchTypes, 'No coinciden las palabras');

    }


    //Name vacio trae todo
    public static testmethod void shouldGetAllPokemonBecauseNoNameSearch() {
        String testName = '';
        Integer testGeneration = 0;
        String testType1 = '';
        String testType2 = '';
        Integer numberExpected = 5;

        Test.startTest();
        List <Pokemon__c> getPokemonWhitName = getAllPokemon.filterComplete(testName,testGeneration,testType1,testType2);
        Integer numberActual = getPokemonWhitName.size();        
        Test.stopTest();

        System.assertEquals(numberExpected, numberActual, 'No es el mismo numero');

    }
    //Nombre con contenido trae esas letras
    public static testmethod void shouldGetPokemonWhitSearchName() {

        String testName = 'Tyra';
        Integer testGeneration = 0;
        String testType1 = '';
        String testType2 = '';
        Integer numberExpected = 1;

        Test.startTest();
        List <Pokemon__c> getPokemonWhitName = getAllPokemon.filterComplete(testName,testGeneration,testType1,testType2);
        Integer numberActual = getPokemonWhitName.size();        
        Test.stopTest();

        System.assertEquals(numberExpected, numberActual, 'No es el mismo numero');

    }
    //generacion y tipos vacios trae todo
    public static testmethod void shoulGetAllPokemonBecauseGenerationAndTypesAreNull() {
        String testName = '';
        Integer testGeneration = 0;
        String testType1 = '';
        String testType2 = '';


        Integer numberExpected = 5;
        Test.startTest();
        List <Pokemon__c> allPokemon = getAllPokemon.filterComplete(testName,testGeneration,testType1,testType2);
        Integer numberActual = allPokemon.size();        
        Test.stopTest();

        System.assertEquals(numberExpected, numberActual, 'No es el mismo numero');

    }



    //Generacion algo, tipo null, trae generacion
    public static testmethod void shoulGetPokemonWhitGenerationFullAndTypeNull() {
        String testName = '';
        Integer testGeneration = 1;
        String testType1 = '';
        String testType2 = '';


        Integer numberExpected = 2;
        Test.startTest();
        List <Pokemon__c> allPokemon = getAllPokemon.filterComplete(testName,testGeneration,testType1,testType2);
        Integer numberActual = allPokemon.size();        
        Test.stopTest();

        System.assertEquals(numberExpected, numberActual, 'No es el mismo numero');

    }
    //Generacion null, tipo con contenido, verifica si tiene uno o dos tipos y los trae
    public static testmethod void shoulGetPokemonWhitGenerationNullAndTypeFull() {
        String testName = '';
        Integer testGeneration = 0;
        String testType1 = 'Steel';
        String testType2 = 'Electric';


        Integer numberExpected = 1;
        Test.startTest();
        List <Pokemon__c> allPokemon = getAllPokemon.filterComplete(testName,testGeneration,testType1,testType2);
        Integer numberActual = allPokemon.size();        
        Test.stopTest();

        System.assertEquals(numberExpected, numberActual, 'No es el mismo numero');

    }
    //Generacion y tipo con contenido, trae todo lo que coincida
    public static testmethod void shoulGetPokemonWhitGenerationAndTypeFull() {
        String testName = '';
        Integer testGeneration = 1;
        String testType1 = 'Grass';
        String testType2 = '';


        Integer numberExpected = 1;
        Test.startTest();
        List <Pokemon__c> allPokemon = getAllPokemon.filterComplete(testName,testGeneration,testType1,testType2);
        Integer numberActual = allPokemon.size();        
        Test.stopTest();

        System.assertEquals(numberExpected, numberActual, 'No es el mismo numero');

    }

    public static testmethod void shoulGetPokemonWhitNameAndTypeFull() {
        String testName = 'Tyra';
        Integer testGeneration = 0;
        String testType1 = 'Rock';
        String testType2 = '';


        Integer numberExpected = 1;
        Test.startTest();
        List <Pokemon__c> allPokemon = getAllPokemon.filterComplete(testName,testGeneration,testType1,testType2);
        Integer numberActual = allPokemon.size();        
        Test.stopTest();

        System.assertEquals(numberExpected, numberActual, 'No es el mismo numero');

    }

    public static testmethod void shoulGetPokemonWhitNameAndGenerationFull() {
        String testName = 'Ivy';
        Integer testGeneration = 1;
        String testType1 = '';
        String testType2 = '';


        Integer numberExpected = 1;
        Test.startTest();
        List <Pokemon__c> allPokemon = getAllPokemon.filterComplete(testName,testGeneration,testType1,testType2);
        Integer numberActual = allPokemon.size();        
        Test.stopTest();

        System.assertEquals(numberExpected, numberActual, 'No es el mismo numero');

    }


    public static testmethod void shouldGetPokemonWhitAllDetail() {

        Pokemon__c queryPokemon = [SELECT Id FROM Pokemon__c WHERE Name = 'Pikachu'];
        String pokemonId = queryPokemon.Id;
        String nameExpected = 'Pikachu';
        Test.startTest();
        Pokemon__c pokemonDetailTest = getAllPokemon.getPokemonDetail(pokemonId);
        String pokemonName =  pokemonDetailTest.Name;       
        Test.stopTest();

        System.assertEquals(nameExpected, pokemonName, 'No es el mismo numero');

    }

    public static testmethod void shouldGetMove() {

        Moves__c queryMove = [SELECT Id FROM Moves__c WHERE Name = 'Rayo solar'];
        String moveId = queryMove.Id;
        String nameExpected = 'Rayo solar';
        Test.startTest();
        Moves__c moveTest = getAllPokemon.getSlot(moveId);
        String moveName =  moveTest.Name;       
        Test.stopTest();

        System.assertEquals(nameExpected, moveName, 'No es el mismo numero');

    }

    public static testmethod void shouldGetAbility() {

        Abilities__c abilityMove = [SELECT Id FROM Abilities__c WHERE Name = 'Multitype'];
        String abilityId = abilityMove.Id;
        String nameExpected = 'Multitype';
        Test.startTest();
        Abilities__c abilityTest = getAllPokemon.getAbility(abilityId);
        String abilityName =  abilityTest.Name;       
        Test.stopTest();

        System.assertEquals(nameExpected, abilityName, 'No es el mismo numero');

    }

}