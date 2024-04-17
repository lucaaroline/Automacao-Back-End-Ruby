  Dado('que o usuario consulte informacoes de funcionario') do
    @get_url = 'http://dummy.restapiexample.com/api/v1/employees'
  end
  
  Quando('ele realizar a pesquisa') do
    @list_employee = HTTParty.get(@get_url)         #vai fazer um get na url da API, indicada pela variável
    puts @list_employee             #'puts' imprime o valor da variável, não é necessário aqui, só pra conferencia mesmo
  end
  
  Entao('uma lista de funcionarios deve retornar') do
    expect(@list_employee.code).to eql 200    #status code do request
    expect(@list_employee.message).to eql 'OK'
  end

  Dado('que o usuario cadastre um novo funcionario') do
    @post_url = 'http://dummy.restapiexample.com/api/v1/create'
  end
  
  Quando('ele enviar as informacoes do funcionario') do    #sempre informar através do header o tipo de formato usado 
    @create_employee = HTTParty.post(@post_url, :headers => {'Content-Type': 'application/json'},  body: { 
      "id": 30,
      "employee_name": "Luiza Caroline",
      "employee_salary": 420800,
      "employee_age": 26,
      "profile_image": ""
  }.to_json)

    puts @create_employee     #puts vai exibir a mensagem de sucesso, assim como exibiria no Postman 
  end
  
  Entao('esse funcionario sera cadastrado') do
    expect(@create_employee.code).to eql (200)        #status code do request
    expect(@create_employee.msg).to eql 'OK'
    expect(@create_employee['status']).to eql 'success'   #variável existente no response da requisição
    expect(@create_employee['message']).to eql 'Successfully! Record has been added.'
    expect(@create_employee['data']["employee_name"]).to eql 'Luiza Caroline' #campo 'employee_name' dentro da chave 'data' - passar o caminho
    expect(@create_employee['data']["employee_salary"]).to eql (420800)
    expect(@create_employee['data']["employee_age"]).to eql (26)

    puts @create_employee.code        
    puts @create_employee.msg                         #impressao na tela apenas para conferir valores
    puts @create_employee["status"]
    puts @create_employee["message"]
    puts @create_employee['data']["employee_name"] 
  end

  Dado("que o usuario altere uma informacao de funcionario") do
    @get_employee = HTTParty.get('http://dummy.restapiexample.com/api/v1/employees', :headers => {'Content-Type': 'application/json'})  #armazenado um get na variavel
    puts @get_employee['data'][0]['id']  #acessando um funcionario atraves do response armazenado na variável 
                           #1a posição
    @put_url = 'http://dummy.restapiexample.com/api/v1/update/' + @get_employee['data'][0]['id'].to_s  #converter para string 
           #complementando a url usando as chaves do get para retornar o valor de id - info ainda chumbada no código
  end                                                           
  
  
  Quando("ele enviar as novas informacoes") do
    @update_employee = HTTParty.put(@put_url, :headers => {'Content-Type': 'application/json'}, body: { 
      "employee_name": "Alberto",
      "employee_salary": 100,
      "employee_age": 35,
      "profile_image": ""
    }.to_json)

    puts(@update_employee)
  end
  
  Entao("as informacoes serao alteradas") do
    expect(@update_employee.code).to eql (200)
    expect(@update_employee.msg).to eql 'OK'
    expect(@update_employee["status"]).to eql 'success'
    expect(@update_employee["message"]).to eql 'Successfully! Record has been updated.'
    expect(@update_employee['data']["employee_name"]).to eql 'Alberto'
    expect(@update_employee['data']["employee_salary"]).to eql (100)
    expect(@update_employee['data']["employee_age"]).to eql (35)
  end

  Dado("que um usuario queira deletar um funcionario") do
    @get_employee = HTTParty.get('http://dummy.restapiexample.com/api/v1/employees', :headers => {'Content-Type': 'application/json'})
    @delete_url = 'http://dummy.restapiexample.com/api/v1/delete/' + @get_employee['data'][0]['id'].to_s 
  end
  
  Quando("ele inserir a identificacao unica") do
    @delete_employee = HTTParty.delete(@delete_url, :headers => {'Content-Type': 'application/json'})
    puts @delete_employee
  end
  
  Então("o funcionario sera deletado do sistema") do
    expect(@delete_employee.code).to eql (200)
    expect(@delete_employee.msg).to eql 'OK'
    expect(@delete_employee["status"]).to eql 'success' 
    expect(@delete_employee["data"]).to eql '27'
    expect(@delete_employee["message"]).to eql 'Successfully! Record has been deleted'
  end

