  Dado('que o usuario consulte informacoes de funcionario') do
    @request = Employee_Requests.new
  end

  Quando('ele realizar a pesquisa') do
    @list_employee = @request.find_employee  #chama o método para fazer um GET na url padrao da API
    puts @list_employee
  end

  Entao('uma lista de funcionarios deve retornar') do
    expect(@list_employee.code).to eql 200    #status code do request
    expect(@list_employee.message).to eql 'OK'
  end

  Dado('que o usuario cadastre um novo funcionario') do
    @request = Employee_Requests.new
  end

  Quando('ele enviar as informacoes do funcionario') do
    @create_employee = @request.create_employee(DATABASE[:name][:name1], DATABASE[:salary][:salary1], DATABASE[:age][:age1])
    puts @create_employee
  end

  Quando('ele enviar informações de funcionario') do
    json = {
      "employee_name": FFaker::NameBR.name,
      "employee_salary": FFaker::Number.between(from: 5000.0, to: 10000.0).ceil(2), #ceil arredonda  rand(5000.0...10000.0).ceil(2)
      "employee_age": rand(20...50),
      "profile_image": ""
  }
  @create_employee = @request.create_employee_json(json)
  end


  Entao('esse funcionario sera cadastrado') do
    expect(@create_employee.code).to eql (200)        #status code do request
    expect(@create_employee.msg).to eql 'OK'
    expect(@create_employee['status']).to eql 'success'   #variável existente no response da requisição
    expect(@create_employee['message']).to eql 'Successfully! Record has been added.'
    expect(@create_employee['data']["employee_name"]).to eql DATABASE[:name][:name1] #campo 'employee_name' do response dentro da chave 'data'
    expect(@create_employee['data']["employee_salary"]).to eql (DATABASE[:salary][:salary1])
    expect(@create_employee['data']["employee_age"]).to eql (DATABASE[:age][:age1])

    puts @create_employee.code
    puts @create_employee.msg                         #impressao na tela apenas para conferir valores
    puts @create_employee["status"]
    puts @create_employee["message"]
    puts @create_employee['data']["employee_name"]
  end

  Dado("que o usuario altere uma informacao de funcionario") do
    @request = Employee_Requests.new
  end

  Quando("ele enviar as novas informacoes") do
    @update_employee = @request.update_employee(@request.find_employee['data'][0]['id'], 'Alberto', 1000, 40)
    puts @update_employee
    #reaproveitando método
    #id é recuperado através do GET no método .find_employee, passando as informações da posição por chave
  end

  Entao("as informacoes serao alteradas") do
    expect(@update_employee.code).to eql (200)
    expect(@update_employee.msg).to eql 'OK'
    expect(@update_employee["status"]).to eql 'success'
    expect(@update_employee["message"]).to eql 'Successfully! Record has been updated.'
    expect(@update_employee['data']["employee_name"]).to eql 'Alberto'
    expect(@update_employee['data']["employee_salary"]).to eql (1000)
    expect(@update_employee['data']["employee_age"]).to eql (40)
  end

  Dado("que um usuario queira deletar um funcionario") do
    @request = Employee_Requests.new
  end

  Quando("ele inserir a identificacao unica") do
    @delete_employee = @request.delete_employee(@request.find_employee['data'][0]['id'])  #reaproveitando método
    puts @delete_employee
  end

  Então("o funcionario sera deletado do sistema") do
    expect(@delete_employee.code).to eql (200)
    expect(@delete_employee.msg).to eql 'OK'
    expect(@delete_employee["status"]).to eql 'success'
    expect(@delete_employee["data"]).to eql '1'
    expect(@delete_employee["message"]).to eql 'Successfully! Record has been deleted'
  end
