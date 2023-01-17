import { LightningElement, api } from 'lwc';



export default class pokeDetail extends LightningElement {
    @api pokemon;
   
    handleOpenPokemonDetail(){
        const selectEvent = new CustomEvent('pokemonview', {
            detail: this.pokemon.Id
        });
        this.dispatchEvent(selectEvent);
    }
   
    get namePokemon(){
        return this.pokemon.Name.replaceAll('-', ' ');
    }

    get typePokemon(){
        let types = this.pokemon.Types__c.split(';');
        if (types.length > 1) {
            for (let index = 1; index < types.length; index++) {
                const type = types[0] + ' | ' + types[index];
                return type                
            }
        }
            return this.pokemon.Types__c
    }

}

