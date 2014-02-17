require 'spec_helper'

describe "Delete todo items" do
  let!(:todo_list) { TodoList.create(title: "Grocery list",
                                      description: "Groceries are plenty") }
  let!(:todo_item) { todo_list.todo_items.create(content: "Lots of milk") }

  it "is successful" do
    visit_todo_list(todo_list)
    within "#todo_item_#{todo_item.id}" do
      click_link "Delete"

    end
    expect(page).to have_content("Todo item item was deleted.")
    expect(TodoItem.count).to eq(0)
  end
end