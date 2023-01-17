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
            Types__c = 'Steel;Electric'
            );   
        pokemonList.add(pokemon5);
        insert pokemonList;

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
        Integer numberExpected = 5;

        Test.startTest();
        List <Pokemon__c> getPokemonWhitName = getAllPokemon.searchPokemon(testName);
        Integer numberActual = getPokemonWhitName.size();        
        Test.stopTest();

        System.assertEquals(numberExpected, numberActual, 'No es el mismo numero');

    }
    //Nombre con contenido trae esas letras
    public static testmethod void shouldGetPokemonWhitSearchName() {

        String testName = 'Tyra';
        Integer numberExpected = 1;

        Test.startTest();
        List <Pokemon__c> getPokemonWhitName = getAllPokemon.searchPokemon(testName);
        Integer numberActual = getPokemonWhitName.size();        
        Test.stopTest();

        System.assertEquals(numberExpected, numberActual, 'No es el mismo numero');

    }
    //generacion y tipos vacios trae todo
    public static testmethod void shoulGetAllPokemonBecauseGenerationAndTypesAreNull() {
        Integer testGeneration = 0;
        String testType1 = '';
        String testType2 = '';


        Integer numberExpected = 5;
        Test.startTest();
        List <Pokemon__c> allPokemon = getAllPokemon.filterPicklist(testGeneration, testType1,testType2);
        Integer numberActual = allPokemon.size();        
        Test.stopTest();

        System.assertEquals(numberExpected, numberActual, 'No es el mismo numero');

    }



    //Generacion algo, tipo null, trae generacion
    public static testmethod void shoulGetPokemonWhitGenerationFullAndTypeNull() {

        Integer testGeneration = 1;
        String testType1 = '';
        String testType2 = '';


        Integer numberExpected = 2;
        Test.startTest();
        List <Pokemon__c> allPokemon = getAllPokemon.filterPicklist(testGeneration, testType1,testType2);
        Integer numberActual = allPokemon.size();        
        Test.stopTest();

        System.assertEquals(numberExpected, numberActual, 'No es el mismo numero');

    }
    //Generacion null, tipo con contenido, verifica si tiene uno o dos tipos y los trae
    public static testmethod void shoulGetPokemonWhitGenerationNullAndTypeFull() {

        Integer testGeneration = 0;
        String testType1 = 'Steel';
        String testType2 = 'Electric';


        Integer numberExpected = 1;
        Test.startTest();
        List <Pokemon__c> allPokemon = getAllPokemon.filterPicklist(testGeneration, testType1,testType2);
        Integer numberActual = allPokemon.size();        
        Test.stopTest();

        System.assertEquals(numberExpected, numberActual, 'No es el mismo numero');

    }
    //Generacion y tipo con contenido, trae todo lo que coincida
    public static testmethod void shoulGetPokemonWhitGenerationAndTypeFull() {

        Integer testGeneration = 1;
        String testType1 = 'Grass';
        String testType2 = '';


        Integer numberExpected = 1;
        Test.startTest();
        List <Pokemon__c> allPokemon = getAllPokemon.filterPicklist(testGeneration, testType1,testType2);
        Integer numberActual = allPokemon.size();        
        Test.stopTest();

        System.assertEquals(numberExpected, numberActual, 'No es el mismo numero');

    }

}