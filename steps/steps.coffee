module.exports = ->

  @Given /^I view todomvc$/, ->
    @driver.get("http://todomvc.com/labs/architecture-examples/backbone_marionette/")

  @When /^I add a todo "([^"]*)"$/, (text) ->
    todo = new this.Widgets.TodoApp()
    todo.addTodo(text)

  @When /^I complete the "([^\"]*)" todo$/, (count) ->
    todoList = new this.Widgets.TodoList()
    todoList.getItem(count).then (item) ->
      item.check()

  @When /^I click on the completed link$/, ->
    new this.Widgets.TodoApp().filterByCompleted()

  @When /^I click on the active link$/, ->
    new this.Widgets.TodoApp().filterByActive()

  @Then /^I should see "([^"]*)" todos$/, (count)  ->
    todoList = new this.Widgets.TodoList()
    todoList.numShown().should.eventually.have.length(+count)

  @Then /^I should see the "([^"]*)" todo checked$/, (count) ->
    todoList = new this.Widgets.TodoList()
    todoList.getItem(count).then (item) ->
       item.isChecked().should.eventually.be.true

  @Then /^I should see "([^"]*)" in the footer$/, (text) ->
    todoApp = new this.Widgets.TodoApp()
    todoApp.summaryText().should.eventually.eql(text)
