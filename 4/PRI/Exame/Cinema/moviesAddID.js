var fs = require('fs')

//Script que cria um novo ficheiro .json com novos IDs em 
//todos os ficheiros
fs.readFile('movies.json', 'utf8', function(erro, data){
    if(!erro){
        ficheiro = JSON.parse(data)
        for(let i = 1; i < ficheiro.length; i++){
            ficheiro[i]["id"] = "F" + i
        }
        console.log(JSON.stringify(ficheiro))
    }
    else{
        throw err
    }
})