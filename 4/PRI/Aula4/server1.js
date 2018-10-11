var http = require('http')
var meta = require('./mymod')

http.createServer((req,res)=>{
	res.writeHead(200, {'Content Type': 'text/html'})
	res.write('Criada com o node.js por'+meta.myName()+'em'+meta.myDate())
	res.end()
}).listen(4001,()=>{
	console.log('Servidor à escuta na porta 4001...')
})
