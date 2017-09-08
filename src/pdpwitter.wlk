class Imagen {
	var nombre
	var tamanio
	constructor(_nombre, _tamanio){
		nombre = _nombre
		tamanio = _tamanio
	}
	
}

class Tweet {
	var texto
	var imagen
	var usuario
	constructor(_texto, _imagen, _usuario){
		texto = _texto
		imagen = _imagen
		usuario = _usuario
	}
	method texto(){
		return texto
	}
	method usuario(){
		return usuario
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
	var tweets = []
	var bots = [benito, 
		new BotPublicitario('empanadas', 'www.google.com', 'soloEmpanadas', new Imagen('hola', 120) )
		]	
	method recibirTweet(tweet){
		if(tweet.esDemasiadoLargo()){
			error.throwWithMessage("Tweet demasiado largo")
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
	method tweets(){
		return tweets
	}
}

object policia {
	var tweetsIlegales = []
	method guardarTweet(tweet){
		tweetsIlegales.add(tweet)
	}
	method tweetsIlegales(){
		return tweetsIlegales
	}
}

object benito {	
	const palabras = ['droga', 'falopa']
	method cumpleCondiciones(tweet){
		return palabras.any({ palabra => tweet.texto().contains(palabra) })
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
	
	constructor(_palabra, _link, _nombre, _imagen	){
		palabra = _palabra
		link = _link
		nombre = _nombre
		imagen = _imagen
	}
	
	method cumpleCondiciones(tweet){
		return tweet.texto().contains(palabra)
	}
	method responder(tweet){
		pdpwitter.recibirTweet(new Tweet(['@' + tweet.usuario(), link], imagen, nombre))	
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
}


