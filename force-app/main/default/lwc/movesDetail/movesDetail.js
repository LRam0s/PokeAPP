import { LightningElement,api, wire } from 'lwc';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';


const NAME = 'Moves__c.Name'
const EFFECT = 'Moves__c.Effect__c'
const EFFECTCH = 'Moves__c.Effect_chance__c'
const EXTID = 'Moves__c.ExtId__c'
const ACCURACY = 'Moves__c.Accuracy__c'
const POWER = 'Moves__c.Power__c'
const PP = 'Moves__c.Pp__c'
const PRIORITY = 'Moves__c.Priority__c'
const TARGET = 'Moves__c.Target__c'
const TYPE = 'Moves__c.Type__c'



const MOVE_FIELDS = [NAME, EFFECT, EFFECTCH, EXTID, ACCURACY, POWER, PP, PRIORITY, TARGET, TYPE]


export default class MovesDetail extends LightningElement {

@api recordId;
name;
effect;
effectChance;
extId;
accuracy;
power;
pp;
priority;
target;
type;


@wire(getRecord, { recordId: '$recordId', fields: MOVE_FIELDS })
loadMove({error, data}){
    if (error){
        console.log('El error es' + error)
    } else if (data){
        this.name = getFieldValue(data, NAME);
        this.effect = getFieldValue(data, EFFECT);
        this.effectChance = getFieldValue(data, EFFECTCH);
        this.extId = getFieldValue(data, EXTID);
        this.accuracy = getFieldValue(data, ACCURACY);
        if (this.accuracy == null) {
            this.accuracy = 0;            
        }
        this.power = getFieldValue(data, POWER);
        if (this.power == null) {
            this.power = 0;            
        }
        this.pp = getFieldValue(data, PP);
        this.priority = getFieldValue(data, PRIORITY);
        this.target = getFieldValue(data, TARGET);
        this.type = getFieldValue(data, TYPE);


        
    }
}



}