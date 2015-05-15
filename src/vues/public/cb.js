var test = new Array();
window.addEventListener("load",init,false);
function init() {
var formul = document.getElementById("commande");
var cb = document.getElementsByTagName("input")[3];
if (document.addEventListener){	
	cb.addEventListener('click',function(){valider();},false);

}
	
}	
function valider(){	

	if ((document.forms["0"].nom.value.length < 3 )&& (document.forms["0"].nom.value.length > 30 ) 
		alert("nom invalide"); return false;
	else if(document.forms["0"].prenom.value.length < 3 )&& (document.forms["0"].prenom.value.length > 30 )
		alert("prenom invalide"); return false;
	else if(document.forms["0"].adresse.value.length < 3 )&& (document.forms["0"].adresse.value.length > 70 ) 
		alert("adresse invalide"); return false;
	else if(document.forms["0"].email.value.length < 3 )&& (document.forms["0"].email.value.length > 50 ))
		alert("email invalide"); return false;
	



	else if (document.forms["0"].cb.value.length < 16){
		alert("entrez numero de carte bleue");
		//document.forms["0"].cb.focus();
		return false;
		}
	else{
//vérification carte bleue1
	var x, somme=0;
	var motif = /\d{16}/g;
	var numcarte = document.forms["0"].cb.value;
	if (isNaN(numcarte)){
		alert("entrez un nombre");
		document.forms["0"].cb.value="";
		document.forms["0"].cb.focus();
		return false;
	}
	for (i=0; i < 16;i++){
		x = parseInt(numcarte[i]);
		if (i%2 == 0){ 
			x*=2;
			if (x > 9) x -= 9;
		}
		somme += x;
	}
	alert(somme);
//cle de Luhn
	luhn =  somme - parseInt(numcarte[15]);
	var S = (luhn%10);
	var P = 10- S;
//mauvais numero
	if (somme%10 != 0){
		alert("cb invalide");
		document.forms["0"].cb.value="";
		document.forms["0"].cb.focus();
		return false;
	}
//expression reguliere ne correspond pas
	if (!motif.test(numcarte)){
		alert("cb invalide");
		document.forms["0"].cb.value="";
		document.forms["0"].cb.focus();
		return false;
	}
//cle de Luhn errone
	if (P != numcarte[15]){
		alert("cb invalide");
		document.forms["0"].cb.value="";
		document.forms["0"].cb.focus();
		return false;
	}
	
	}
}

	
 

