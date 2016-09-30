import bots.*
object fixture {
	method tweetValido(usuario) {
		return new Tweet(['@' + usuario], new Imagen('hola2', 100), "hola")
	}
	method tweetLargo() {
		return new Tweet(
			['a', 'b', 'c', 'd','e','f','g','h','i','j','k','l','m','n','o','p'], 
            new Imagen('hola2', 100),
             "hola")
	}
    method botAnalista(){
    	return new BotAnalista()
    }

}