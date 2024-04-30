class Assertions
  def request_success(status_code, message)
    expect(status_code).to eql (200)        #status code do request
    expect(message).to eql 'OK'
  end
end
