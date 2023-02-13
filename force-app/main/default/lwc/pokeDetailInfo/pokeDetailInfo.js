import { LightningElement, api, wire, track} from 'lwc';
import getPokemonDetail from '@salesforce/apex/getAllPokemon.getPokemonDetail';
import getSlot from '@salesforce/apex/getAllPokemon.getSlot';
import getAbility from '@salesforce/apex/getAllPokemon.getAbility';

export default class PokeDetailInfo extends LightningElement {
    @track pokemon;
    @api recordId;
    @track slot1;
    @track slot2;
    @track slot3;
    @track slot4;
    @track ability;
    @track abilityEffect;
    @track moveId1;
    @track moveId2;
    @track moveId3;
    @track moveId4;
    @track abilityId;

    @wire(getPokemonDetail, { pokemonId: '$recordId' })
    wiredPokemon(result) {
        this.pokemon = result;
        if (this.pokemon.data) {
            this.moveId1 = result.data.Slot1__c;
            this.moveId2 = result.data.Slot2__c;
            this.moveId3 = result.data.Slot3__c;
            this.moveId4 = result.data.Slot4__c;
            this.abilityId = result.data.Ability__c;
            this.getSlot1();
            this.getSlot2();
            this.getSlot3();
            this.getSlot4();
            this.getAbility();
        }
    }

    getSlot1() {
        getSlot({ moveId: this.moveId1 })
        .then(result => {
            this.slot1 = result.Name;
            this.slot1Id = result.Id;
        })
        .catch(error => {
            console.log(error)
        });
    }
    getSlot2() {
        getSlot({ moveId: this.moveId2 })
        .then(result => {
            this.slot2 = result.Name;
        })
        .catch(error => {
            console.log(error)
        });
    }
    getSlot3() {
        getSlot({ moveId: this.moveId3 })
        .then(result => {
            this.slot3 = result.Name;
        })
        .catch(error => {
            console.log(error)
        });
    }
    getSlot4() {
        getSlot({ moveId: this.moveId4 })
        .then(result => {
            this.slot4 = result.Name;
        })
        .catch(error => {
            console.log(error)
        });
    }
    getAbility() {
        getAbility({ abilityId: this.abilityId })
        .then(result => {
            this.ability = result.Name;
            this.abilityEffect = result.Effect__c;
        })
        .catch(error => {
            console.log(error)
        });
    }

get typePokemon(){
    let types = this.pokemon.data.Types__c.split(';');
    if (types.length > 1) {
        for (let index = 1; index < types.length; index++) {
            const type = types[0] + ' | ' + types[index];
            return type                
        }
    }
        return this.pokemon.data.Types__c
}

OpenMoveDetail1(){
    const url = '/lightning/r/Moves__c/' + this.moveId1 + '/view';
    window.open(url, "_self");
}
OpenMoveDetail2(){
    const url = '/lightning/r/Moves__c/' + this.moveId2 + '/view';
    window.open(url, "_self");
}
OpenMoveDetail3(){
    const url = '/lightning/r/Moves__c/' + this.moveId3 + '/view';
    window.open(url, "_self");
}
OpenMoveDetail4(){
    const url = '/lightning/r/Moves__c/' + this.moveId4 + '/view';
    window.open(url, "_self");
}
OpenAbilityDetail(){
    const url = '/lightning/r/Abilities__c/' + this.abilityId + '/view';
    window.open(url, "_self");
}

}


