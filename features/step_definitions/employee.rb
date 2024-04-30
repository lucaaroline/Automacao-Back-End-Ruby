  Dado('que o usuario consulte informacoes de funcionario') do
    @request = Employee_Requests.new
    @assert = Assertions.new
  end

  Quando('ele realizar a pesquisa') do
    @list_employee = @request.find_employee
    puts @list_employee
  end

  Entao('uma lista de funcionarios deve retornar') do
    @assert.request_success(@list_employee.code, @list_employee.message)
  end

  Dado('que o usuario cadastre um novo funcionario') do
    @request = Employee_Requests.new
    @assert = Assertions.new

    @name = FFaker::NameBR.name
    @salary = FFaker::Number.between(from: 5000.0, to: 10000.0).ceil(2)  #ceil arredonda
    @age = rand(20...60).ceil(2)     #funçao nativa do ruby p/ numeros randomicos
    puts @name
    puts @salary
    puts @age
  end

  Quando('ele enviar as informacoes do funcionario') do
    @create_employee = @request.create_employee(@name, @salary, @age)
    puts @create_employee
  end

  Entao('esse funcionario sera cadastrado') do
    @assert.request_success(@create_employee.code, @create_employee.message)
    expect(@create_employee['status']).to eql 'success'   #variável existente no response da requisição
    expect(@create_employee['message']).to eql 'Successfully! Record has been added.'
    expect(@create_employee['data']["employee_name"]).to eql @name #campo 'employee_name' do response dentro da chave 'data'
    expect(@create_employee['data']["employee_salary"]).to eql (@salary)
    expect(@create_employee['data']["employee_age"]).to eql (@age)

    puts @create_employee.code
    puts @create_employee.message
    puts @create_employee["status"]
    puts @create_employee["message"]
    puts @create_employee['data']["employee_name"]
  end

  Dado("que o usuario altere uma informacao de funcionario") do
    @request = Employee_Requests.new
    @assert = Assertions.new
  end

  Quando("ele enviar as novas informacoes") do
    @update_employee = @request.update_employee(@request.find_employee['data'][0]['id'], 'Alberto', 1000, 40)
    puts @update_employee
    #reaproveitando método
    #id é recuperado através do GET no método .find_employee, passando as informações da posição por chave
  end

  Entao("as informacoes serao alteradas") do
    @assert.request_success(@update_employee.code, @update_employee.message)
    expect(@update_employee["status"]).to eql 'success'
    expect(@update_employee["message"]).to eql 'Successfully! Record has been updated.'
    expect(@update_employee['data']["employee_name"]).to eql 'Alberto'
    expect(@update_employee['data']["employee_salary"]).to eql (1000)
    expect(@update_employee['data']["employee_age"]).to eql (40)
  end

  Dado("que um usuario queira deletar um funcionario") do
    @request = Employee_Requests.new
    @assert = Assertions.new
  end

  Quando("ele inserir a identificacao unica") do
    @delete_employee = @request.delete_employee(@request.find_employee['data'][0]['id'])  #reaproveitando método
    puts @delete_employee
  end

  Então("o funcionario sera deletado do sistema") do
    @assert.request_success(@delete_employee.code, @delete_employee.message)
    expect(@delete_employee["status"]).to eql 'success'
    expect(@delete_employee["data"]).to eql '1'
    expect(@delete_employee["message"]).to eql 'Successfully! Record has been deleted'
  end
