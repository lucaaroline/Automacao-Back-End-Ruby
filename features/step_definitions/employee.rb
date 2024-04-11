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
  
  Quando('ele enviar as informacoes do funcionario') do    #informando o tipo de formato usado através do header 
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
    expect(@create_employee['data']["employee_name"]).to eql 'Luiza Caroline' #campo 'employee_name' dentro da chave 'data' - passar caminho
    expect(@create_employee['data']["employee_salary"]).to eql (420800)
    expect(@create_employee['data']["employee_age"]).to eql (26)

    #impressao na tela para conferir valores
    puts @create_employee.code        
    puts @create_employee.msg
    puts @create_employee["status"]
    puts @create_employee["message"]
    puts @create_employee['data']["employee_name"] 
  end