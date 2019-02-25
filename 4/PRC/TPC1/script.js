const xml = require("xml-parse");
var fs = require('fs')
var parser = require('xml2json')


//Script que cria um novo ficheiro .json com novos IDs em 
//todos os ficheiros
fs.readFile('jcrpubs.xml', 'utf8', function(erro, file){
    if(!erro){
        var output = ""
        var json = parser.toJson(file) 
        ficheiro = JSON.parse(json)
        console.log(ficheiro)
        
        ficheiro.bibliography.inbook.forEach(function(book){
            var bookName = book.id;
            output += book.id + "\n"
            console.log(book)
            console.log(bookName)
        })

        fs.writeFileSync('jcrpubs.ttl', output, function(err){
            if(err){
                return console.log(err)
            }
        })

        console.log(output)
         
        /*// Invalid XML string
        var parsedInavlidXML = xml.parse('<root></root>' +
                                         '<secondRoot>' +
                                           '<notClosedTag>' +
                                         '</secondRoot>');
        console.log(parsedInavlidXML);
        ficheiro = JSON.parse(data)*/
        
    }
    else{
        throw err
    }
})
