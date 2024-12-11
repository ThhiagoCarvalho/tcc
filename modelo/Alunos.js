const Banco = require("./Banco")

module.exports = class Aluno {

    constructor() { 
        this._matricula = null
        this._nome = ""
        this._turma = ""
        this._nascimento = null
    }

    async getAluno ()  {
         const conexao = Banco.getconexao()
        const mysql = "select * from Aluno where matricula =  ? "
           
        try {
            const [result] = await conexao.promise().execute(mysql , [this._matricula])
            return result;
        }catch(error) {
            console.log("Erro >>"  + error)
        }
    } 

    async createFromCsv () {
        const conexao = Banco.getconexao()
        const mysql = "insert into Aluno (matricula,nome,turma,nascimento) values (?,?,?,?)"
        
        try {
            const [result] = await conexao.promise().execute(mysql , [this._matricula, this._nome, this._turma,this._nascimento])
            return result.affectedRows > 0;
        }catch(error) {
            console.log("Erro >>"  + error)
        }
    }

    get matricula() {
        return this._matricula;
    }
    
    set matricula(valor) {
        this._matricula = valor;
    }
    
    get nome() {
        return this._nome;
    }
    
    set nome(valor) {
          this._nome = valor;
    }
    
    get turma() {
        return this._turma;
    }
    
    set turma(valor) {
        this._turma = valor;
    }
    
    get nascimento() {
        return this._nascimento;
    }
    
    set nascimento(valor) {
        this._nascimento = new Date(valor) ;

    }
    
}