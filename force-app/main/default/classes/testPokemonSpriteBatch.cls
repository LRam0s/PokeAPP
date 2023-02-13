@Istest

public with sharing class testPokemonSpriteBatch {
    @TestSetup
    static void makeData(){
        Pokemon__c pokemon1 = new Pokemon__c (
            ExtId__c = 1,
            Name = 'Bulbasaur',
            Types__c = 'Grass;Poison'
            );
        insert pokemon1;
        }

    public static testmethod void shouldUpsertSpriteOnPokemon() {
        String responseExpected = '{"abilities": [{"ability": {"name": "shield-dust","url": "https://pokeapi.co/api/v2/ability/19/"}},{"ability": {"name": "run-away","url": "https://pokeapi.co/api/v2/ability/50/"}}],"height": 3,"id": 999,"moves": [{"move": {"name": "tackle","url": "https://pokeapi.co/api/v2/move/33/"}},{"move": {"name": "string-shot","url": "https://pokeapi.co/api/v2/move/81/"}},{"move": {"name": "snore","url": "https://pokeapi.co/api/v2/move/173/"}}],"name": "test-pokemon","sprites": {"back_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/10.png","back_female": null,"back_shiny": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/10.png","back_shiny_female": null,"front_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/10.png","front_female": null,"front_shiny": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/10.png","front_shiny_female": null, "other": {"dream_world": {"front_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/dream-world/1.svg","front_female": null},"home": {"front_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/1.png","front_female": null,"front_shiny": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/shiny/1.png","front_shiny_female": null},"official-artwork": {"front_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png","front_shiny": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/shiny/1.png"}},"stats": [{"base_stat": 45,"effort": 1,"stat": {"name": "hp","url": "https://pokeapi.co/api/v2/stat/1/"}},{"base_stat": 30,"effort": 0,"stat": {"name": "attack","url": "https://pokeapi.co/api/v2/stat/2/"}},{"base_stat": 35,"effort": 0,"stat": {"name": "defense","url": "https://pokeapi.co/api/v2/stat/3/"}},{"base_stat": 45,"effort": 0,"stat": {"name": "speed","url": "https://pokeapi.co/api/v2/stat/6/"}}],"types":[{"slot":1,"type":{"name":"grass","url":"https://pokeapi.co/api/v2/type/12/"}},{"slot":2,"type":{"name":"poison","url":"https://pokeapi.co/api/v2/type/4/"}}],"weight": 29}}';

        String verification ='https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/1.png';

        SingleRequestMock fakeResponse = new SingleRequestMock(200,
        'Ok',
        responseExpected,
        null);
        
        Test.setMock(HttpCalloutMock.class, fakeResponse);
        Test.startTest();              
            Database.executeBatch(new pokemonSpriteBatch(), 1);
        Test.stopTest();
    
    
        Pokemon__c verifyPokemon = [SELECT Name, Sprite__c FROM Pokemon__c WHERE Name = 'Bulbasaur'];
        String spritePokemon = verifyPokemon.Sprite__c;
        
        System.assertEquals(verification, spritePokemon, 'Las respuestas no coinciden, la respuesta es: ' + spritePokemon);
        
    }

    public static testmethod void shouldNotUpsertSpriteOnPokemon() {
        String responseExpected = '{"abilities": [{"ability": {"name": "shield-dust","url": "https://pokeapi.co/api/v2/ability/19/"}},{"ability": {"name": "run-away","url": "https://pokeapi.co/api/v2/ability/50/"}}],"height": 3,"id": 999,"moves": [{"move": {"name": "tackle","url": "https://pokeapi.co/api/v2/move/33/"}},{"move": {"name": "string-shot","url": "https://pokeapi.co/api/v2/move/81/"}},{"move": {"name": "snore","url": "https://pokeapi.co/api/v2/move/173/"}}],"name": "test-pokemon","sprites": {"back_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/10.png","back_female": null,"back_shiny": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/10.png","back_shiny_female": null,"front_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/10.png","front_female": null,"front_shiny": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/10.png","front_shiny_female": null, "other": {"dream_world": {"front_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/dream-world/1.svg","front_female": null},"home": {"front_default": "null","front_female": null,"front_shiny": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/shiny/1.png","front_shiny_female": null},"official-artwork": {"front_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png","front_shiny": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/shiny/1.png"}},"stats": [{"base_stat": 45,"effort": 1,"stat": {"name": "hp","url": "https://pokeapi.co/api/v2/stat/1/"}},{"base_stat": 30,"effort": 0,"stat": {"name": "attack","url": "https://pokeapi.co/api/v2/stat/2/"}},{"base_stat": 35,"effort": 0,"stat": {"name": "defense","url": "https://pokeapi.co/api/v2/stat/3/"}},{"base_stat": 45,"effort": 0,"stat": {"name": "speed","url": "https://pokeapi.co/api/v2/stat/6/"}}],"types":[{"slot":1,"type":{"name":"grass","url":"https://pokeapi.co/api/v2/type/12/"}},{"slot":2,"type":{"name":"poison","url":"https://pokeapi.co/api/v2/type/4/"}}],"weight": 29}}';

        String verification ='https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/10.png';

        SingleRequestMock fakeResponse = new SingleRequestMock(200,
        'Ok',
        responseExpected,
        null);
        
        Test.setMock(HttpCalloutMock.class, fakeResponse);
        Test.startTest();              
            Database.executeBatch(new pokemonSpriteBatch(), 1);
        Test.stopTest();
    
    
        Pokemon__c verifyPokemon = [SELECT Name, Sprite__c FROM Pokemon__c WHERE Name = 'Bulbasaur'];
        String spritePokemon = verifyPokemon.Sprite__c;
        
        System.assertEquals(verification, spritePokemon, 'Las respuestas no coinciden, la respuesta es: ' + spritePokemon);
        
    }
}