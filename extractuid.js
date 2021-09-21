var contacts=document.getElementsByClassName("mat-tooltip-trigger identifier-text ng-star-inserted")
cl=[]
for(var i=0;i<contacts.length;i++){
    cl.push(contacts[i].textContent)
}
var uid=document.getElementsByClassName("mat-cell cdk-cell cdk-column-uid mat-column-uid ng-star-inserted")
ul=[]
for(var i=0;i<uid.length;i++){
    ul.push(uid[i].textContent)
}

var dd={}
for(var i=0;i<contacts.length;i++){
    dd[cl[i]]=ul[i]
}
