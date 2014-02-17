require 'spec_helper'

describe "Editing todo items" do
  let!(:todo_list) { TodoList.create(title: "Grocery list",
                                      description: "Groceries are plenty") }
  let!(:todo_item) { todo_list.todo_items.create(content: "Lots of milk") }

  it "Is successful with valid content" do
    visit_todo_list(todo_list)
    within("#todo_item_#{todo_item.id}") do
      click_link "Edit"
    end
    fill_in "Content", with: "Lots of milk"
    click_button "Save"
    expect(page).to have_content("Saved this list item")
    todo_item.reload
    expect(todo_item.content).to eq("Lots of milk")
  end

  it "Is unsuccessful with no content" do
    visit_todo_list(todo_list)
    within("#todo_item_#{todo_item.id}") do
      click_link "Edit"
    end
    fill_in "Content", with: ""
    click_button "Save"
    expect(page).to_not have_content("Saved this list item")
    expect(page).to have_content("Content can't be blank")
    todo_item.reload
    expect(todo_item.content).to eq("Lots of milk")
  end

  it "Is unsuccessful with not enough content" do
    visit_todo_list(todo_list)
    within("#todo_item_#{todo_item.id}") do
      click_link "Edit"
    end
    fill_in "Content", with: "2-"
    click_button "Save"
    expect(page).to_not have_content("Saved this list item")
    expect(page).to have_content("Content is too short")
    todo_item.reload
    expect(todo_item.content).to eq("Lots of milk")
  end

end