import { api, LightningElement, track } from 'lwc';

export default class PokeFilters extends LightningElement {
@api types;
@track tiposSeparados;





connectedCallback(){

    this.tiposSeparados = types.split(";");
    if (this.tiposSeparados.length == 1) {
      const type1 = this.tiposSeparados[0];
      return type1
    } if (this.tiposSeparados.length == 2){
      const type1 = this.tiposSeparados[0];
      const type2 = this.tiposSeparados[1];
      const twoTypes = [type1 + type2]
      return twoTypes
    }

}
}