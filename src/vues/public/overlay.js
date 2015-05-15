 var links = document.querySelectorAll('[data-im]');
            lien = links.length;

        for (var i = 0 ; i < lien ; i++) {

            links[i].onclick = function() { !
                affichage(this);           
                return false;               
            };

        }

function affichage(link) {

	var img = new Image(),
		overlay = document.getElementById('overlay');

	img.onload = function() {
		overlay.innerHTML = '';
		/* une fois charger n'affiche plus en chargement*/
		overlay.appendChild(img);
		/*affiche l'image*/
	};

	img.src = link.href;
	overlay.style.display = 'block';
	overlay.innerHTML = 'en chargement';

}
        
/*récupère le clique sur l'image de l'overlay pour revenir au visuel précedent en passant le display a none*/
document.getElementById('overlay').onclick = function() {
	document.getElementById('overlay').style.display= 'none';
//overlay.removechild(img);
//document.getElementById('overlay').style.visibilty= 'hidden';
document.getOverrideStyle('overlay').onclick='none';
};
/*
(function() {
//Selection du noeud 

var myNode = document.querySelector('#artlist .pixgrid ul');
		myNode.addEventListener("click", function(e) { 
		
// la cible est une balise img 
		if (e.target.tagName === 'IMG') {
		//console.log(e);
		var monOverlay = document.createElement('div'); 
		monOverlay.id = 'overlay'; 
		document.body.appendChild(monOverlay);
	*/	
