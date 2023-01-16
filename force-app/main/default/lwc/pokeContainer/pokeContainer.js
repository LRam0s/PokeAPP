import { LightningElement, wire, track } from 'lwc';
import searchPokemon from '@salesforce/apex/getAllPokemon.searchPokemon';
import filterPicklist from '@salesforce/apex/getAllPokemon.filterPicklist';
import { NavigationMixin } from 'lightning/navigation';

export default class PokeContainer extends NavigationMixin (LightningElement) {
    pokemonName = '';
	generation = 0;
	type = '';
	type2 = '';
	searchType = '';
    @track pokemons;
    @track count = 898;
	
	options = [
        { label: 'All generations', value: 0 },
        { label: 'I', value: 1 },
        { label: 'II', value: 2 },
        { label: 'III', value: 3 },
        { label: 'IV', value: 4 },
        { label: 'V', value: 5 },
        { label: 'VI', value: 6 },
        { label: 'VII', value: 7 },
        { label: 'VIII', value: 8 },

    ];
	types = [
        { label: 'All types', value: '' },
        { label: 'Normal', value: 'Normal' },
        { label: 'Fighting', value: 'Fighting' },
        { label: 'Flying', value: 'Flying' },
        { label: 'Poison', value: 'Poison' },
        { label: 'Ground', value: 'Ground' },
        { label: 'Rock', value: 'Rock' },
        { label: 'Bug', value: 'Bug' },
        { label: 'Ghost', value: 'Ghost' },
        { label: 'Steel', value: 'Steel' },
        { label: 'Fire', value: 'Fire' },
        { label: 'Water', value: 'Water' },
        { label: 'Grass', value: 'Grass' },
        { label: 'Electric', value: 'Electric' },
        { label: 'Psychic', value: 'Psychic' },
        { label: 'Ice', value: 'Ice' },
        { label: 'Dragon', value: 'Dragon' },
        { label: 'Dark', value: 'Dark' },
        { label: 'Fairy', value: 'Fairy' },
    ];
	types2 = [
        { label: 'All Types', value: '' },
        { label: 'Normal', value: 'Normal' },
        { label: 'Fighting', value: 'Fighting' },
        { label: 'Flying', value: 'Flying' },
        { label: 'Poison', value: 'Poison' },
        { label: 'Ground', value: 'Ground' },
        { label: 'Rock', value: 'Rock' },
        { label: 'Bug', value: 'Bug' },
        { label: 'Ghost', value: 'Ghost' },
        { label: 'Steel', value: 'Steel' },
        { label: 'Fire', value: 'Fire' },
        { label: 'Water', value: 'Water' },
        { label: 'Grass', value: 'Grass' },
        { label: 'Electric', value: 'Electric' },
        { label: 'Psychic', value: 'Psychic' },
        { label: 'Ice', value: 'Ice' },
        { label: 'Dragon', value: 'Dragon' },
        { label: 'Dark', value: 'Dark' },
        { label: 'Fairy', value: 'Fairy' },
    ];

    @wire(searchPokemon, {pokemonName: '$pokemonName'})
    wiredPokemon(result) {
        this.pokemons = result;
        this.count = this.countTotalPokemon();
    }
    @wire(filterPicklist, {generation: '$generation', type: '$type', type2: '$type2'})
    wiredPicklist(result) {
        this.pokemons = result;
        this.count = this.countTotalPokemon();
    }
    handleSearchPokemon(event){
		window.clearTimeout(this.delayTimeout);
		const pokemonName = event.target.value;
        this.delayTimeout = setTimeout(() => {
			this.pokemonName = pokemonName;
		}, 300);
    }
    handleSearchGeneration(event){
		window.clearTimeout(this.delayTimeout);
		const generation = event.target.value;
        this.delayTimeout = setTimeout(() => {
			this.generation = generation;
		}, 300);
    }
	handleSearchType(event){
		window.clearTimeout(this.delayTimeout);
		const type = event.target.value;
        this.delayTimeout = setTimeout(() => {
			this.type = type;
		}, 300);
    }
	handleSearchType2(event){
		window.clearTimeout(this.delayTimeout);
		const type2 = event.target.value;
        this.delayTimeout = setTimeout(() => {
			this.type2 = type2;
		}, 300);
    }
    linkToPokemonDetail(event){
        const PokemonId = event.detail;
        this[NavigationMixin.Navigate]({
			type: 'standard__recordPage',
			attributes: {
				recordId: PokemonId,
				objectApiName: 'Pokemon__c',
				actionName: 'view',
			},
		});
    }
    countTotalPokemon(){
        if (this.pokemons && this.pokemons.data){
            let aux = Object.keys(this.pokemons.data);
            this.count = aux.length;
        }
        return this.count;
    }

}
