import { LightningElement, api, wire } from 'lwc';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';

const NAME = 'Abilities__c.Name'
const EXTID = 'Abilities__c.ExtId__c'
const EFFECT = 'Abilities__c.Effect__c'

const ABILITY_FIELDS = [NAME, EXTID, EFFECT]

export default class AbilityDetail extends LightningElement {

    @api recordId;
    name;
    effect;
    extId;

    @wire(getRecord, { recordId: '$recordId', fields: ABILITY_FIELDS })
    loadMove({error, data}){
        if (error){
            console.log('El error es' + error)
        } else if (data){
            this.name = getFieldValue(data, NAME);
            this.effect = getFieldValue(data, EFFECT);
            this.extId = getFieldValue(data, EXTID);   
            
        }
    }

}