var http = require('http')
var url = require('url')

http.createServer((req,res)=>{
	res.writeHead(200, {'Content-Type': 'text/html'});
	var purl = url.parse(req.url, true)
	console.log(purl)
	var q = purl.query
	var r = parseInt(q.a, 10) + parseInt(q.b, 10)
	var txt = q.a + " + " + q.b + " = " + r
	res.write(r)
	res.end()
}).listen(4002,()=>{
	console.log('Servidor à escuta na porta 4002...')
})
