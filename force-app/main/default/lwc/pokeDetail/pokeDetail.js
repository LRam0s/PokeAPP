import { LightningElement, api,track } from 'lwc';



export default class pokeDetail extends LightningElement {
    @api pokemon;
    pokemons;
    /* @track tiposSeparados; */
    


    handleOpenPokemonDetail(){
        const selectEvent = new CustomEvent('pokemonview', {
            detail: this.pokemon.Id
        });
        this.dispatchEvent(selectEvent);
    }
   


/*     separarTipos(stringTipos) {
        this.tiposSeparados = stringTipos.split(";");
    }
    connectedCallback(){
        this.separarTipos(this.pokemon.Types__c);
    } */

/*     render(){
        return (
            
            <template>
                <article class="container" onclick={handleOpenPokemonDetail}>
                <div>
                    <img src={pokemon.Image__c} alt="Pokemon" style="width: 300px;"> </img>
                </div>
                <section class="header">
                    <div style="display: flex; gap: 0.2rem; align-items: center; font-size: 1rem">
                        <img style="width: 30px;" src="https://res.cloudinary.com/dpsc3qokx/image/upload/v1673548795/icons8-pokeball-2-48_k8ig3z.png" alt="Pokeball"> </img>
                        <span >#{pokemon.ExtId__c}</span>
                    </div>
                    <div>
                        <span class="title">{pokemon.Name}</span>
                    </div>
                </section>
                <section class="sprite">
                    <div id="type" class="sprite">
                        {
                            tiposSeparados.map(tipo => <span>{tipo}</span>)
                        }
                    </div>
                    <span>Generation: {pokemon.Generation__c}</span>
                </section>
                </article>
            </template>
        )
    } */
}

{/* {{{    renderedCallback() {
}}}}
        console.log(this.pokemon.Types__c);
        try {
            this.separarTipos(this.pokemon.Types__c);
            this.tiposSeparados.forEach(type => {
                const typeElementText = document.createElement("span")
                typeElementText.textContent = type;
                this.pokeTypes.appendChild(typeElementText);})
        } catch (error) {
            console.log('Este error es del catch'+ error)
        }


     separateTypes( pokemon){
        aux = pokemon.Types__c;
        separatedTypes = aux.split(";");
        for (let index = 0; index < separatedTypes.length; index++) {
            let type = separatedTypes[index];
            htmlType += `<span class="type">${type}</span>`
        }
        return htmlType;            
        
    }
    createTypes(){
        document.getElementById("type").innerHTML = separateTypes(pokemon);
    }  */}
