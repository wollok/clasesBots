class Imagen {
	var property nombre
	var property tamanio

}

class Tweet {
	var texto
	var imagen
	var usuario

	method texto(){
		return texto;
	}
	method usuario(){
		return usuario;
	}
	method contiene(palabra){
		return texto.contains(palabra)
	}
	method esDemasiadoLargo(){
		return texto.size() > 15
	}
	
	method aQuienSeDirige(){	
		return texto.filter({palabra => palabra.startsWith("@")}).first()	
	}	

 	method esALaNada(){
		return self.aQuienSeDirige() == ""
	}
}

object pdpwitter { 
	var property tweets  = []
	var bots = [benito, 
		new BotPublicitario(palabra = 'empanadas', link = 'www.google.com', nombre = 'soloEmpanadas', imagen = new Imagen(nombre = 'hola', tamanio = 120) )
		]	
	method recibirTweet(tweet){
		if(tweet.esDemasiadoLargo()){
			self.error("Tweet demasiado largo")
		}
		tweets.add(tweet)
		self.botsParaResponder(tweet).forEach({ bot => bot.responder(tweet)})
	}
	
	method agregarBot(bot){
		bots.add(bot)
	}
	
	method botsParaResponder(tweet){
		return bots.filter({bot=>bot.cumpleCondiciones(tweet)})
	}
	method tweetsParaUsuario(usuario){
		return tweets.filter({tweet => tweet.contiene("@" + usuario)})	
	}	
	
	method tweetsALaNada(){
		return tweets.filter({ tweet=> tweet.esALaNada() })
	}
}

object policia {
	var property tweetsIlegales = []
	method guardarTweet(tweet){
		tweetsIlegales.add(tweet)
	}
}

object benito {	
	const palabras = ['droga', 'falopa']
	method cumpleCondiciones(tweet){
		return palabras.any({ palabra => tweet.contiene(palabra) })
	}
	method responder(tweet){
		policia.guardarTweet(tweet)			
	}
}

class BotPublicitario {
	var palabra
	var link
	var nombre
	var imagen
	
	method cumpleCondiciones(tweet){
		return tweet.contiene(palabra)
	}
	method responder(tweet){
		pdpwitter.recibirTweet(new Tweet(texto = ['@' + tweet.usuario(), link], imagen = imagen, usuario = nombre))	
	}
}


class BotAnalista {
	var tweets = []
	method cumpleCondiciones(tweet){
		return true
	}
	method responder(tweet){
		tweets.add(tweet)
	}
	method tweets(){
		return tweets
	}
}
