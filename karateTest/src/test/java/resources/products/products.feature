Feature: API Testing

  Background:
    * def data = read('./test.json');

  @products
  Scenario: verify API response status
    Given url "http://localhost:3000/api/products"
    When method GET
    Then status 200
    Then print "Hey its me: ",data.Name
    And match $ contains {"_id":#notnull,"productName": #notnull,"price": #notnull, "productImage": #notnull,"__v":#notnull}


  @Login
  Scenario:Verify login
    Given url "http://localhost:3000/api/login"
    And request {"userName":"sai_m","password":"wolverine3"}
    When method POST
    Then status 200
    And match $ contains "Login Successful"

  @ChangePassword
  Scenario: Verify change password
    *def token
    Given url "http://localhost:3000/api/login"
    And request {"userName":"sai_m","password":"wolverine3"}
    When method POST
    Then status 200
    #And match $ contains "Login Successful"
    And def token = response
    Given url "http://localhost:3000/api/changePassword"
    And request {"userName":"sai_m","newPassword":"wolverine3"}
    And header auth = token
    When method POST
    Then status 200
    And match response.userName == 'sai_m'
    
    @users
    Scenario: get users
      Given url "http://localhost:3000/api/users"
      When method GET
      Then status 200
      And match response[*].firstName contains ['kittu', 'sai']
      Given path response[0]._id
      When method GET
      Then status 200
      And match response.userName == "kittu_kk"
