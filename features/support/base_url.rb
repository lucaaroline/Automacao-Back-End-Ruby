module Employee 
    include HTTParty                #importação para utilizar os métodos do HTTParty no módulo
    base_uri 'http://dummy.restapiexample.com/api/v1'           #url base padrão da aplicação
    format :json
    headers 'Content-Type': 'application/json'
end
    